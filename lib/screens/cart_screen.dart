import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/product.dart';
import "./checkout_screen.dart";

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);     

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: cartProvider.cartItems == null || cartProvider.cartItems!.isEmpty
          ? Center(child: Text('Your cart is empty.'))
          : ListView.builder(
              itemCount: cartProvider.cartItems!.length,
              itemBuilder: (context, index) {
                Product product = cartProvider.cartItems![index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(product.image),
                  ),
                  title: Text(product.title),
                  subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      cartProvider.removeFromCart(product);
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: \$${cartProvider.getTotalPrice().toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                   Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckoutScreen()),
                );
                  print('Checkout button pressed');
                   
                },
                child: Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}