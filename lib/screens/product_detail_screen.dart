import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Extract product data passed from arguments
    final Product product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.image,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              product.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            SizedBox(height: 10),
            Text(
              product.description,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
