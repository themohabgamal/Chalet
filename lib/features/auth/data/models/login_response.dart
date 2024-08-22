class LoginResponse {
  LoginResponse({
    this.token,
    this.name,
    this.validTill,
    this.role,
  });

  LoginResponse.fromJson(dynamic json) {
    token = json['token'];
    name = json['name'];
    role = json['role'];

    validTill = json['validTill'];
  }

  String? token;
  String? name;
  String? role;
  String? validTill;
}
