import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shop_app/core/failure/failures.dart';
import 'package:shop_app/data/data_source/data_source.dart';
import 'package:shop_app/data/data_source/product_local_data_source.dart';

import 'package:shop_app/data/models/product_model.dart';
import 'package:shop_app/data/repositories/product_repository.dart';
import 'package:shop_app/domain/repositories/product_repository_interface.dart';
import 'package:shop_app/domain/use_cases/get_product_by_id.dart';
import '../mock/mock_products_database.dart';

void main() {
  late IProductRepository repository;
  late IProductDataSource dataSource;
  late GetProductById getProductById;
  late String dataBase;

  setUp(() {
    dataBase = MOCKDBPRODUTOS; //database de testes
    dataSource = ProductLocalDataSource(dataBase: dataBase);
    repository = ProductRepository(dataSource: dataSource);
    getProductById = GetProductById(repository: repository);
  });

  test('should be return a ProductEntity when pass a valid product id', () async {
    final productId = 1;
    final Map<String, Map<String, dynamic>> dbProductsJson = await json.decode(dataBase).cast<String, Map<String, dynamic>>();
    ProductModel product = ProductModel.fromMap(dbProductsJson['$productId']!);

    final productFound = await getProductById(productId: productId);

    expect(Right(product), productFound);
  });

  test('should return an outrangeError when passing a product id below 1.', () async {
    final productId = 0;

    final productFound = await getProductById(productId: productId);

    expect(Left(OutRangeValue()), productFound);
  });

  test('should return an ProductNotFound when passing a invalid product id.', () async {
    final Map<String, Map<String, dynamic>> dbProductsJson = await json.decode(dataBase).cast<String, Map<String, dynamic>>();
    final productId = dbProductsJson.length + 1;

    final productFound = await getProductById(productId: productId);

    expect(Left(ProductNotFound()), productFound);
  });
}
