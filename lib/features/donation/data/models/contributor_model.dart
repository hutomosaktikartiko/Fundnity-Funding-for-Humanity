import 'package:web3dart/web3dart.dart';

class ContributorModel {
  EthereumAddress? contributor;
  BigInt? amount;

  ContributorModel({
    required this.amount,
    required this.contributor,
  });

  factory ContributorModel.fromJson(List list) {
    return ContributorModel(
      contributor: list[0] ?? null,
      amount: list[1] ?? null,
    );
  }
}