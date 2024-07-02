import 'package:flutter/material.dart';
import 'package:foody_app2/consts.dart';
import 'package:foody_app2/services.dart';
import 'package:iconsax/iconsax.dart';

import '../models/food_model.dart';
import '../models/models.dart';

class ProductsView extends StatefulWidget {
  final List<Product> products;

  const ProductsView({super.key, required this.products});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
  bool result=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              widget.products.length,
              (index) => Container(
                margin: const EdgeInsets.only(right: 10),
                width: 200,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image:
                                  NetworkImage(widget.products[index].imageUrl),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          widget.products[index].name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              Iconsax.money_3,
                              size: 18,
                              color: Colors.grey,
                            ),
                            Text(
                              "${widget.products[index].price} ",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Positioned(
                      top: 1,
                      right: 1,
                      child: IconButton(
                        onPressed: () async{
                          result = await ApiService().addCartItem(CartItem(
                              cartId: 1,
                              productId: widget.products[index].id,
                              quantity: 1,
                              userId: int.parse(userId),
                              productName: widget.products[index].name,
                              productImageUrl: widget.products[index].imageUrl,
                              price: widget.products[index].price));

                          setState(() {

                          });
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          fixedSize: const Size(30, 30),
                        ),
                        iconSize: 20,
                        icon: const Icon(Iconsax.shopping_cart),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
