import 'package:web3dart/web3dart.dart';

class ContributorModel {
  EthereumAddress? contributor;
  BigInt? amount;

  ContributorModel({
    required this.amount,
    required this.contributor,
  });

  factory ContributorModel.fromJson(List<dynamic> list) {
    return ContributorModel(
      amount: list[0],
      contributor: list[1],
    );
  }
}