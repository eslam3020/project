import 'package:flutter/material.dart';
import 'package:foody_app2/models/models.dart';
import 'package:foody_app2/screens/admin_screens/admin_home.dart';

import 'package:foody_app2/screens/on_boarding_screen.dart';
import 'package:foody_app2/services.dart';

import 'consts.dart';

void main() async{
  categories = ApiService().getCategories();
  products = await ApiService().getProducts();
  products.forEach((element) {
    if(element.categoryId==2)
      {
        deserts.add(element);
      }
    if(element.categoryId==3)
    {
      meals.add(element);
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,

      home:  OnBoardingScreen(),
    );
  }
}

