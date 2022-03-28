class DonationAmountModel {
  int? amount;
  String? amountInString;

  DonationAmountModel({this.amount, this.amountInString,});
}

final List<DonationAmountModel> mockListDonationAmounts = [
  DonationAmountModel(
    amount: 00001,
    amountInString: "0.0001",
  ),
  DonationAmountModel(
    amount: 0001,
    amountInString: "0.001",
  ),
  DonationAmountModel(
    amount: 01,
    amountInString: "0.1",
  ),
  DonationAmountModel(
    amount: 01,
    amountInString: "0.1",
  ),
  DonationAmountModel(
    amount: 1,
    amountInString: "1",
  ),
  DonationAmountModel(
    amount: 10,
    amountInString: "10",
  ),
];