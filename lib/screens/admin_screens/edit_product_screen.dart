import 'dart:io';
import 'package:flutter/material.dart';

class DisplayScreen extends StatelessWidget {
  final String name;
  final String price;
  final String description;
  final File image;

  DisplayScreen({
    required this.name,
    required this.price,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display Screen')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: $name', style: TextStyle(fontSize: 20)),
              Text('Price: $price', style: TextStyle(fontSize: 20)),
              Text('Description: $description', style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              Image.file(image),
            ],
          ),
        ),
      ),
    );
  }
}
