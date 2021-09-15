import 'package:flutter/material.dart';
import 'package:shop2/provider/cart.dart';

class Order with ChangeNotifier {
  String id;
  double totalPrice;
  List<CartItem> prods;
  DateTime date;

  Order({
    required this.id,
    required this.totalPrice,
    required this.prods,
    required this.date,
  });
}

class Orders with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  double get totalPrice {
    double total = 0;
    for (var element in _orders) {
      total += element.totalPrice;
    }
    return total;
  }

  void addOrder(List<CartItem> prods, double total) {
    if (prods.isEmpty) {
      return;
    }
    _orders.add(
      Order(
        id: DateTime.now().toString(),
        totalPrice: total,
        prods: prods,
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
