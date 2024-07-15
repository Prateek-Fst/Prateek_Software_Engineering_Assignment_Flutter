import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  ProductItem({required this.product, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        product.image,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      title: Text(product.title),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      trailing: IconButton(
        icon: Icon(Icons.add_shopping_cart),
        onPressed: onAddToCart,
      ),
      onTap: () {
        Navigator.pushNamed(
          context,
          '/productDetail',
          arguments: product,
        );
      },
    );
  }
}
