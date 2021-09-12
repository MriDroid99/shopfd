import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  String id, title, description, imgUrl;
  double price;
  bool isFav;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imgUrl,
    required this.price,
    this.isFav = false,
  });

  void toggleFav() {
    isFav = !isFav;
    notifyListeners();
  }
}

class Products with ChangeNotifier {
  final List<Product> _prods = [
    Product(
      id: '1',
      title: 'title 1',
      description: 'description 1',
      imgUrl:
          'https://cdn.iconscout.com/icon/free/png-256/flutter-3629369-3032362.png',
      price: 100,
    ),
    Product(
      id: '2',
      title: 'title 2',
      description: 'description 2',
      imgUrl:
          'https://cdn.iconscout.com/icon/free/png-256/flutter-3629369-3032362.png',
      price: 150,
    ),
    Product(
      id: '3',
      title: 'title 3',
      description: 'description 3',
      imgUrl:
          'https://cdn.iconscout.com/icon/free/png-256/flutter-3629369-3032362.png',
      price: 500,
      isFav: true,
    ),
  ];

  List<Product> get prods => [..._prods];

  List<Product> get favProds =>
      _prods.where((element) => element.isFav).toList();

  void toggleFav(String id) {
    _prods.firstWhere((element) => element.id == id).toggleFav();
    notifyListeners();
  }
}
