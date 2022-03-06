class MockTransactionSpeed {
  String? title, speed, basePriceString;
  double? gasPrice;
  int? basePrice;

  MockTransactionSpeed({
    this.basePrice,
    this.basePriceString,
    this.gasPrice,
    this.speed,
    this.title,
  });
}

final List<MockTransactionSpeed> mockListTransactionSpeeds = [
  MockTransactionSpeed(
    title: "FAST",
    speed: "2 minutes",
    basePriceString: "\$0.11",
    gasPrice: 45,
    basePrice: 00001,
  ),
  MockTransactionSpeed(
    title: "STANDARD",
    speed: "5 minutes",
    basePriceString: "\$0.11",
    gasPrice: 28,
    basePrice: 00001,
  ),
  MockTransactionSpeed(
    title: "SAFE LOW",
    speed: "20 minutes",
    basePriceString: "\$0.11",
    gasPrice: 24.5,
    basePrice: 00001,
  ),
];
