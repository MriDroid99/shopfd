import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop2/provider/cart.dart';
import 'package:shop2/util/constants.dart';

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
  final String? _uid;
  final String? _token;

  Orders({String? uid, String? token, List<Order>? orders})
      : _uid = uid,
        _token = token,
        _orders = orders ?? [];

  List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  double get totalPrice {
    double total = 0;
    for (var element in _orders) {
      total += element.totalPrice;
    }
    return total;
  }

  Future<void> getData() async {
    String uri = '$url/orders/$_uid.json?auth=$_token';
    var response = await get(Uri.parse(uri));
    Map<String, dynamic>? extractedData = json.decode(response.body);
    if (extractedData == null) {
      return;
    }
    _orders.clear();
    extractedData.forEach((id, data) {
      _orders.add(
        Order(
          id: id,
          totalPrice: data['totalPrice'],
          prods: (data['prods'] as List<dynamic>)
              .map(
                (prod) => CartItem(
                  id: prod['id'],
                  title: prod['title'],
                  price: double.parse(prod['price']),
                  quantity: prod['quantity'],
                ),
              )
              .toList(),
          date: DateTime.parse(
            data['date'],
          ),
        ),
      );
    });
  }

  Future<void> addOrder(List<CartItem> prods, double total) async {
    if (prods.isEmpty) {
      return;
    }
    String uri = '$url/orders/$_uid.json?auth=$_token';
    var response = await post(
      Uri.parse(uri),
      body: json.encode(
        {
          'totalPrice': total,
          'date': DateTime.now().toIso8601String(),
          // Convert CartItem to Map
          'prods': prods
              .map(
                (prod) => {
                  'id': prod.id,
                  'title': prod.title,
                  'price': prod.price.toString(),
                  'quantity': prod.quantity,
                },
              )
              .toList(),
        },
      ),
    );
    _orders.add(
      Order(
        id: json.decode(response.body)['name'],
        totalPrice: total,
        prods: prods,
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
