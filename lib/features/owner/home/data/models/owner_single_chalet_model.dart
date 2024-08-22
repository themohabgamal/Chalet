class OwnerSingleChaletModel {
  final String id;
  final String name;
  final String description;
  final int priority;
  final bool staffChoice;
  final int views;
  final String city;
  final String address;
  final String video;
  final String state;
  final List<ChaletImage> imgs;
  final List<Feature> features;
  final List<Price> prices;

  OwnerSingleChaletModel({
    required this.id,
    required this.name,
    required this.description,
    required this.priority,
    required this.staffChoice,
    required this.views,
    required this.city,
    required this.address,
    required this.video,
    required this.state,
    required this.imgs,
    required this.features,
    required this.prices,
  });

  factory OwnerSingleChaletModel.fromJson(Map<String, dynamic> json) {
    return OwnerSingleChaletModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      priority: json['priority'],
      staffChoice: json['staffChoice'],
      views: json['views'],
      city: json['city'],
      address: json['address'],
      video: json['video'],
      state: json['state'],
      imgs: List<ChaletImage>.from(
          json['imgs'].map((x) => ChaletImage.fromJson(x))),
      features:
          List<Feature>.from(json['features'].map((x) => Feature.fromJson(x))),
      prices: List<Price>.from(json['prices'].map((x) => Price.fromJson(x))),
    );
  }
}

class ChaletImage {
  final String id;
  final String img;
  final String chaletId;

  ChaletImage({
    required this.id,
    required this.img,
    required this.chaletId,
  });

  factory ChaletImage.fromJson(Map<String, dynamic> json) {
    return ChaletImage(
      id: json['id'],
      img: json['img'],
      chaletId: json['chaletId'],
    );
  }
}

class Feature {
  final String id;
  final String title;
  final String? description;
  final String chaletId;

  Feature({
    required this.id,
    required this.title,
    this.description,
    required this.chaletId,
  });

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      id: json['id'],
      title: json['title'],
      description: json['discription'],
      chaletId: json['chaletId'],
    );
  }
}

class Price {
  final String id;
  final String stayType;
  final int price;
  final String chaletId;
  final bool hasDiscount;
  final String? discountType;
  final int? discountAmount;
  final String? discountvalidFrom;
  final String? discountvalidTo;

  Price({
    required this.id,
    required this.stayType,
    required this.price,
    required this.chaletId,
    required this.hasDiscount,
    this.discountType,
    this.discountAmount,
    this.discountvalidFrom,
    this.discountvalidTo,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      id: json['id'],
      stayType: json['StayType'],
      price: json['price'],
      chaletId: json['chaletId'],
      hasDiscount: json['hasDiscount'],
      discountType: json['discountType'],
      discountAmount: json['discountAmount'],
      discountvalidFrom: json['discountvalidFrom'],
      discountvalidTo: json['discountvalidTo'],
    );
  }
}
