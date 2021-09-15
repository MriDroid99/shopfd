import 'package:flutter/material.dart';

class CartItem with ChangeNotifier {
  String id, title;
  double price;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });
}

class CartItems with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemsCount => _items.length;

  double get totalPrice {
    double total = 0;
    _items.forEach((id, productData) {
      total += productData.price * productData.quantity;
    });
    return total;
  }

  void resetCart() => _items.clear();

  void addItem(String id, String title, double price) {
    if (_items.containsKey(id)) {
      _items.update(
        id,
        (existItem) => CartItem(
          id: id,
          title: title,
          price: price,
          quantity: existItem.quantity + 1,
        ),
      );
    } else {
      _items.addAll(
        {
          id: CartItem(
            id: id,
            title: title,
            price: price,
            quantity: 1,
          ),
        },
      );
    }
    notifyListeners();
  }

  void decreaseQuantity(String id) {
    if (_items[id]!.quantity == 1) {
      _items.remove(id);
    } else {
      _items.update(
        id,
        (existItem) => CartItem(
          id: id,
          title: existItem.title,
          price: existItem.price,
          quantity: existItem.quantity - 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }
}
