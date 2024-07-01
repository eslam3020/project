import 'dart:convert';
import 'package:http/http.dart' as http;

import 'models/models.dart';
class ApiService {
  static const String baseUrl = "http://essamgraduationproject.runasp.net/api";

  Future<T> _getRequest<T>(String endpoint, Function(Map<String, dynamic>) fromJson) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      return fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<T>> _getListRequest<T>(String endpoint, Function(Map<String, dynamic>) fromJson) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map<T>((json) => fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<T> _postRequest<T>(String endpoint, dynamic body, Function(Map<String, dynamic>) fromJson) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return fromJson(jsonDecode(response.body));
    } else {
      print(response.statusCode);
      throw Exception('Failed to post data');
    }
  }

  Future<void> _putRequest(String endpoint, dynamic body) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update data');
    }
  }

  Future<void> _deleteRequest(String endpoint) async {
    final response = await http.delete(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete data');
    }
  }

  // Account endpoints
  Future<AuthResponse> registerUser(RegisterRequest request) =>
      _postRequest('Account/Registeration', request, AuthResponse.fromJson);

  Future<AuthResponse> loginUser(LoginRequest request) =>
      _postRequest('Account/login', request.toJson(), AuthResponse.fromJson);
  //get user profile data
  Future<UserData> getUser(String id) =>
      _getRequest('Account/$id', UserData.fromJson);

  // Products endpoints
  Future<List<Product>> getProducts() =>
      _getListRequest('Products', Product.fromJson);

  Future<Product> getProduct(int id) =>
      _getRequest('Products/$id', Product.fromJson);

  Future<bool> createProduct({
    required String name,
    required int price,
    required String imageUrl,
    required int categoryId,
}) async {
    final response = await http.post(
      Uri.parse('$baseUrl/Products'),
      // headers: {'Content-Type': 'application/json'},
      body: {
        "name": name,
        "description": "this is $name",
        "price": price,
        "quantity": 20,
        "imageUrl": imageUrl,
        "isActive": true,
        "createdDate": "2024-06-30T21:43:53.875Z",
        "categoryId": categoryId
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> updateProduct(int id, Product product) =>
      _putRequest('Products/$id', product.toJson());

  Future<void> deleteProduct(int id) =>
      _deleteRequest('Products/$id');

  // Payment endpoints
  Future<List<Payment>> getPayments() =>
      _getListRequest('Payment', Payment.fromJson);

  Future<Payment> getPayment(int id) =>
      _getRequest('Payment/$id', Payment.fromJson);

  Future<Payment> createPayment(Payment payment) =>
      _postRequest('Payment', payment.toJson(), Payment.fromJson);

  Future<void> updatePayment(int id, Payment payment) =>
      _putRequest('Payment/$id', payment.toJson());

  Future<void> deletePayment(int id) =>
      _deleteRequest('Payment/$id');

  // Orders endpoints
  Future<List<Order>> getOrders() =>
      _getListRequest('Order', Order.fromJson);

  Future<Order> getOrder(int id) =>
      _getRequest('Order/$id', Order.fromJson);

  Future<Order> createOrder(Order order) =>
      _postRequest('Order', order.toJson(), Order.fromJson);

  Future<void> updateOrder(int id, Order order) =>
      _putRequest('Order/$id', order.toJson());

  Future<void> deleteOrder(int id) =>
      _deleteRequest('Order/$id');

  // Categories endpoints
  Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/Categories'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<Category> getCategory(int id) =>
      _getRequest('Categories/$id', Category.fromJson);

  Future<Category> createCategory(Category category) =>
      _postRequest('Categories', category.toJson(), Category.fromJson);

  Future<void> updateCategory(int id, Category category) =>
      _putRequest('Categories/$id', category.toJson());

  Future<void> deleteCategory(int id) =>
      _deleteRequest('Categories/$id');

  // Cart endpoints
  Future<List<CartItem>> getCartItems() =>
      _getListRequest('Cart', CartItem.fromJson);

  Future<CartItem> getCartItem(int id) =>
      _getRequest('Cart/$id', CartItem.fromJson);

  Future<CartItem> addCartItem(CartItem cartItem) =>
      _postRequest('Cart', cartItem, CartItem.fromJson);

  Future<void> updateCartItem(int id, CartItem cartItem) =>
      _putRequest('Cart/$id', cartItem);

  Future<void> deleteCartItem(int id) =>
      _deleteRequest('Cart/$id');
}
