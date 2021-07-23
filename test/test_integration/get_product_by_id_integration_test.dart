import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_app/core/failure/failures.dart';
import 'package:shop_app/data/repositories/data_source.dart';
import 'package:shop_app/data/models/product_model.dart';
import 'package:shop_app/data/repositories/product_repository.dart';
import 'package:shop_app/domain/repositories/product_repository_interface.dart';
import 'package:shop_app/domain/use_cases/get_product_by_id.dart';

class MockFireBaseDataSource extends Mock implements IProductDataSource {}

void main() {
  late IProductRepository repository;
  late IProductDataSource datasource;
  late GetProductById getProductById;

  setUp(() {
    datasource = MockFireBaseDataSource();
    repository = ProductRepository(dataSource: datasource);
    getProductById = GetProductById(repository: repository);
  });

  test('should be return a ProductEntity when pass a valid product id', () async {
    final productId = 1;
    final ProductModel testProduct = ProductModel(
      id: 1,
      name: "Tenis",
      description: "Adidas max tin",
      urlImage: "assets/adidas.jpg",
      price: 299.50,
    );
    when(() => datasource.getProductById(productId)).thenAnswer((_) async => Right(testProduct));

    final productFound = await getProductById(productId: productId);

    expect(Right(testProduct), productFound);
  });

  test('should return an outrangeError when passing a product id below 1.', () async {
    final productId = 0;

    final productFound = await getProductById(productId: productId);

    expect(Left(OutRangeValue()), productFound);
  });

  test('should return an ProductNotFound when passing a invalid product id.', () async {
    final productId = 2;

    when(() => datasource.getProductById(productId)).thenAnswer((_) async => Left(ProductNotFound()));

    final productFound = await getProductById(productId: productId);

    expect(Left(ProductNotFound()), productFound);
  });
}
