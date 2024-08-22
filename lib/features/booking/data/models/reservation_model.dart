class ReservationModel {
  final String id;
  final String stayType;
  final String startDate;
  final String endDate;
  final int totalPrice;
  final String status;
  final String comment;
  final String reservationDate;
  final Chalet? chalet;

  ReservationModel({
    this.id = "",
    this.stayType = "",
    this.startDate = "",
    this.endDate = "",
    this.totalPrice = 0,
    this.status = "",
    this.comment = "",
    this.reservationDate = "",
    this.chalet,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      id: json['id'],
      stayType: json['stayType'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      totalPrice: json['totalPrice'],
      status: json['status'],
      comment: json['comment'],
      reservationDate: json['reservationDate'],
      chalet: Chalet.fromJson(json['chalet']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stayType': stayType,
      'startDate': startDate,
      'endDate': endDate,
      'totalPrice': totalPrice,
      'status': status,
      'comment': comment,
      'reservationDate': reservationDate,
      'chalet': chalet?.toJson(),
    };
  }
}

class Chalet {
  final String name;
  final String city;
  final String address;
  final List<Img> imgs;

  Chalet({
    this.name = "",
    this.city = "",
    this.address = "",
    this.imgs = const [],
  });

  factory Chalet.fromJson(Map<String, dynamic> json) {
    var list = json['imgs'] as List;
    List<Img> imgList = list.map((i) => Img.fromJson(i)).toList();

    return Chalet(
      name: json['name'],
      city: json['city'],
      address: json['address'],
      imgs: imgList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'city': city,
      'address': address,
      'imgs': imgs.map((e) => e.toJson()).toList(),
    };
  }
}

class Img {
  final String img;

  Img({this.img = ''});

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
