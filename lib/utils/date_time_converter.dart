class DateTimeConverter {
  static DateTime convert(int dt, int offset) {
    return DateTime.fromMillisecondsSinceEpoch(
        (dt + offset - DateTime.now().timeZoneOffset.inSeconds) * 1000);
  }
}
