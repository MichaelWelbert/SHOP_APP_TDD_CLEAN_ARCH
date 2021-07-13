import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:shop_app/core/failure/failures.dart';
import 'package:shop_app/data/data_source/data_source.dart';
import 'package:shop_app/data/models/product_model.dart';

final db = FirebaseFirestore.instance.collection('products');

class FireBaseProductDataSource implements IProductDataSource {
  @override
  Future<Either<Failure, ProductModel>> getProductById(int id) async {
    final documentReference = db.doc('$id');
    documentReference.get().then((DocumentSnapshot documentSnapshot) {
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
        price: double.parse(dataMapFormat['price']),
      );
      return Right(productModel);
    } else {
      return Left(FireBaseConvertError());
    }
  }
}
