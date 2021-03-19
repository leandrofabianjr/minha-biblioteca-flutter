import 'package:graphql_flutter/graphql_flutter.dart';

abstract class Failure implements Exception {}

class FetchFailure extends Failure {
  final OperationException? exception;

  FetchFailure([this.exception]);
}

class InsertFailure extends Failure {
  final OperationException? exception;

  InsertFailure([this.exception]);
}
