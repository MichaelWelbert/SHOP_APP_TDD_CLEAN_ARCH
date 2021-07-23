import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_app/core/failure/failures.dart';
import 'package:shop_app/data/repositories/data_source.dart';
import 'package:shop_app/data/models/product_model.dart';
import 'package:shop_app/data/repositories/product_repository.dart';
import 'package:shop_app/domain/repositories/product_repository_interface.dart';

class MockDataSource extends Mock implements IProductDataSource {}

void main() {
  late IProductRepository repository;
  late IProductDataSource dataSource;

  setUp(() {
    dataSource = MockDataSource();
    repository = ProductRepository(dataSource: dataSource);
  });

  final ProductModel testProduct = ProductModel(
    id: 1,
    name: "Tenis",
    description: "Adidas max tin",
    urlImage: "assets/adidas.jpg",
    price: 299.50,
  );
  test("Should return a product when pass a id", () async {
    final int productId = 1;
    when(() => dataSource.getProductById(productId)).thenAnswer((_) async => Right(testProduct));

    final productFould = await repository.getProductId(productId: productId);

    expect(productFould, Right(testProduct));
  });

  test("Should return a productNotFound when pass incorrect id", () async {
    final int productId = -1;
    when(() => dataSource.getProductById(productId)).thenAnswer((_) async => Left(ProductNotFound()));

    final productFould = await repository.getProductId(productId: productId);

    expect(productFould, Left(ProductNotFound()));
  });

  test("Should return all products", () async {
    List<ProductModel> productsTest = [
      ProductModel(id: 1, name: "tenis", description: "adidas style", urlImage: "adidas.jpg", price: 200),
      ProductModel(id: 2, name: "p8 plus", description: "smartwatch top", urlImage: "p8plus.jpg", price: 250),
    ];

    when(() => dataSource.getAllProducts()).thenAnswer((_) async => Right(productsTest));

    final productsFound = await repository.getAllProducts();

    expect(productsFound, Right(productsTest));
  });
}
