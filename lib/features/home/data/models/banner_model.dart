class BannerModel {
  final String id;
  final String img;
  final String? expiredAt;
  final String linkId;

  BannerModel({
    required this.id,
    required this.img,
    this.expiredAt,
    required this.linkId,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      img: json['img'],
      expiredAt: json['ExpiredAt'],
      linkId: json['linkId'],
    );
  }
}
