import 'package:chalet_spot/core/error/failures.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchGetAllChaletsLoading extends SearchState {}

class SearchGetAllChaletsSuccess extends SearchState {}

class SearchGetAllChaletsError extends SearchState {
  Failures failures;

  SearchGetAllChaletsError(this.failures);
}

class GetFilterChaletsLoading extends SearchState {}
class GetFilterChaletsSuccess extends SearchState {}

class NotFoundFilterChalets extends SearchState {}
class UpdateSearchChalets extends SearchState {}
