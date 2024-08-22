class ReserveModel {
  final String chaletId;

  final String stayType;

  final String startDate;

  final String endDate;

  final String comment;

  final String code;

  ReserveModel(
      {required this.stayType,
      required this.startDate,
      required this.endDate,
      required this.comment,
      required this.code,
      required this.chaletId});
}
