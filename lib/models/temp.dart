class Temp {
  final double day;
  final double min;
  final double max;
  final double night;
  final double eve;
  final double morn;

  Temp(
    this.day,
    this.min,
    this.max,
    this.night,
    this.eve,
    this.morn,
  );

  factory Temp.fromJson(Map<String, dynamic> json) {
    return Temp(
      double.parse(json['day'].toString()),
      double.parse(json['min'].toString()),
      double.parse(json['max'].toString()),
      double.parse(json['night'].toString()),
      double.parse(json['eve'].toString()),
      double.parse(json['morn'].toString()),
    );
  }
}
