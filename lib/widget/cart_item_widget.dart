import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/provider/cart.dart';

class CartItemWidget extends StatelessWidget {
  final String id;
  const CartItemWidget(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartItem _item = Provider.of(context);
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) =>
          Provider.of<CartItems>(context, listen: false).removeItem(id),
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
      ),
      child: ListTile(
        title: Text(_item.title),
        subtitle: Text('${_item.price * _item.quantity}'),
        trailing: Text('${_item.price.round()}x${_item.quantity}'),
      ),
    );
  }
}
