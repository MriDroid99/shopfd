import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Provider
import 'package:shop2/provider/product.dart';
import 'package:shop2/screen/add_product_screen.dart';

// Widget
import 'package:shop2/widget/drawer_item.dart';
import 'package:shop2/widget/manage_product_item.dart';

class ManageProductsScreen extends StatelessWidget {
  static const routeName = '/manage_products_screen';
  const ManageProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Product> _prods = Provider.of<Products>(context).prods;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
      ),
      drawer: const DrawerItem(),
      body: ListView.separated(
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: _prods[i],
          child: const ManageProductItem(),
        ),
        separatorBuilder: (ctx, i) => const Divider(
          thickness: 1.5,
          height: 0,
        ),
        itemCount: _prods.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(context, AddProductScreen.routeName),
        child: const Icon(Icons.add),
      ),
    );
  }
}
