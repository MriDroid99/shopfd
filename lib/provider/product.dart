import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop2/util/constants.dart';

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
    // Product(
    //   id: '1',
    //   title: 'title 1',
    //   description: 'description 1',
    //   imgUrl:
    //       'https://cdn.iconscout.com/icon/free/png-256/flutter-3629369-3032362.png',
    //   price: 100,
    // ),
    // Product(
    //   id: '2',
    //   title: 'title 2',
    //   description: 'description 2',
    //   imgUrl:
    //       'https://cdn.iconscout.com/icon/free/png-256/flutter-3629369-3032362.png',
    //   price: 150,
    // ),
    // Product(
    //   id: '3',
    //   title: 'title 3',
    //   description: 'description 3',
    //   imgUrl:
    //       'https://cdn.iconscout.com/icon/free/png-256/flutter-3629369-3032362.png',
    //   price: 500,
    //   isFav: true,
    // ),
  ];

  List<Product> get prods => [..._prods];

  List<Product> get favProds =>
      _prods.where((element) => element.isFav).toList();

  void toggleFav(String id) {
    _prods.firstWhere((element) => element.id == id).toggleFav();
    notifyListeners();
  }

  Product findById(String id) =>
      _prods.firstWhere((element) => element.id == id);

  Future<void> getData() async {
    String uri = '$url/products.json';

    var response = await get(Uri.parse(uri));
    print(response.body);
  }

  Future<void> addProduct({
    required String title,
    required double price,
    required String description,
    required String imgUrl,
  }) async {
    String uri = '$url/products.json';
    // Post Request
    var response = await post(
      Uri.parse(uri),
      body: json.encode(
        {
          'title': title,
          'price': price.toString(),
          'description': description,
          'imgUrl': imgUrl,
        },
      ),
    );
    _prods.add(
      Product(
        id: json.decode(response.body)['name'],
        title: title,
        price: price,
        description: description,
        imgUrl: imgUrl,
        isFav: false,
      ),
    );
    notifyListeners();
  }

  Future<void> updateProduct({
    required String id,
    required String title,
    required double price,
    required String description,
    required String imgUrl,
  }) async {
    String uri = '$url/products/$id.json';
    await patch(
      Uri.parse(uri),
      body: json.encode(
        {
          'title': title,
          'price': price.toString(),
          'description': description,
          'imgUrl': imgUrl,
        },
      ),
    );
    int updatedIndex = _prods.indexWhere((element) => element.id == id);
    Product prod = Product(
      id: id,
      title: title,
      description: description,
      imgUrl: imgUrl,
      price: price,
    );
    _prods[updatedIndex] = prod;
    notifyListeners();
  }

  Future<void> removeProduct(String id) async {
    String uri = '$url/products/$id.json';
    await delete(Uri.parse(uri));
    _prods.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
