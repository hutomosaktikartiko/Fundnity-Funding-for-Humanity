import '../../core/config/contract_config.dart';
import '../../core/config/urls_config.dart';

class ContractLocalModel {
  String name, address, path;

  ContractLocalModel({
    required this.name,
    required this.address,
    required this.path,
  });
}

final ContractLocalModel campaignContractLocal = ContractLocalModel(
  name: "Campaign",
  address: ContractConfig.crowdfunding,
  path: UrlsConfig.campaignContractPath,
);

final ContractLocalModel campaignFactoryContractLocal = ContractLocalModel(
  name: "CampaignFactory",
  address: ContractConfig.crowdfunding,
  path: UrlsConfig.campaignFactoryContractPath,
);
