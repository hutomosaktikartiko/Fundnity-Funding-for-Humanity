import 'package:web3dart/web3dart.dart';

enum CampaignStatus {
  Draft,
  Pending,
  Active,
  Inactive,
  Complete,
  Claimed,
  EmptyBalance,
}

// class CampaignModel {
//   BigInt? minimumContribution, balance, totalRequests, totalAppovers, target;
//   String? title, description, imageUrl;
//   EthereumAddress? addressManager;

//   CampaignModel({
//     this.minimumContribution,
//     this.balance,
//     this.totalAppovers,
//     this.totalRequests,
//     this.target,
//     this.addressManager,
//     this.title,
//     this.description,
//     this.imageUrl,
//   });

//   factory CampaignModel.fromJson(List<dynamic> list) {
//     return CampaignModel(
//       minimumContribution: list[0],
//       balance: list[1],
//       totalRequests: list[2],
//       totalAppovers: list[3],
//       addressManager: list[4],
//       title: list[5],
//       description: list[6],
//       imageUrl: list[7],
//       target: list[8],
//     );
//   }
// }

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

class CampaignModel {
  String? image, title, description;
  BigInt? balance, target, startDate, endDate, blockNumber;
  bool? isComplete;
  EthereumAddress? creatorAddress;
  EthereumAddress? address;
  CampaignStatus? status;

  CampaignModel({
    this.image,
    this.title,
    this.description,
    this.balance,
    this.target,
    this.startDate,
    this.endDate,
    this.isComplete,
    this.creatorAddress,
    this.address,
    this.status,
    this.blockNumber,
  });

  factory CampaignModel.fromJson(List<dynamic> list) {
    return CampaignModel(
      image: list[0] ?? null,
      title: list[1] ?? null,
      description: list[2] ?? null,
      balance: list[3] ?? null,
      target: list[4] ?? null,
      startDate: list[5] ?? null,
      endDate: list[6] ?? null,
      isComplete: list[7] ?? null,
      creatorAddress: list[8] ?? null,
      address: list[9] ?? null,
      blockNumber: list[10] ?? null,
      status: setCampaignStatus(
        balance: list[3] ?? null,
        target: list[4] ?? null,
        startDate: list[5] ?? null,
        endDate: list[6] ?? null,
        isComplete: list[7] ?? null,
      ),
    );
  }

  static setCampaignStatus({
    BigInt? balance,
    BigInt? target,
    BigInt? startDate,
    BigInt? endDate,
    bool? isComplete,
  }) {
    if (balance == null ||
        target == null ||
        startDate == null ||
        endDate == null) {
      return CampaignStatus.Active;
    }
    if (isComplete == true) {
      return CampaignStatus.Claimed;
    }
    if (balance >= target) {
      return CampaignStatus.Complete;
    }
    if (BigInt.from(DateTime.now().millisecondsSinceEpoch) > endDate) {
      if (balance <= BigInt.zero) {
        return CampaignStatus.EmptyBalance;
      }

      return CampaignStatus.Complete;
    }

    return CampaignStatus.Active;
  }

  CampaignModel copyWith({
    String? image,
    String? title,
    String? description,
    BigInt? balance,
    BigInt? target,
    BigInt? startDate,
    BigInt? endDate,
    bool? isComplete,
    EthereumAddress? creatorAddress,
    EthereumAddress? address,
    CampaignStatus? status,
    BigInt? blockNumber,
  }) {
    return CampaignModel(
      image: image ?? this.image,
      title: title ?? this.title,
      description: description ?? this.description,
      balance: balance ?? this.balance,
      target: target ?? this.target,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isComplete: isComplete ?? this.isComplete,
      creatorAddress: creatorAddress ?? this.creatorAddress,
      address: address ?? this.address,
      status: status ?? this.status,
      blockNumber: blockNumber ?? this.blockNumber,
    );
  }
}
