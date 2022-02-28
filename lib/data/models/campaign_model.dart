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

// image => string
// title => string
// description => string
// balance => uint
// target => uint
// isComplete => bool
// startDate => uint
// endDate => uint
// creatorAddress => address
// contributors => address[]

class NewCampaignModel {
  String? image, title, description;
  BigInt? balance, target, startDate, endDate;
  bool? isComplete;
  EthereumAddress? creatorAddress;
  List<EthereumAddress?>? contributors;

  NewCampaignModel({
    this.image,
    this.title,
    this.description,
    this.balance,
    this.target,
    this.startDate,
    this.endDate,
    this.isComplete,
    this.creatorAddress,
    this.contributors,
  });

  factory NewCampaignModel.fromList(List<dynamic> list) {
    return NewCampaignModel(
      image: list[0],
      title: list[1],
      description: list[2],
      balance: list[3],
      target: list[4],
      startDate: list[5],
      endDate: list[6],
      isComplete: list[7],
      creatorAddress: list[8],
      contributors: list[9],
    );
  }
}
