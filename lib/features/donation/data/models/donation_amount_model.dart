class DonationAmountModel {
  BigInt? amountInGwei, amountInWei;

  DonationAmountModel({
    this.amountInGwei,
    this.amountInWei,
  });
}

final List<DonationAmountModel> mockListDonationAmounts = [
  DonationAmountModel(
    amountInGwei: BigInt.from(100000),
    amountInWei: BigInt.from(100000000000000),
  ),
  DonationAmountModel(
    amountInGwei: BigInt.from(1000000),
    amountInWei: BigInt.from(1000000000000000),
  ),
  DonationAmountModel(
    amountInGwei: BigInt.from(10000000),
    amountInWei: BigInt.from(10000000000000000),
  ),
  DonationAmountModel(
    amountInGwei: BigInt.from(100000000),
    amountInWei: BigInt.from(100000000000000000),
  ),
  DonationAmountModel(
    amountInGwei: BigInt.from(1000000000),
    amountInWei: BigInt.from(1000000000000000000),
  ),
];
