import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String message();
}

class ProductNotFound extends Failure {
  @override
  List<Object> get props => [];

  @override
  String message() => "could not find a product.";
}

class FireBaseConvertError extends Failure {
  @override
  String message() => "it was not possible to load the products there was a conversation problem.";

  @override
  List<Object> get props => [];
}

class FireBaseDocumentError extends Failure {
  @override
  String message() => "Document does not exist on the database.";

  @override
  List<Object> get props => [];
}

class OutRangeValue extends Failure {
  @override
  String message() => "the value entered is not valid.";

  @override
  List<Object> get props => [];
}
