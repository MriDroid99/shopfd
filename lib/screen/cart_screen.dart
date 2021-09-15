import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/provider/cart.dart';
import 'package:shop2/provider/order.dart';
import 'package:shop2/widget/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart_screen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, CartItem> _items = Provider.of<CartItems>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (_, i) => const Divider(
                thickness: 1.5,
                height: 0,
              ),
              itemBuilder: (_, i) => ChangeNotifierProvider.value(
                value: _items.values.toList()[i],
                child: CartItemWidget(_items.keys.toList()[i]),
              ),
              itemCount: _items.length,
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total'),
                  Text(
                    '${Provider.of<CartItems>(context, listen: false).totalPrice}',
                  ),
                ],
              ),
            ),
          ),
          MaterialButton(
              color: Colors.blue,
              minWidth: double.infinity,
              height: 50,
              onPressed: () {
                if (_items.isEmpty) {
                  ScaffoldMessenger.of(context).showMaterialBanner(
                    MaterialBanner(
                      content: const Text('Please add Products'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context)
                                .hideCurrentMaterialBanner();
                          },
                          child: const Text('Ok'),
                        ),
                      ],
                    ),
                  );
                  return;
                }
                Provider.of<Orders>(context, listen: false).addOrder(
                  _items.values.toList(),
                  Provider.of<CartItems>(context, listen: false).totalPrice,
                );
                Provider.of<CartItems>(context, listen: false).resetCart();
                Navigator.of(context).pushReplacementNamed('/orders_screen');
              },
              child: const Text('Order')),
        ],
      ),
    );
  }
}
