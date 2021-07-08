import 'package:shop_app/core/failure/failures.dart';
import 'package:shop_app/domain/entities/product_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IProductRepository {
  Future<Either<Failure, ProductEntity>> getProductId({required int productId});
}
