import 'package:dartz/dartz.dart';
import 'package:shop_app/core/failure/failures.dart';
import 'package:shop_app/domain/entities/product_entity.dart';
import 'package:shop_app/domain/repositories/product_repository_interface.dart';

class GetProductsBetweenIndexes {
  final IProductRepository repository;
  GetProductsBetweenIndexes({
    required this.repository,
  });

  //end index product data is not included
  Future<Either<Failure, List<ProductEntity>>> call() async {
    try {
      return await repository.getAllProducts();
    } catch (error) {
      throw ("could not find the products.. error: $error");
    }
  }
}
