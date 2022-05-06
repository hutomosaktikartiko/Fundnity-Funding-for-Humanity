import 'date_time_parsing.dart';

extension BigIntParsing on BigInt? {
  String bigIntToString() {
    if (this == null) return "";
    return this.toString();
  }

  double bigIntToPercentTarget({
    required BigInt? target,
  }) {
    if (this == null) return 0.0;
    if (target == null) return 0.0;
    return this!.etherInWeiToEther() / target.toDouble() * 100;
  }

  // Max 1.0
  double bigIntToPercentTargetMax1({
    required BigInt? target,
  }) {
    if (this == null) return 0.0;
    if (target == null) return 0.0;

    final double result = (this!.etherInWeiToEther() / target.toDouble() * 100) / 100;
    if (result > 1.0) {
      return 1.0;
    }
    return result;
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