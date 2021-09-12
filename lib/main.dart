import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/provider/cart.dart';
import 'package:shop2/provider/product.dart';
import 'package:shop2/screen/cart_screen.dart';
import 'package:shop2/screen/tab_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: CartItems()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: TabScreen(),
        routes: {
          '/': (_) => const TabScreen(),
          CartScreen.routeName: (_) => const CartScreen(),
        },
      ),
    );
  }
}

// Lints