import 'package:flutter/material.dart';

class Product {
  final String image, title, description;
  final int price, size, id;
  final Color color;
  Product({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    required this.size,
    required this.color,
  });
}

List<Product> products = [
  Product(id: 1, title: "Relógio D20", price: 85, size: 12, description: dummyText, image: "assets/images/d20_rosa.png", color: Color(0xFFfcdad6)),
  Product(id: 2, title: "Relógio D20", price: 85, size: 8, description: dummyText, image: "assets/images/d20_black.png", color: Color(0xFF989493)),
  Product(id: 3, title: "Relógio P8 Plus", price: 250, size: 12, description: dummyText, image: "assets/images/p8_plus_gold.png", color: Color(0xFFfcdad6)),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
