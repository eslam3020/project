import 'package:flutter/material.dart';
import 'package:foody_app2/consts.dart';
import 'package:foody_app2/models/models.dart';
import 'package:foody_app2/screens/profile_screen.dart';
import 'package:foody_app2/services.dart';
import 'package:iconsax/iconsax.dart';

import 'cart_screen.dart';
import 'home_screen.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int currentTab = 0;
  List screens =  [
    const HomeScreen(),

    const CartScreen(),
    const ProfileScreen(),
  ];

  get kprimaryColor => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => setState(() {
                currentTab = 0;
              }),
              child: Column(
                children: [
                  Icon(
                    currentTab == 0 ? Iconsax.home5 : Iconsax.home,
                    color: currentTab == 0 ? kprimaryColor : Colors.grey,
                  ),
                  Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 14,
                      color: currentTab == 0 ? kprimaryColor : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: () async{
                cartItem=[];
                cartItem = await ApiService().getCartItem(int.parse(userId));
                setState(() {
                currentTab = 1;
              });},
              child: Column(
                children: [
                  Icon(
                    currentTab == 1 ? Iconsax.shopping_cart : Iconsax.shopping_cart5,
                    color: currentTab == 1 ? kprimaryColor : Colors.grey,
                  ),
                  Text(
                    "My cart",
                    style: TextStyle(
                      fontSize: 14,
                      color: currentTab == 1 ? kprimaryColor : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async{
                userData = await ApiService().getUser(userId);
                setState(()  {
                  currentTab = 2;
                });
              },
              child: Column(
                children: [
                  Icon(
                    currentTab == 2 ? Iconsax.profile_tick : Iconsax.profile_tick4,
                    color: currentTab == 2 ? kprimaryColor : Colors.grey,
                  ),
                  Text(
                    "Me",
                    style: TextStyle(
                      fontSize: 14,
                      color: currentTab == 2 ? kprimaryColor : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: screens[currentTab],
    );
  }
}
