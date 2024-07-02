import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../consts.dart';
import '../models/models.dart';
import '../services.dart';

class ProductItem extends StatefulWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool color=false;
  @override
  Widget build(BuildContext context) {
    return Container(
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
                    NetworkImage(widget.product.imageUrl),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.product.name,
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
                    "${widget.product.price} ",
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
                await ApiService().addCartItem(CartItem(
                    cartId: 1,
                    productId: widget.product.id,
                    quantity: 1,
                    userId: int.parse(userId),
                    productName: widget.product.name,
                    productImageUrl: widget.product.imageUrl,
                    price: widget.product.price));
                if(checkAddToCart)color = true;
                setState(() {
                });
              },
              style: IconButton.styleFrom(
                backgroundColor: color?Colors.green:Colors.white,
                fixedSize: const Size(30, 30),
              ),
              iconSize: 20,
              icon: const Icon(Iconsax.shopping_cart),
            ),
          )
        ],
      ),
    );
  }
}
