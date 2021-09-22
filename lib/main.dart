import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/provider/auth.dart';
import 'package:shop2/provider/cart.dart';
import 'package:shop2/provider/order.dart';
import 'package:shop2/provider/product.dart';
import 'package:shop2/screen/add_product_screen.dart';
import 'package:shop2/screen/auth_screen.dart';
import 'package:shop2/screen/cart_screen.dart';
import 'package:shop2/screen/manage_products_screen.dart';
import 'package:shop2/screen/orders_screen.dart';
import 'package:shop2/screen/tab_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: CartItems()),
        // ChangeNotifierProvider.value(value: Products()),
        // ChangeNotifierProvider.value(value: Orders()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => Orders(),
          update: (_, auth, oldOrders) => Orders(
            uid: auth.uid,
            token: auth.token,
            orders: oldOrders?.orders,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(),
          update: (_, auth, oldProducts) => Products(
            uid: auth.uid,
            token: auth.token,
            prods: oldProducts?.prods ?? [],
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              minimumSize: MaterialStateProperty.all<Size>(
                const Size(double.infinity, 50),
              ),
            ),
          ),
        ),
        home: Consumer<Auth>(
          builder: (_, auth, child) => FutureBuilder(
            future: auth.getDataFromsPref(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (auth.token == null) {
                  return const AuthScreen();
                } else {
                  return const TabScreen();
                }
              }
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
        routes: {
          '/auth_screen': (_) => const AuthScreen(),
          '/tab_screen': (_) => const TabScreen(),
          CartScreen.routeName: (_) => const CartScreen(),
          ManageProductsScreen.routeName: (_) => const ManageProductsScreen(),
          AddProductScreen.routeName: (_) => const AddProductScreen(),
          '/orders_screen': (_) => const OrdersScreen(),
        },
      ),
    );
  }
}

// Lints