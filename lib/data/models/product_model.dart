import 'dart:convert';

import 'package:shop_app/domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required int id,
    required String name,
    required String description,
    required String urlImage,
    required double price,
  }) : super(
          id: id,
          name: name,
          description: description,
          urlImage: urlImage,
          price: price,
        );

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      urlImage: map['urlImage'],
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));
}
