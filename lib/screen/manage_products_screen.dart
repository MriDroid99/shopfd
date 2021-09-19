import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Provider
import 'package:shop2/provider/product.dart';
import 'package:shop2/screen/add_product_screen.dart';

// Widget
import 'package:shop2/widget/drawer_item.dart';
import 'package:shop2/widget/manage_product_item.dart';

class ManageProductsScreen extends StatefulWidget {
  static const routeName = '/manage_products_screen';
  const ManageProductsScreen({Key? key}) : super(key: key);

  @override
  State<ManageProductsScreen> createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  List<Product> _selectedProd = [];
  List<Product> _prods = [];

  @override
  void didChangeDependencies() {
    _prods = Provider.of<Products>(context).prods;
    _selectedProd = [..._prods];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // List<Product> _prods = Provider.of<Products>(context).prods;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
      ),
      drawer: const DrawerItem(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Product Name',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (val) {
                setState(
                  () {
                    _selectedProd = _prods
                        .where(
                          (element) => element.title
                              .toLowerCase()
                              .contains(val.toLowerCase()),
                        )
                        .toList();
                  },
                );
              },
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                value: _selectedProd[i],
                child: const ManageProductItem(),
              ),
              separatorBuilder: (ctx, i) => const Divider(
                thickness: 1.5,
                height: 0,
              ),
              itemCount: _selectedProd.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(context, AddProductScreen.routeName),
        child: const Icon(Icons.add),
      ),
    );
  }
}
