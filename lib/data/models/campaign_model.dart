import 'package:web3dart/web3dart.dart';

class CampaignModel {
  BigInt? minimumContribution, balance, totalRequests, totalAppovers, target;
  String? title, description, imageUrl;
  EthereumAddress? addressManager;

  CampaignModel({
    this.minimumContribution,
    this.balance,
    this.totalAppovers,
    this.totalRequests,
    this.target,
    this.addressManager,
    this.title,
    this.description,
    this.imageUrl,
  });

  factory CampaignModel.fromJson(List<dynamic> list) {
    return CampaignModel(
      minimumContribution: list[0],
      balance: list[1],
      totalRequests: list[2],
      totalAppovers: list[3],
      addressManager: list[4],
      title: list[5],
      description: list[6],
      imageUrl: list[7],
      target: list[8],
    );
  }
}
