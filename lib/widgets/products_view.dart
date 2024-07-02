import 'package:flutter/material.dart';
import 'package:foody_app2/widgets/item.dart';
import '../models/models.dart';

class ProductsView extends StatefulWidget {
  final List<Product> products;

  const ProductsView({super.key, required this.products});

  @override
  State<ProductsView> createState() => _ProductsViewState();
}

class _ProductsViewState extends State<ProductsView> {
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
              (index) => ProductItem(product: widget.products[index]),
            ),
          ),
        ),
      ],
    );
  }
}
