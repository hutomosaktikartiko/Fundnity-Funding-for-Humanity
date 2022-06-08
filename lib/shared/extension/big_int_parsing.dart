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

    final double result = this!.weiEtherToDoubleEther() /
        target.weiEtherToDoubleEther().toDouble() *
        100;
    if (result > 100.0) {
      return 100;
    }

    return result;
  }

  // Max 1.0
  double bigIntToPercentTargetMax1({
    required BigInt? target,
  }) {
    if (this == null) return 0.0;
    if (target == null) return 0.0;

    final double result = (this!.weiEtherToDoubleEther() /
            target.weiEtherToDoubleEther().toDouble() *
            100) /
        100;
    if (result > 1.0) {
      return 1.0;
    }
    return result;
  }

  double weiEtherToDoubleEther() {
    if (this == null) return 0.0;
    return this!.toInt() / 1000000000000000000;
  }

  double gweiToDoubleEther() {
    if (this == null) return 0.0;
    return this!.toInt() / 1000000000;
  }

  int timestampToIntDays() {
    if (this == null) return 0;

    final int days =
        DateTime.fromMillisecondsSinceEpoch(this!.toInt()).daysBetween() ?? 0;

    if (days < 1) return 0;

    return days;
  }

  BigInt etherInGweiToWei() {
    if (this == null) return BigInt.from(0);
    return BigInt.from(this!.toInt() * 1000000000);
  }
}
