import 'package:flutter/material.dart';

import 'models/models.dart';

const kPrimaryColor=Color(0xff09b44d);
const kSecondaryColor=Color(0xffd0f1bb);
const kGrayColor=Color(0xfff6f6f6);
const kWhiteColor=Color(0xffffffff);
const kTextGrayColor=Color(0xff262626);
String userId = '';
late UserData userData;
List<Product> deserts=[];
List<Product> meals=[];
List<Product> mashweyat=[];
List<Product> salad=[];
List<Product> tawagen=[];
late List<CartItem> cartItem;
late List<Product> products;
late Future<List<Category>> categories;
bool checkAddToCart = false;