class ChaletModelResponse {
  List<ChaletModel> chalets;
  int totalPages;
  int currentPage;

  ChaletModelResponse({
    required this.chalets,
    required this.totalPages,
    required this.currentPage,
  });

  factory ChaletModelResponse.fromJson(Map<String, dynamic> json) {
    var chaletsJson = json['chalets'] as List;
    List<ChaletModel> chaletsList =
        chaletsJson.map((chalet) => ChaletModel.fromJson(chalet)).toList();

    return ChaletModelResponse(
      chalets: chaletsList,
      totalPages: json['totalPages'],
      currentPage: json['currentPage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chalets': chalets.map((chalet) => chalet.toJson()).toList(),
      'totalPages': totalPages,
      'currentPage': currentPage,
    };
  }
}

class ChaletModel {
  String id;
  String name;
  String city;
  String address;
  List<Img> imgs;
  List<dynamic> reviews;
  List<Price> prices;
  List<Favorite> favorites;

  ChaletModel({
    required this.id,
    required this.name,
    required this.city,
    required this.address,
    required this.imgs,
    required this.reviews,
    required this.prices,
    required this.favorites,
  });

  factory ChaletModel.fromJson(Map<String, dynamic> json) {
    return ChaletModel(
      id: json['id'],
      name: json['name'],
      city: json['city'],
      address: json['address'],
      imgs: List<Img>.from(json['imgs'].map((x) => Img.fromJson(x))),
      reviews: List<dynamic>.from(json['reviews']),
      prices: List<Price>.from(json['prices'].map((x) => Price.fromJson(x))),
      favorites: List<Favorite>.from(
          json['favorites'].map((x) => Favorite.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'address': address,
      'imgs': List<dynamic>.from(imgs.map((x) => x.toJson())),
      'reviews': List<dynamic>.from(reviews),
      'prices': List<dynamic>.from(prices.map((x) => x.toJson())),
      'favorites': List<dynamic>.from(favorites.map((x) => x.toJson())),
    };
  }
}

class Img {
  String? img;

  Img({
    this.img,
  });

  factory Img.fromJson(Map<String, dynamic> json) {
    return Img(
      img: json['img'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'img': img,
    };
  }
}

class Price {
  String id;
  int price;
  bool hasDiscount;
  String? discountType;
  int? discountAmount;

  Price({
    required this.id,
    required this.price,
    required this.hasDiscount,
    this.discountType,
    this.discountAmount,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      id: json['id'],
      price: json['price'],
      hasDiscount: json['hasDiscount'],
      discountType: json['discountType'],
      discountAmount: json['discountAmount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'hasDiscount': hasDiscount,
      'discountType': discountType,
      'discountAmount': discountAmount,
    };
  }
}

class Favorite {
  String? id;

  Favorite({this.id});

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
