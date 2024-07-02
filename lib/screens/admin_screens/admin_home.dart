
import 'package:flutter/material.dart';


import 'package:iconsax/iconsax.dart';

import '../../consts.dart';
import '../../services.dart';
import '../home_screen.dart';
import 'add_product_screen.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int currentTab = 0;
  List screens =  [
    const HomeScreen(),

    const AddProductScreen(),

  ];

  get kPrimaryColor => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(flex: 1,),
            GestureDetector(
              onTap: () async {
                products = await ApiService().getProducts();
                deserts =[];
                meals =[];
                mashweyat=[];
                salad=[];
                tawagen=[];

                products.forEach((element) {
                  if (element.categoryId == 2) {
                    deserts.add(element);
                  }
                  if (element.categoryId == 3) {
                    meals.add(element);
                  }
                  if(element.categoryId==4)
                  {
                    mashweyat.add(element);
                  }
                  if(element.categoryId==5)
                  {
                    tawagen.add(element);
                  }
                  if(element.categoryId==6)
                  {
                    salad.add(element);
                  }
                });
                setState(() {
                  currentTab = 0;
                });
              },
              child: Column(
                children: [
                  Icon(
                    currentTab == 0 ? Iconsax.home5 : Iconsax.home,
                    color: currentTab == 0 ? kPrimaryColor : Colors.grey,
                  ),
                  Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 14,
                      color: currentTab == 0 ? kPrimaryColor : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(flex: 1,),

            GestureDetector(
              onTap: () => setState(() {
                currentTab = 1;
              }),
              child: Column(
                children: [
                  Icon(
                    currentTab == 1 ? Iconsax.shopping_cart : Iconsax.shopping_cart5,
                    color: currentTab == 1 ? kPrimaryColor : Colors.grey,
                  ),
                  Text(
                    "Add item",
                    style: TextStyle(
                      fontSize: 14,
                      color: currentTab == 1 ? kPrimaryColor : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(flex: 1,)

          ],
        ),
      ),
      body: screens[currentTab],
    );
  }
}
