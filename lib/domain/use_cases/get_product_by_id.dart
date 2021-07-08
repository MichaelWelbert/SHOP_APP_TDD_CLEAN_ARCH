import 'package:dartz/dartz.dart';
import 'package:shop_app/core/failure/failures.dart';
import 'package:shop_app/domain/entities/product_entity.dart';
import 'package:shop_app/domain/repositories/product_repository_interface.dart';

class GetProductById {
  final IProductRepository repository;
  GetProductById({required this.repository});
  Future<Either<Failure, ProductEntity>> call({required int productId}) async {
    try {
      if (outRangeProductId(productId)) return Left(OutRangeValue());

      return await repository.getProductId(productId: productId);
    } catch (error) {
      throw ("could not find the selected product error: $error");
    }
  }

  bool outRangeProductId(int productId) {
    int outRangedId = 0;
    if (productId <= outRangedId)
      return true;
    else
      return false;
  }
}
