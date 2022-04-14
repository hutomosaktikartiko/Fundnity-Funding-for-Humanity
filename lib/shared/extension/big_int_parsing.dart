import 'date_time_parsing.dart';

extension BigIntParsing on BigInt? {
  String bigIntToString() {
    if (this == null) return "";
    return this.toString();
  }

  double bigIntToCalculatePercentDouble({
    required BigInt? target,
  }) {
    if (this == null) return 0.0;
    if (target == null) return 0.0;
    return this!.toDouble() / target.toDouble() * 100;
  }

  double etherInWeiToEther() {
    if (this == null) return 0.0;
    return this!.toInt() / 1000000000000000000;
  }

  double gweiToEther() {
    if (this == null) return 0.0;
    return this!.toInt() / 1000000000;
  }

  int? bigIntTimeStampToIntDays() {
    if (this == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(this!.toInt()).daysBetween();
  }
}