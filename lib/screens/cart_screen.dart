import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Map<String, dynamic>> cartItems = [];
  bool isLoading = true;
  final int userId = 1; // sample userId

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    try {
      final cartResponse = await http.get(
        Uri.parse('https://fakestoreapi.com/carts'),
      );

      if (cartResponse.statusCode == 200) {
        final List<dynamic> carts = jsonDecode(cartResponse.body);

        // Filter cart by userId (just first match for now)
        final userCart = carts.firstWhere(
          (cart) => cart['userId'] == userId,
          orElse: () => null,
        );

        if (userCart == null) {
          setState(() {
            isLoading = false;
            cartItems = [];
          });
          return;
        }

        final List<dynamic> products = userCart['products'];
        final List<Map<String, dynamic>> detailedItems = [];

        for (var item in products) {
          final productId = item['productId'];
          final quantity = item['quantity'];

          final productResponse = await http.get(
            Uri.parse('https://fakestoreapi.com/products/$productId'),
          );

          if (productResponse.statusCode == 200) {
            final product = jsonDecode(productResponse.body);
            product['quantity'] = quantity;
            detailedItems.add(product);
          }
        }

        setState(() {
          cartItems = detailedItems;
          isLoading = false;
        });
      } else {
        throw Exception("Failed to fetch cart");
      }
    } catch (e) {
      debugPrint("Error fetching cart: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : cartItems.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  leading: Image.network(item['image'], width: 50, height: 50),
                  title: Text(item['title']),
                  subtitle: Text(
                    'Quantity: ${item['quantity']} • \$${item['price']} each',
                  ),
                  trailing: Text(
                    '\$${(item['price'] * item['quantity']).toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
    );
  }
}
