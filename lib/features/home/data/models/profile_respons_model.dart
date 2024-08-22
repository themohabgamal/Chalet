import '../../../auth/data/models/reg_response_model.dart';

class ProfileResponseModel {
  ProfileResponseModel({
    this.user,
  });

  ProfileResponseModel.fromJson(dynamic json) {
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  UserModel? user;
}
