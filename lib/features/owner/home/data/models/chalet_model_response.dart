class ChaletModel {
  String id;
  String name;
  String city;
  String address;
  List<Img> imgs;
  List<dynamic> reviews;

  ChaletModel({
    this.id = "",
    this.name = "",
    this.city = "",
    this.address = "",
    this.imgs = const [],
    this.reviews = const [],
  });

  factory ChaletModel.fromJson(Map<String, dynamic> json) {
    return ChaletModel(
      id: json['id'],
      name: json['name'],
      city: json['city'],
      address: json['address'],
      imgs: List<Img>.from(json['imgs'].map((x) => Img.fromJson(x))),
      reviews: List<dynamic>.from(json['reviews']),
    );
  }
}

class Img {
  String img;

  Img({this.img = ""});

  factory Img.fromJson(Map<String, dynamic> json) {
    return Img(
      img: json['img'],
    );
  }
}

class ChaletModelResponse {
  List<ChaletModel> chalets;

  ChaletModelResponse({this.chalets = const []});

  factory ChaletModelResponse.fromJson(Map<String, dynamic> json) {
    return ChaletModelResponse(
      chalets: List<ChaletModel>.from(
          json['chalet'].map((x) => ChaletModel.fromJson(x))),
    );
  }
}
