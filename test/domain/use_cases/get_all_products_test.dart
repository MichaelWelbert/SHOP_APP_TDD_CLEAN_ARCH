import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shop_app/domain/entities/product_entity.dart';
import 'package:shop_app/domain/repositories/product_repository_interface.dart';
import 'package:shop_app/domain/use_cases/get_all_product.dart';

class MockProductRepository extends Mock implements IProductRepository {}

void main() {
  late IProductRepository repository;
  late GetProductsBetweenIndexes usecase;

  setUp(() {
    repository = MockProductRepository();
    usecase = GetProductsBetweenIndexes(repository: repository);
  });

  test("Should return all products", () async {
    List<ProductEntity> productsTest = [
      ProductEntity(id: 1, name: "tenis", description: "adidas style", urlImage: "adidas.jpg", price: 200),
      ProductEntity(id: 2, name: "p8 plus", description: "smartwatch top", urlImage: "p8plus.jpg", price: 250),
    ];

    when(() => repository.getAllProducts()).thenAnswer((_) async => Right(productsTest));

    final productsFound = await usecase();

    expect(productsFound, Right(productsTest));
  });
}
