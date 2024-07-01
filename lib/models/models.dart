
class UserData {
  final String name;
  final String phoneNumber;

  UserData({
    required this.name,
    required this.phoneNumber,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['userName'],
      phoneNumber: json['phoneNumber']??'',
    );
  }
}

class RegisterRequest {
  final String email;
  final String password;
  final String confirmPassword;
  final String phoneNumber;
  final String address;
  final String userName;

  RegisterRequest({
    required this.email,
    required this.password,
    required this.confirmPassword,

    required this.phoneNumber,
    required this.address,
    required this.userName,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'confirmPassword': confirmPassword,
    'phoneNumber': phoneNumber,
    'address': address,
    'userName': userName,
  };
}

class AuthResponse {
  final bool flag;
  final String message;
  final int statusCode;
  final String token;

  AuthResponse({
    required this.flag,
    required this.message,
    required this.statusCode,
    required this.token,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      flag: json['flag'] ?? false,
      message: json['message'] ?? '',
      statusCode: json['statusCode'] ?? 0,
      token: json['token'],
    );
  }
}



class LoginRequest {
  String email;
  String password;

  LoginRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
  };
}
class Product {
  final int id;
  final String name;
  final double price;
  final String description;
  final String category;
  final int categoryId;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.categoryId,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['productId'],
      name: json['name'],
      price: json['price'].toDouble(),
      description: json['description'],
      category: json['category']??'',
      categoryId: json['categoryId'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'category': category,
      'imageUrl': imageUrl,
    };
  }
}
class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['categoryId'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Payment {
  int id;
  double amount;
  String method;

  Payment({
    required this.id,
    required this.amount,
    required this.method,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    id: json['id'],
    amount: json['amount'],
    method: json['method'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'amount': amount,
    'method': method,
  };
}


class Order {
  int id;
  List<Product> products;
  double totalAmount;

  Order({
    required this.id,
    required this.products,
    required this.totalAmount,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json['id'],
    products: (json['products'] as List)
        .map((item) => Product.fromJson(item))
        .toList(),
    totalAmount: json['totalAmount'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'products': products.map((item) => item.toJson()).toList(),
    'totalAmount': totalAmount,
  };
}


class CartItem {
  int cartId;
  int productId;
  int userId;
  int quantity;
  String productName;
  String productImageUrl;
  double productSalary;

  CartItem({
    required this.cartId,
    required this.productId,
    required this.quantity,
    required this.userId,
    required this.productName,
    required this.productImageUrl,
    required this.productSalary,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    cartId: json['cartId'],
    userId: json['userId'],
    productId:json['productId'],
    quantity: json['quantity'],
    productName: json['productName'],
    productImageUrl: json['productImageUrl'],
    productSalary: json['productSalary'],
  );
}
