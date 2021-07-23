import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_app/core/failure/failures.dart';
import 'package:shop_app/data/repositories/data_source.dart';
import 'package:shop_app/data/models/product_model.dart';

class FireBaseProductDataSource implements IProductDataSource {
  final db = FirebaseFirestore.instance.collection('products');
  @override
  Future<Either<Failure, ProductModel>> getProductById(int id) async {
    final documentReference = db.doc('$id');
    await documentReference.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        final convertProductMap = _convertToMapOfProduct(documentSnapshot);
        return convertProductMap;
      }
    });
    return Left(FireBaseDocumentError());
  }

  Either<Failure, ProductModel> _convertToMapOfProduct(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> dataMapFormat = documentSnapshot.data() as Map<String, dynamic>;
    if (dataMapFormat.containsKey('name') &&
        dataMapFormat.containsKey('description') &&
        dataMapFormat.containsKey('price') &&
        dataMapFormat.containsKey('urlImage')) {
      ProductModel productModel = ProductModel(
        id: int.parse(documentSnapshot.id),
        name: dataMapFormat['name'],
        description: dataMapFormat['description'],
        urlImage: dataMapFormat['urlImage'],
        price: double.parse(dataMapFormat['price'].toString()),
      );
      return Right(productModel);
    } else {
      return Left(FireBaseConvertError());
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getAllProducts() async {
    late List<ProductModel> productModelList = [];
    late Failure failureFound;
    bool hasFailure = false;

    await db.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
        _convertToMapOfProduct(documentSnapshot).fold((failure) {
          hasFailure = true;
          failureFound = failure;
        }, (productModel) {
          productModelList.add(productModel);
        });

        if (hasFailure) return;
      });
    });

    if (hasFailure)
      return Left(failureFound);
    else
      return Right(productModelList);
  }
}
