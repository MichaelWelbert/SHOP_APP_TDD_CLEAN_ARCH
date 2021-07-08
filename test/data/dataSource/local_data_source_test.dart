import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shop_app/core/failure/failures.dart';
import 'package:shop_app/data/data_source/data_source.dart';
import 'package:shop_app/data/data_source/product_local_data_source.dart';
import 'package:shop_app/data/models/product_model.dart';
import '../../mock/mock_products_database.dart';

void main() {
  late IProductDataSource datasource;
  late String dataBase;

  setUp(() {
    dataBase = MOCKDBPRODUTOS;
    datasource = ProductLocalDataSource(dataBase: dataBase);
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

    final product = await datasource.getProductById(productId);

    expect(Right(testProduct), product);
  });

  test('should return a failure "productNotFound" when sending an id that doesn\'t exist', () async {
    final int productId = -1;

    final product = await datasource.getProductById(productId);

    expect(Left(ProductNotFound()), product);
  });
}
