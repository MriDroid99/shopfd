import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/provider/product.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = '/add_product_screen';
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  bool _isFirst = true;
  Map<String, dynamic>? _args;
  final GlobalKey<FormState> _formKey = GlobalKey();
  Product prod = Product(
    id: '',
    title: '',
    description: '',
    imgUrl: '',
    price: 0.0,
  );

  void onSave() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    if (_args == null) {
      Provider.of<Products>(context, listen: false).addProduct(
        title: prod.title,
        price: prod.price,
        description: prod.description,
        imgUrl: prod.imgUrl,
      );
    } else {
      Provider.of<Products>(context, listen: false).updateProduct(
        id: _args!['id'],
        title: prod.title,
        price: prod.price,
        description: prod.description,
        imgUrl: prod.imgUrl,
      );
    }
    Navigator.pop(context);
  }

  @override
  void didChangeDependencies() {
    if (_isFirst) {
      _args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      if (_args != null) {
        Product _existedProd = Provider.of<Products>(context, listen: false)
            .findById(_args!['id']);
        prod = _existedProd;
      }
      _isFirst = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_args == null ? 'Add Product' : 'Edit Product'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  TextFormField(
                    initialValue: prod.title,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                    ),
                    keyboardType: TextInputType.text,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Product Title can not be empty';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      prod.title = val!;
                    },
                  ),
                  TextFormField(
                    initialValue: prod.price.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Price',
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Product Price can not be empty';
                      } else if (double.parse(val) <= 0) {
                        return 'Please Enter Valid price';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) {
                      prod.price = double.parse(val!);
                    },
                  ),
                  TextFormField(
                    initialValue: prod.description,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                    ),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Product Description can not be empty';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      prod.description = val!;
                    },
                  ),
                  TextFormField(
                    initialValue: prod.imgUrl,
                    decoration: const InputDecoration(
                      labelText: 'Image URL',
                    ),
                    keyboardType: TextInputType.url,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Product URL can not be empty';
                      } else if (!val.startsWith('http')) {
                        return 'Please enter a valid URL';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) {
                      prod.imgUrl = val!;
                    },
                  ),
                ],
              ),
            ),
          ),
          MaterialButton(
            onPressed: onSave,
            child: Text(_args == null ? 'Add Product' : 'Edit Product'),
            color: Theme.of(context).primaryColor,
            minWidth: double.infinity,
            height: 50,
          ),
        ],
      ),
    );
  }
}
