extension DoubleParsing on double? {
  BigInt etherToWei() {
    if (this == null) return BigInt.from(0);
    return BigInt.from(this! * 1000000000000000000);
  }

  BigInt etherToGwei() {
    if (this == null) return BigInt.from(0);
    return BigInt.from(this! * 1000000000);
  }

  int doubleEtherToGweiEther() {
    if (this == null) return 0;
    return (this! * 1000000000).toInt();
  }
}
