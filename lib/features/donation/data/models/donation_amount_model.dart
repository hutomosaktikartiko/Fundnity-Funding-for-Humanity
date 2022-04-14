class DonationAmountModel {
  BigInt? amountInGwei;

  DonationAmountModel({
    this.amountInGwei,
  });
}

final List<DonationAmountModel> mockListDonationAmounts = [
  DonationAmountModel(
    amountInGwei: BigInt.from(100000),
  ),
  DonationAmountModel(
    amountInGwei: BigInt.from(1000000),
  ),
  DonationAmountModel(
    amountInGwei: BigInt.from(10000000),
  ),
  DonationAmountModel(
    amountInGwei: BigInt.from(100000000),
  ),
  DonationAmountModel(
    amountInGwei: BigInt.from(1000000000),
  ),
  DonationAmountModel(
    amountInGwei: BigInt.from(10000000000),
  ),
];
