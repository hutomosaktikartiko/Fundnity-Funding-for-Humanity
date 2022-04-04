extension IntParsing on int? {
  DateTime? calculateDayToDateTime() {
    if (this == null) return null;
    final DateTime now = DateTime.now();

    DateTime date = DateTime(
      now.year,
      now.month,
      now.day + (this ?? 0),
    );

    return date;
  }
}
