import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../core/models/return_value_model.dart';
import '../../../data/models/campaign_firestore_model.dart';
import '../../../data/models/campaign_model.dart';
import '../../../data/models/transaction_status_model.dart';
import '../../../data/repositories/campaign_repository.dart';
import '../../../data/repositories/transaction_repository.dart';

part 'my_campaigns_state.dart';

class MyCampaignsCubit extends Cubit<MyCampaignsState> {
  MyCampaignsCubit({
    required this.campaignRepository,
    required this.transactionRepository,
  }) : super(MyCampaignsInitial());

  final CampaignRepository campaignRepository;
  final TransactionRepository transactionRepository;

   Future<void> getMyCampaigns({
    required EthereumAddress? address,
  }) async {
    emit(MyCampaignsLoading());
    final ReturnValueModel<List<CampaignFirestoreModel>> result =
        await campaignRepository.getMyCampaigns(address: address);

    if (result.isSuccess && result.value != null) {
      if ((result.value?.length ?? 0) > 0) {
        // Sort campaign by timestamp
        result.value!.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));

        emit(MyCampaignsLoaded(campaigns: result.value!));
      } else {
        emit(MyCampaignsEmpty());
      }
    } else {
      emit(MyCampaignsLoadingFailure(message: result.message));
    }
  }

  Future<CampaignModel?> getMyCampaign({
    required List<CampaignModel> campaigns,
    required CampaignFirestoreModel? campaignFirestore,
  }) async {
    // Check if campaign from firebase is in the list campaign from smart contract
    CampaignModel? _campaign = campaigns.firstWhereOrNull((element) =>
        element.title?.toLowerCase() == campaignFirestore?.title?.toLowerCase());

    // Campaign is not in the list
    if (_campaign == null) {
      // Get campaign transaction status
      CampaignStatus status = await getTransactionStatus(
          transactionHash: campaignFirestore?.transactionHash);

      // Assign transaction status and campaign from firebase to new campaign model
      _campaign = CampaignModel(
        title: campaignFirestore?.title,
        description: campaignFirestore?.description,
        image: campaignFirestore?.image,
        status: status,
        creatorAddress:
            EthereumAddress.fromHex(campaignFirestore?.creatorAddress ?? ""),
        startDate: BigInt.from(campaignFirestore?.startDate ?? 0),
        endDate: BigInt.from(campaignFirestore?.endDate ?? 0),
        target: BigInt.from(campaignFirestore?.target ?? 0),
      );
    }

    return _campaign;
  }

  // Get CampaignStatus by Transaction Hash
  Future<CampaignStatus> getTransactionStatus({
    required String? transactionHash,
  }) async {
    final ReturnValueModel<TransactionStatusModel?> result =
        await transactionRepository.getTransactionStatus(
            transactionHash: transactionHash);

    if (result.isSuccess && result.value != null) {
      // 0 -> Pending & Success
      // 1 -> Error
      if (result.value!.isError == "0") {
        return CampaignStatus.Pending;
      }
    }

    return CampaignStatus.Inactive;
  }
}
