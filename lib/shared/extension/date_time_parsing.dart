import 'package:intl/intl.dart';

extension DateTimeParsing on DateTime? {
  String? dateTimeToString() {
    if (this == null) {
      return null;
    }
    return DateFormat('dd MMM yyyy').format(this!);
  }

  int? daysBetween() {
    if (this == null) {
      return null;
    }
    DateTime from =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    DateTime to = DateTime(this!.year, this!.month, this!.day);

    return (to.difference(from).inHours / 24).round();
  }
}