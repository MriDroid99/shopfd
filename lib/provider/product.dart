import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:firebase_database/firebase_database.dart';
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

  Future<void> toggleFav() async {
    String uri = '$url/products/$id.json';
    await patch(
      Uri.parse(uri),
      body: json.encode({
        'isFav': !isFav,
      }),
    );
    isFav = !isFav;
    notifyListeners();
  }
}

class Products with ChangeNotifier {
  final String? _uid;
  final String? _token;

  var dbRef = FirebaseDatabase.instance.reference();

  Products({
    String? uid,
    String? token,
    List<Product>? prods,
  })  : _uid = uid,
        _token = token,
        _prods = prods ?? [];

  // https://cdn.iconscout.com/icon/free/png-256/flutter-3629369-3032362.png
  List<Product> _prods = [];

  List<Product> get prods => [..._prods];

  List<Product> get favProds =>
      _prods.where((element) => element.isFav).toList();

  Future<void> toggleFav(String id) async {
    await _prods.firstWhere((element) => element.id == id).toggleFav();
    notifyListeners();
  }

  Product findById(String id) =>
      _prods.firstWhere((element) => element.id == id);

  Future<void> getAllData() async {
    // String uri = '$url/products.json?auth=$_token';

    // var response = await get(Uri.parse(uri));

    var response = await dbRef.child('products').get();

    _prods.clear();
    response.value.forEach((uid, userProd) {
      userProd.forEach(
        (id, data) {
          _prods.add(
            Product(
              id: id,
              title: data['title'],
              description: data['description'],
              imgUrl: data['imgUrl'],
              price: double.parse(data['price']),
              isFav: data['isFav'],
            ),
          );
        },
      );
    });
  }

  Future<void> getUserData() async {
    // String uri = '$url/products/$_uid.json?auth=$_token';

    // var response = await get(Uri.parse(uri));
    // Map<String, dynamic>? extractedData = json.decode(response.body);
    // if (extractedData == null) {
    //   return;
    // }
    // print(extractedData);

    var response = await dbRef.child('products').child('$_uid').get();

    _prods.clear();
    response.value?.forEach(
      (id, data) {
        _prods.add(
          Product(
            id: id,
            title: data['title'],
            description: data['description'],
            imgUrl: data['imgUrl'],
            price: double.parse(data['price']),
            isFav: data['isFav'],
          ),
        );
      },
    );
  }

  Future<void> addProduct({
    required String title,
    required double price,
    required String description,
    required String imgUrl,
  }) async {
    // String uri = '$url/products/$_uid.json?auth=$_token';
    // // Post Request
    // var response = await post(
    //   Uri.parse(uri),
    //   body: json.encode(
    //     {
    //       'title': title,
    //       'price': price.toString(),
    //       'description': description,
    //       'imgUrl': imgUrl,
    //       'isFav': false,
    //     },
    //   ),
    // );
    var response = dbRef.child('products').child('$_uid').push();
    await response.set({
      'title': title,
      'price': price.toString(),
      'description': description,
      'imgUrl': imgUrl,
      'isFav': false,
    });
    _prods.add(
      Product(
        id: response.key,
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
    // String uri = '$url/products/$_uid/$id.json?auth=$_token';
    // await patch(
    //   Uri.parse(uri),
    //   body: json.encode(
    //     {
    //       'title': title,
    //       'price': price.toString(),
    //       'description': description,
    //       'imgUrl': imgUrl,
    //     },
    //   ),
    // );
    var response = dbRef.child('products').child('$_uid').child(id);
    await response.update(
      {
        'title': title,
        'price': price.toString(),
        'description': description,
        'imgUrl': imgUrl,
      },
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
    // String uri = '$url/products/$_uid/$id.json?auth=$_token';
    // await delete(Uri.parse(uri));
    var response = dbRef.child('products').child('$_uid').child(id);
    response.remove;
    _prods.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
