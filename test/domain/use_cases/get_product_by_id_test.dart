import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_app/core/failure/failures.dart';
import 'package:shop_app/domain/entities/product_entity.dart';
import 'package:shop_app/domain/repositories/product_repository_interface.dart';
import 'package:shop_app/domain/use_cases/get_product_by_id.dart';

class MockProductRepository extends Mock implements IProductRepository {}

void main() {
  late GetProductById products;
  late IProductRepository repository;

  setUp(() {
    repository = MockProductRepository();
    products = GetProductById(repository: repository);
  });

  test('should return product by id ', () async {
    final int productId = 1;
    final ProductEntity testProduct = ProductEntity(
      id: 1,
      name: "Tenis",
      description: "Adidas max tin",
      urlImage: "assets/adidas.jpg",
      price: 299.50,
    );

    when(() => repository.getProductId(productId: productId)).thenAnswer((_) async => Right(testProduct));

    final productFound = await products(productId: productId);

    expect(productFound, Right(testProduct));
  });

  test('should return Mesage "IdNotFound" when pass value above the max size of the product list', () async {
    final int productId = 50;

    when(() => repository.getProductId(productId: productId)).thenAnswer((_) async => Left(ProductNotFound()));

    final productFound = await products(productId: productId);

    expect(productFound, Left(ProductNotFound()));
  });

  test('should return Mesage "OutRangedId" when passing a value below 0', () async {
    final int productId = -1;

    final productFound = await products(productId: productId);

    expect(productFound, Left(OutRangeValue()));
  });
}
