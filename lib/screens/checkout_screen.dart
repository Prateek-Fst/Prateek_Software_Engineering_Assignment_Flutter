import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/product.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shipping Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Full Name',
              ),
              // Implement validation and controller as needed
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Address',
              ),
              // Implement validation and controller as needed
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              // Implement validation and controller as needed
            ),
            SizedBox(height: 20),
            Text(
              'Payment Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Implement payment gateway integration or additional fields as needed
            SizedBox(height: 20),
            Text(
              'Order Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cartProvider.cartItems!.length,
                itemBuilder: (context, index) {
                  Product product = cartProvider.cartItems![index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(product.image),
                    ),
                    title: Text(product.title),
                    subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                    trailing: Text('Qty: ${product.quantity}'),
                  );
                },
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${cartProvider.getTotalPrice().toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Implement logic to place order
                // Example: Call an API to submit order details
                // Navigator.pop(context); // Navigate back to previous screen after order placed
              },
              child: Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}
