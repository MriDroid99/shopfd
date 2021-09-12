import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop2/provider/cart.dart';
import 'package:shop2/provider/product.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Product _prod = Provider.of(context);
    return GridTile(
      child: Image.network(_prod.imgUrl),
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        leading: IconButton(
          onPressed: () {
            Provider.of<CartItems>(context, listen: false).addItem(
              _prod.id,
              _prod.title,
              _prod.price,
            );
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 1),
                content: Text(
                  '${_prod.title} add to cart!',
                ),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () =>
                      Provider.of<CartItems>(context, listen: false)
                          .decreaseQuantity(_prod.id),
                ),
              ),
            );
          },
          icon: const Icon(
            Icons.add_shopping_cart,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            Provider.of<Products>(context, listen: false).toggleFav(_prod.id);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  _prod.isFav
                      ? '${_prod.title} add to favorite!'
                      : '${_prod.title} removed from favorite!',
                ),
              ),
            );
          },
          icon: Icon(
            _prod.isFav ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
        ),
        title: Center(child: Text(_prod.title)),
      ),
    );
  }
}
