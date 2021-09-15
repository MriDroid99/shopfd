import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/provider/order.dart';
import 'package:shop2/widget/drawer_item.dart';
import 'package:shop2/widget/order_widget.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Order> _orders = Provider.of<Orders>(context).orders;
    return Scaffold(
      drawer: const DrawerItem(),
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemBuilder: (_, i) => ChangeNotifierProvider.value(
                value: _orders[i],
                child: const OrderWidget(),
              ),
              separatorBuilder: (_, i) => const Divider(
                thickness: 1.5,
                height: 0,
              ),
              itemCount: _orders.length,
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
                    '${Provider.of<Orders>(context, listen: false).totalPrice}',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
