import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'https://fakestoreapi.com';

  // Fetch all products
  static Future<List<dynamic>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Fetch product by ID
  static Future<Map<String, dynamic>> fetchProductById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load product');
    }
  }

  // Fetch all carts
  static Future<List<dynamic>> fetchCarts() async {
    final response = await http.get(Uri.parse('$baseUrl/carts'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load carts');
    }
  }

  // Add new cart
  static Future<void> createCart(int userId, int productId) async {
    final body = {
      "userId": userId,
      "date": DateTime.now().toIso8601String(),
      "products": [
        {"productId": productId, "quantity": 1},
      ],
    };

    final response = await http.post(
      Uri.parse('$baseUrl/carts'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to create cart');
    }
  }

  // Update existing cart
  static Future<void> updateCart({
    required int cartId,
    required int userId,
    required List<Map<String, dynamic>> products,
  }) async {
    final body = {
      "userId": userId,
      "date": DateTime.now().toIso8601String(),
      "products": products,
    };

    final response = await http.put(
      Uri.parse('$baseUrl/carts/$cartId'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update cart');
    }
  }
}
