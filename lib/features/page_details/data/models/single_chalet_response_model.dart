import '../../../owner/add_chalet/data/models/add_chalet.dart';

class SingleChaletResponseModel {
  SingleChaletResponseModel({
    this.chalet,
  });

  SingleChaletResponseModel.fromJson(dynamic json) {
    chalet = json['chalet'] != null ? Chalet.fromJson(json['chalet']) : null;
  }

  Chalet? chalet;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (chalet != null) {
      map['chalet'] = chalet?.toJson();
    }
    return map;
  }
}

class Chalet {
  Chalet({
    this.id,
    this.name,
    this.description,
    this.priority,
    this.staffChoice,
    this.views,
    this.city,
    this.address,
    this.video,
    this.state,
    this.imgs,
    this.reviews,
    this.features,
    this.prices,
  });

  Chalet.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    priority = json['priority'];
    staffChoice = json['staffChoice'];
    views = json['views'];
    city = json['city'];
    address = json['address'];
    video = json['video'];
    state = json['state'];
    if (json['imgs'] != null) {
      imgs = [];
      json['imgs'].forEach((v) {
        imgs?.add(Imgs.fromJson(v));
      });
    }
    if (json['reviews'] != null) {
      reviews = [];
      json['reviews'].forEach((v) {
        reviews?.add(Review.fromJson(v));
      });
    }
    if (json['features'] != null) {
      features = [];
      json['features'].forEach((v) {
        features?.add(Features.fromJson(v));
      });
    }
    if (json['prices'] != null) {
      prices = [];
      json['prices'].forEach((v) {
        prices?.add(Prices.fromJson(v));
      });
    }
  }

  String? id;
  String? name;
  String? description;
  int? priority;
  bool? staffChoice;
  int? views;
  String? city;
  String? address;
  String? video;
  String? state;
  List<Imgs>? imgs;
  List<Review>? reviews;
  List<Features>? features;
  List<Prices>? prices;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['priority'] = priority;
    map['staffChoice'] = staffChoice;
    map['views'] = views;
    map['city'] = city;
    map['address'] = address;
    map['video'] = video;
    map['state'] = state;
    if (imgs != null) {
      map['imgs'] = imgs?.map((v) => v.toJson()).toList();
    }
    if (reviews != null) {
      map['reviews'] = reviews?.map((v) => v.toJson()).toList();
    }
    if (features != null) {
      map['features'] = features?.map((v) => v.toJson()).toList();
    }
    if (prices != null) {
      map['prices'] = prices?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Prices {
  Prices({
    this.stayType,
    this.price,
    this.hasDiscount,
  });

  Prices.fromJson(dynamic json) {
    stayType = json['StayType'];
    price = json['price'];
    hasDiscount = json['hasDiscount'];
  }

  String? stayType;
  int? price;
  bool? hasDiscount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StayType'] = stayType;
    map['price'] = price;
    map['hasDiscount'] = hasDiscount;
    return map;
  }
}

class Features {
  Features({
    this.title,
    this.description,
  });

  Features.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
  }

  String? title;
  String? description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    return map;
  }
}

class Review {
  Review({
    this.user,
    this.comment,
  });

  Review.fromJson(dynamic json) {
    user = json['user'];
    comment = json['comment'];
  }

  String? user;
  String? comment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user'] = user;
    map['comment'] = comment;
    return map;
  }
}
