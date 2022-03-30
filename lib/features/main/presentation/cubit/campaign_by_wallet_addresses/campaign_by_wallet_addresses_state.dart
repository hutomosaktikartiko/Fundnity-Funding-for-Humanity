part of 'campaign_by_wallet_addresses_cubit.dart';

abstract class CampaignByWalletAddressesState extends Equatable {
  const CampaignByWalletAddressesState();

  @override
  List<Object?> get props => [];
}

class CampaignByWalletAddressesInitial extends CampaignByWalletAddressesState {}

class CampaignsByWalletAddressesLoaded extends CampaignByWalletAddressesState {
  final List<EthereumAddress?> addresses;

  const CampaignsByWalletAddressesLoaded({
    required this.addresses,
  });

  @override
  List<Object?> get props => [addresses];
}

class CampaignByWalletAddressesEmpty extends CampaignByWalletAddressesState {}

class CampaignByWalletAddressesLoadingFailure
    extends CampaignByWalletAddressesState {
  final String message;

  const CampaignByWalletAddressesLoadingFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
