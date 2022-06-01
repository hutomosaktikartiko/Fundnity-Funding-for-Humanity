extension DoubleParsing on double? {
  BigInt etherToWei() {
    if (this == null) return BigInt.from(0);
    return BigInt.from(this! * 1000000000000000000);
  }

  BigInt etherToGwei() {
    if (this == null) return BigInt.from(0);
    return BigInt.from(this! * 1000000000);
  }
}
