class RegResponseModel {
  RegResponseModel({
    this.msg,
  });

  RegResponseModel.fromJson(dynamic json) {
    msg = json['msg'];
  }

  String? msg;
}

class UserModel {
  UserModel({
    this.id,
    this.userName,
    this.email,
    this.phone,
    this.name,
    this.city,
    this.password,
    this.firebaseUid,
    this.img,
    this.role,
  });

  UserModel.fromJson(dynamic json) {
    id = json['id'];
    userName = json['userName'];
    email = json['email'];
    phone = json['phone'];
    name = json['name'];
    city = json['city'];
    password = json['password'];
    firebaseUid = json['firebaseUid'];
    img = json['img'];
    role = json['role'];
  }

  String? id;
  String? userName;
  String? email;
  String? phone;
  String? name;
  String? city;
  String? password;
  String? firebaseUid;
  dynamic img;
  String? role;
}
