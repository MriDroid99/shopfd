import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/provider/product.dart';
import 'package:shop2/widget/product_widget.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Product> _prods = Provider.of<Products>(context).prods;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        itemCount: _prods.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 350,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          // childAspectRatio: 3 / 5,
        ),
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: _prods[i],
          child: const ProductWidget(),
        ),
      ),
    );
  }
}
