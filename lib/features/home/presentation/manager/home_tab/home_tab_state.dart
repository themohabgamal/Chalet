import 'package:chalet_spot/features/home/data/models/banner_model.dart';
import 'package:chalet_spot/features/home/data/models/chalet_model_response.dart';

import '../../../../../core/error/failures.dart';

abstract class HomeTabState {}

class HomeTabInitial extends HomeTabState {}

class HomeTabGetChaletsLoading extends HomeTabState {}

class HomeTabGetChaletsSuccess extends HomeTabState {
  List<ChaletModel> chalets;

  HomeTabGetChaletsSuccess(this.chalets);
}

class HomeTabGetChaletsError extends HomeTabState {
  Failures failures;

  HomeTabGetChaletsError(this.failures);
}

class HomeTabGetBannersLoading extends HomeTabState {}

class HomeTabGetBannersSuccess extends HomeTabState {
  List<BannerModel> banners;

  HomeTabGetBannersSuccess(this.banners);
  @override
  List<Object> get props => [banners];
}

class HomeTabGetBannersError extends HomeTabState {
  String error;

  HomeTabGetBannersError(this.error);
  @override
  List<Object> get props => [error];
}

class OnFavLoading extends HomeTabState {}

class OnFavSuccess extends HomeTabState {
  String message;

  OnFavSuccess(this.message);
}

class OnFavError extends HomeTabState {
  Failures failures;

  OnFavError(this.failures);
}
