import 'package:flutter/material.dart';
import 'package:foody_app2/consts.dart';
import 'package:foody_app2/models/models.dart';
import 'package:foody_app2/screens/payment_screen.dart';
import 'package:foody_app2/services.dart';

import '../models/food_model.dart';

double calculateTotalPrice() {
  double totalPrice = 0.0;
  for (int i = 0; i < cartItem.length; i++) {
    totalPrice += cartItem[i].price * cartItem[i].quantity;
  }
  return totalPrice;
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late double totalPrice;

  @override
  void initState() {
    super.initState();
    totalPrice = calculateTotalPrice();
  }

  void updateTotalPrice() {
    setState(() {
      totalPrice = calculateTotalPrice();
    });
  }

  void increaseQuantity(CartItem cart) {
    setState(() {
      cart.quantity++;
      updateTotalPrice();
    });
  }

  void decreaseQuantity(CartItem cart) {
    setState(() {
      if (cart.quantity > 1) {
        cart.quantity--;
        updateTotalPrice();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return buildCartList(cartItem[index], context);
            },
            separatorBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                color: Colors.grey[350],
                height: 1,
              );
            },
            itemCount: cartItem.length,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, -1),
                blurRadius: 10,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: \$${totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement your checkout functionality here
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PaymentScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  // primary: Colors.blue, // Replace with your kPrimaryColor
                  //  onPrimary: Colors.white,
                ),
                child: const Text(
                  'Checkout',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildCartList(CartItem model, context) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(model.productImageUrl),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.productName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2.5,
                        color: Colors.grey.shade300,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            decreaseQuantity(model);
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          model.quantity.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: () {
                            increaseQuantity(model);
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            '\$${model.price.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontSize: 15, color: kPrimaryColor),
                          ),
                          // Add other text widgets for old price and discount if needed
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () async {
                          await ApiService().deleteCartItem(model.cartId);

                          setState(() {
                            cartItem.remove(model);
                          });
                          updateTotalPrice();
                        },
                        icon: const Icon(Icons.shopping_cart,
                            color: kPrimaryColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
