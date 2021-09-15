import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shop2/provider/order.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  // bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    Order _order = Provider.of<Order>(context);
    return ExpansionTile(
      title: Text('${_order.totalPrice}'),
      subtitle: Text(
        DateFormat.yMMMd().format(_order.date),
      ),
      children: _order.prods
          .map(
            (e) => ListTile(
              title: Text(e.title),
              trailing: Text('${e.price}x${e.quantity}'),
            ),
          )
          .toList(),
    );
    // Column(
    //   children: [
    //     ListTile(
    //       title: Text('${_order.totalPrice}'),
    //       subtitle: Text(
    //         DateFormat.yMMMd().format(_order.date),
    //       ),
    //       trailing: IconButton(
    //         onPressed: () {
    //           setState(() {
    //             _isExpanded = !_isExpanded;
    //           });
    //         },
    //         icon: Icon(
    //           _isExpanded ? Icons.expand_less : Icons.expand_more,
    //         ),
    //       ),
    //     ),
    //     if (_isExpanded)
    //       Container(
    //         padding: const EdgeInsets.all(10),
    //         height: min(250, _order.prods.length * 60),
    //         child: ListView.builder(
    //           itemBuilder: (_, i) => ListTile(
    //             title: Text(_order.prods[i].title),
    //             trailing: Text(
    //                 '${_order.prods[i].price}x${_order.prods[i].quantity}'),
    //           ),
    //           itemCount: _order.prods.length,
    //         ),
    //       ),
    //   ],
    // );
  }
}
