import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/provider/cart.dart';
import 'package:shop2/screen/cart_screen.dart';
import 'package:shop2/screen/favorite_screen.dart';
import 'package:shop2/screen/products_screen.dart';
import 'package:shop2/widget/badge.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _currentIndex = 0;
  late List<Map<String, dynamic>> _pages;
  // List<String> titles = ['Products', 'Favorite'];
  // List<dynamic> bodies = [
  //   const ProductsScreen(),
  //   const FavoriteScreen(),
  // ];

  void _changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {
        'title': 'Products',
        'body': const ProductsScreen(),
      },
      {
        'title': 'Favorite',
        'body': const FavoriteScreen(),
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int count = Provider.of<CartItems>(context).itemsCount;
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_currentIndex]['title']),
        actions: [
          Badge(
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, CartScreen.routeName);
              },
              icon: const Icon(
                Icons.shopping_cart_outlined,
              ),
            ),
            value: count.toString(),
          )
        ],
      ),
      body: _pages[_currentIndex]['body'],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _changeIndex,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }
}
