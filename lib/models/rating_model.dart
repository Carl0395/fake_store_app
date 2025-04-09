class RatingModel {
  final double? rate;
  final int? count;

  RatingModel({this.rate, this.count});

  RatingModel copyWith({double? rate, int? count}) =>
      RatingModel(rate: rate ?? this.rate, count: count ?? this.count);

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      RatingModel(rate: json["rate"]?.toDouble(), count: json["count"]);

  Map<String, dynamic> toJson() => {"rate": rate, "count": count};
}
