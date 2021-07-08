import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String urlImage;
  final double price;

  ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.urlImage,
    required this.price,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      description,
      urlImage,
      price,
    ];
  }

  ProductEntity copyWith({
    int? id,
    String? name,
    String? description,
    String? urlImage,
    double? price,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      urlImage: urlImage ?? this.urlImage,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'urlImage': urlImage,
      'price': price,
    };
  }

  factory ProductEntity.fromMap(Map<String, dynamic> map) {
    return ProductEntity(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      urlImage: map['urlImage'],
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductEntity.fromJson(String source) => ProductEntity.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
