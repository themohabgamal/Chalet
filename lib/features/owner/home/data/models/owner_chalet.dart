class OwnerChalet {
  final String id;
  final String name;
  final String description;
  final String city;
  final List<Price> prices;
  final List<ImageData> imgs;

  OwnerChalet({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.prices,
    required this.imgs,
  });

  // Factory method to create a OwnerChalet object from JSON
  factory OwnerChalet.fromJson(Map<String, dynamic> json) {
    return OwnerChalet(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      city: json['city'],
      prices: (json['prices'] as List)
          .map((price) => Price.fromJson(price))
          .toList(),
      imgs:
          (json['imgs'] as List).map((img) => ImageData.fromJson(img)).toList(),
    );
  }

  // Method to convert a Chalet object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'city': city,
      'prices': prices.map((price) => price.toJson()).toList(),
      'imgs': imgs.map((img) => img.toJson()).toList(),
    };
  }
}

class Price {
  final int price;
  final String stayType;

  Price({
    required this.price,
    required this.stayType,
  });

  // Factory method to create a Price object from JSON
  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      price: json['price'],
      stayType: json['StayType'],
    );
  }

  // Method to convert a Price object to JSON
  Map<String, dynamic> toJson() {
    return {
      'price': price,
      'StayType': stayType,
    };
  }
}

class ImageData {
  final String img;

  ImageData({
    required this.img,
  });

  // Factory method to create an ImageData object from JSON
  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      img: json['img'],
    );
  }

  // Method to convert an ImageData object to JSON
  Map<String, dynamic> toJson() {
    return {
      'img': img,
    };
  }
}
