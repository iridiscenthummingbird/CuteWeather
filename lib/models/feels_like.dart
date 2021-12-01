class FeelsLike {
  final double day;
  final double night;
  final double eve;
  final double morn;

  FeelsLike(this.day, this.night, this.eve, this.morn);

  factory FeelsLike.fromJson(Map<String, dynamic> json) {
    return FeelsLike(
      double.parse(json['day'].toString()),
      double.parse(json['night'].toString()),
      double.parse(json['eve'].toString()),
      double.parse(json['morn'].toString()),
    );
  }
}
