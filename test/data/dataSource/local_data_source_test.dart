import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_app/core/failure/failures.dart';
import 'package:shop_app/data/data_source/data_source.dart';
import 'package:shop_app/data/models/product_model.dart';

class MockFireBaseDataSource extends Mock implements IProductDataSource {}

void main() {
  late IProductDataSource datasource;

  setUp(() {
    datasource = MockFireBaseDataSource();
  });

  test('should return a product with the same ProductId', () async {
    final int productId = 1;
    final ProductModel testProduct = ProductModel(
      id: 1,
      name: "Tenis",
      description: "Adidas max tin",
      urlImage: "assets/adidas.jpg",
      price: 299.50,
    );

    when(() => datasource.getProductById(productId)).thenAnswer((_) async => Right(testProduct));

    final product = await datasource.getProductById(productId);

    expect(Right(testProduct), product);
  });

  test('should return a failure "productNotFound" when sending an id that doesn\'t exist', () async {
    final int productId = -1;

    when(() => datasource.getProductById(productId)).thenAnswer((_) async => Left(ProductNotFound()));

    final product = await datasource.getProductById(productId);

    expect(Left(ProductNotFound()), product);
  });
}
