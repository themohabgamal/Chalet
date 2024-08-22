class AddChalet {
  AddChalet({
    this.name,
    this.description,
    this.priority,
    this.city,
    this.address,
    this.video,
    this.state,
    this.imgs,
    this.features,
    this.prices,
  });

  AddChalet.fromJson(dynamic json) {
    name = json['name'];
    description = json['description'];
    priority = json['priority'];
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

  String? name;
  String? description;
  int? priority;
  String? city;
  String? address;
  String? video;
  String? state;
  List<Imgs>? imgs;
  List<Features>? features;
  List<Prices>? prices;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['description'] = description;
    map['priority'] = priority;
    map['city'] = city;
    map['address'] = address;
    map['video'] = video;
    map['state'] = state;
    if (imgs != null) {
      map['imgs'] = imgs?.map((v) => v.toJson()).toList();
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
  });

  Prices.fromJson(dynamic json) {
    stayType = json['StayType'];
    price = json['price'];
  }

  String? stayType;
  int? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['StayType'] = stayType;
    map['price'] = price;
    return map;
  }
}

class Features {
  Features({
    this.title,
    this.discription,
  });

  Features.fromJson(dynamic json) {
    title = json['title'];
    discription = json['discription'];
  }

  String? title;
  String? discription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['discription'] = discription;
    return map;
  }
}

class Imgs {
  Imgs({
    this.img,
  });

  Imgs.fromJson(dynamic json) {
    img = json['img'];
  }

  String? img;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['img'] = img;
    return map;
  }
}
