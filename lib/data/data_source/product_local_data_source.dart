import 'dart:convert';
import 'package:shop_app/core/failure/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_app/data/data_source/data_source.dart';
import 'package:shop_app/data/local_database/product_database.dart';
import 'package:shop_app/data/models/product_model.dart';

class ProductLocalDataSource implements IProductDataSource {
  final String dataBase;
  ProductLocalDataSource({required this.dataBase});

  @override
  Future<Either<Failure, ProductModel>> getProductById(int productId) async {
    Map<String, Map<String, dynamic>> dbProductsJson = await json.decode(dataBase).cast<String, Map<String, dynamic>>();

    if (dbProductsJson.containsKey('$productId')) {
      ProductModel productFound = ProductModel.fromMap(dbProductsJson['$productId']!);
      return Right(productFound);
    } else {
      return Left(ProductNotFound());
    }
  }
}
