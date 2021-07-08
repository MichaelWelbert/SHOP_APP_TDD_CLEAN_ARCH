import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ProductNotFound extends Failure {
  static String message() => "could not find a product.";

  @override
  List<Object> get props => [];
}

class OutRangeValue extends Failure {
  static String message() => "the value entered is not valid.";

  @override
  List<Object> get props => [];
}
