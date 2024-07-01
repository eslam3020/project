import 'package:flutter/material.dart';
import 'package:foody_app2/consts.dart';
import 'package:foody_app2/widgets/products_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String currentCat = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 20),


                Container(
                  width: double.infinity,
                  height: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/mom's food.png"),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ProductsView(products: deserts,),
                const SizedBox(height: 20),
                 ProductsView(products: meals,),
                const SizedBox(height: 20),
                // const ProductsView(products: ,),
               // Categories(currentCat: currentCat),
               // const SizedBox(height: 20),
               // const QuickAndFastList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

