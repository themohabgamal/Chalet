import 'package:chalet_spot/features/home/data/repositories/profile_repo.dart';
import 'package:chalet_spot/features/home/presentation/manager/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../auth/data/models/reg_response_model.dart';
import '../../../data/data_sources/profile_data_sources.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileDataSources source;

  ProfileCubit(this.source) : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  UserModel user = UserModel();

  getProfile() async {
    emit(ProfileLoading());
    ProfileRepo profileRepo = ProfileRepo(source);

    var result = await profileRepo.getProfile();

    result.fold((l) {
      emit(ProfileError(l));
    }, (r) async {
      user = r.user ?? UserModel();
      emit(
        ProfileSuccess(r.user!),
      );
    });
  }
}
