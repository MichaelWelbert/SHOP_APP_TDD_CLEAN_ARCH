import 'package:dartz/dartz.dart';

import 'package:shop_app/core/failure/failures.dart';
import 'package:shop_app/data/repositories/data_source.dart';

import 'package:shop_app/domain/entities/product_entity.dart';
import 'package:shop_app/domain/repositories/product_repository_interface.dart';

class ProductRepository implements IProductRepository {
  final IProductDataSource dataSource;
  ProductRepository({
    required this.dataSource,
  });
  @override
  Future<Either<Failure, ProductEntity>> getProductId({required int productId}) {
    return dataSource.getProductById(productId);
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getAllProducts() {
    return dataSource.getAllProducts();
  }
}
