import 'package:chalet_spot/features/home/data/data_sources/chalet_data_sources.dart';
import 'package:chalet_spot/features/home/data/models/banner_model.dart';
import 'package:chalet_spot/features/home/data/repositories/chalets_repo.dart';
import 'package:chalet_spot/features/home/presentation/manager/home_tab/home_tab_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../../data/models/chalet_model_response.dart';

class HomeTabCubit extends Cubit<HomeTabState> {
  ChaletDataSources source;

  HomeTabCubit(this.source) : super(HomeTabInitial());

  static HomeTabCubit get(context) => BlocProvider.of(context);

  String location = 'Getting location...';
  List<ChaletModel> chalets = [];
  List<BannerModel> banners = [];

  Future<void> fetchBanners() async {
    emit(HomeTabGetBannersLoading()); // Emit loading state before fetching
    final dio = Dio();
    try {
      final response =
          await dio.get('https://chaletspot.vercel.app/guest/app-banner');

      if (response.statusCode == 200) {
        // Decode response into List<BannerModel>
        List<dynamic> data = response.data;
        List<BannerModel> bannersList =
            data.map((item) => BannerModel.fromJson(item)).toList();
        banners = bannersList;
        emit(HomeTabGetBannersSuccess(banners)); // Emit success with banners
      } else {
        emit(HomeTabGetBannersError(response.statusMessage.toString()));
      }
    } catch (e) {
      emit(HomeTabGetBannersError(e.toString()));
    }
  }

  Future<void> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      location = 'Location services are disabled.';
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        location = 'Location permissions are denied.';
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      location = 'Location permissions are permanently denied.';
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    getAddressFromLatLng(position);
  }

  Future<void> getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placeMarks[0];
      location = '${place.locality}, ${place.country}';
    } catch (e) {
      location = 'Failed to get location.';
    }
  }

  Future<void> getChalets() async {
    emit(HomeTabGetChaletsLoading());
    ChaletsRepo chaletsRepo = ChaletsRepo(source);

    var result = await chaletsRepo.getChalets();

    result.fold((l) {
      emit(HomeTabGetChaletsError(l));
    }, (r) async {
      chalets = r.chalets;
      emit(HomeTabGetChaletsSuccess(r.chalets));
      fetchBanners();
    });
  }

  Future<void> addToFav(String chaletId) async {
    emit(OnFavLoading());
    ChaletsRepo chaletsRepo = ChaletsRepo(source);

    var result = await chaletsRepo.addToFav(chaletId);

    result.fold((l) {
      emit(OnFavError(l));
    }, (r) async {
      int index = chalets.indexWhere((e) => e.id == chaletId);
      chalets[index].favorites.length == 1
          ? chalets[index].favorites.length = 0
          : chalets[index].favorites.add(Favorite(id: r));
      fetchBanners();
      emit(OnFavSuccess(r.toString()));
    });
  }
}
