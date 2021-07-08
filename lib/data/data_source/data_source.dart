import 'package:dartz/dartz.dart';
import 'package:shop_app/core/failure/failures.dart';
import 'package:shop_app/data/models/product_model.dart';

abstract class IProductDataSource {
  Future<Either<Failure, ProductModel>> getProductById(int productId);
}
