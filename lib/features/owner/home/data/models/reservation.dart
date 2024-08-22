class Reservation {
  final String id;
  final String reservationDate;
  final String startDate;
  final String endDate;
  final String stayType;
  final double totalPrice;
  final String status;
  final Chalet chalet;
  final User user;

  Reservation({
    required this.id,
    required this.reservationDate,
    required this.startDate,
    required this.endDate,
    required this.stayType,
    required this.totalPrice,
    required this.status,
    required this.chalet,
    required this.user,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      reservationDate: json['reservationDate'],
      startDate: json['startDate'],
      endDate: json['endDate'],
      stayType: json['stayType'],
      totalPrice: json['totalPrice'].toDouble(),
      status: json['status'],
      chalet: Chalet.fromJson(json['chalet']),
      user: User.fromJson(json['user']),
    );
  }
}

class Chalet {
  final String name;

  Chalet({required this.name});

  factory Chalet.fromJson(Map<String, dynamic> json) {
    return Chalet(
      name: json['name'],
    );
  }
}

class User {
  final String name;

  User({required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
    );
  }
}
