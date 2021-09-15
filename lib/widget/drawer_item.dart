import 'package:flutter/material.dart';

// Screen
import 'package:shop2/screen/manage_products_screen.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                width: double.infinity,
                height: 150,
              ),
              const Positioned(
                child: Text('Menu'),
                bottom: 10,
                left: 10,
              ),
            ],
          ),
          ListTile(
            title: const Text('Products'),
            onTap: () => Navigator.pushReplacementNamed(context, '/'),
          ),
          ListTile(
            title: const Text('Orders'),
            onTap: () =>
                Navigator.pushReplacementNamed(context, '/orders_screen'),
          ),
          ListTile(
            title: const Text('Manage Products'),
            onTap: () => Navigator.pushReplacementNamed(
                context, ManageProductsScreen.routeName),
          ),
        ],
      ),
    );
  }
}