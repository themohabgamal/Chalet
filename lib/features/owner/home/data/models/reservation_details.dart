class ReservationDetails {
  final String id;
  final String reservationDate;
  final String startDate;
  final String endDate;
  final String stayType;
  final double totalPrice;
  final String status;
  final List<dynamic> userUsedDiscountCode;
  final Chalet chalet;
  final User user;

  ReservationDetails({
    required this.id,
    required this.reservationDate,
    required this.startDate,
    required this.endDate,
    required this.stayType,
    required this.totalPrice,
    required this.status,
    required this.userUsedDiscountCode,
    required this.chalet,
    required this.user,
  });

  factory ReservationDetails.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('JSON data cannot be null');
    }

    return ReservationDetails(
      id: json['id'] as String? ?? '',
      reservationDate: json['reservationDate'] as String? ?? '',
      startDate: json['startDate'] as String? ?? '',
      endDate: json['endDate'] as String? ?? '',
      stayType: json['stayType'] as String? ?? '',
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String? ?? '',
      userUsedDiscountCode:
          json['userUsedDiscountCode'] as List<dynamic>? ?? [],
      chalet: Chalet.fromJson(json['chalet'] as Map<String, dynamic>?),
      user: User.fromJson(json['user'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reservationDate': reservationDate,
      'startDate': startDate,
      'endDate': endDate,
      'stayType': stayType,
      'totalPrice': totalPrice,
      'status': status,
      'userUsedDiscountCode': userUsedDiscountCode,
      'chalet': chalet.toJson(),
      'user': user.toJson(),
    };
  }
}

class Chalet {
  final String id;
  final String name;
  final String city;
  final String address;

  Chalet({
    required this.id,
    required this.name,
    required this.city,
    required this.address,
  });

  factory Chalet.fromJson(Map<String, dynamic>? json) {
    return Chalet(
      id: json?['id'] as String? ?? '',
      name: json?['name'] as String? ?? '',
      city: json?['city'] as String? ?? '',
      address: json?['address'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'city': city,
      'address': address,
    };
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String city;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.city,
  });

  factory User.fromJson(Map<String, dynamic>? json) {
    return User(
      id: json?['id'] as String? ?? '',
      name: json?['name'] as String? ?? '',
      email: json?['email'] as String? ?? '',
      phone: json?['phone'] as String? ?? '',
      city: json?['city'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'city': city,
    };
  }
}
