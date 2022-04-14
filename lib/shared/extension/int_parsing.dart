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

  double gweiToEther() {
    if (this == null) return 0.0;
    return this!.toInt() / 1000000000;
  }
}
