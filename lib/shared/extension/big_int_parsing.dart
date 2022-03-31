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
}