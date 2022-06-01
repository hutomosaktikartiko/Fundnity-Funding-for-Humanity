import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../core/models/return_value_model.dart';
import '../../../data/models/campaign_firestore_model.dart';
import '../../../data/models/campaign_model.dart';
import '../../../data/models/transaction_receipt_model.dart';
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
    required Web3Client web3Client,
    required EthereumAddress? address,
    required List<CampaignModel> campaigns,
  }) async {
    emit(MyCampaignsLoading());
    final ReturnValueModel<List<CampaignFirestoreModel>> result =
        await campaignRepository.getMyCampaigns(
      web3Client: web3Client,
      address: address,
    );

    if (result.isSuccess) {
      if ((result.value?.length ?? 0) > 0) {
        // TODO: Sort campaigns by timestamp DESC in result.value from firebase
        setLoadedCampaigns(
            campaignsFirestore: result.value, campaigns: campaigns);
      } else {
        emit(MyCampaignsEmpty());
      }
    } else {
      emit(MyCampaignsLoadingFailure(message: result.message));
    }
  }

  // TODO: Handle drafted campaign
  Future<void> setLoadedCampaigns({
    required List<CampaignFirestoreModel>? campaignsFirestore,
    required List<CampaignModel>? campaigns,
  }) async {
    List<CampaignModel?> newCampaigns = [];

    for (CampaignFirestoreModel campaignFirestore
        in (campaignsFirestore ?? [])) {
      // Check transaction status
      final ReturnValueModel<TransactionReceiptModel?> result =
          await transactionRepository.getTransactionReceipt(
              transactionHash: campaignFirestore.transactionHash);

      CampaignModel? newCampaign;

      if (result.isSuccess && result.value != null) {
        // Success
        if (result.value!.status == TransactionStatus.SUCCESS) {
          // Get campaign from list of camapign from contract
          // and check it with campaign from firebase
          // and assign it to newCampaign
          newCampaign = campaigns?.firstWhereOrNull(
            (element) => element.blockNumber == result.value!.blockNumber,
          );
          // if newCampaign is null, it means that campaign is not in contract
          if (newCampaign == null) {
            // Set value newCampaign with campaign from firebase
            // set campaign status to Pending
            newCampaign = CampaignModel(
              title: campaignFirestore.title,
              description: campaignFirestore.description,
              image: campaignFirestore.image,
              status: CampaignStatus.Pending,
              creatorAddress: EthereumAddress.fromHex(
                  campaignFirestore.creatorAddress ?? ""),
              startDate: BigInt.from(campaignFirestore.startDate ?? 0),
              endDate: BigInt.from(campaignFirestore.endDate ?? 0),
              target: BigInt.from(int.parse(campaignFirestore.target ?? "0")),
            );
          }
          // Set campaign status
          newCampaign.copyWith(
            status: newCampaign.isComplete == true
                ? CampaignStatus.Complete
                : CampaignStatus.Active,
          );
        } else {
          // Failed
          newCampaign = CampaignModel(
            title: campaignFirestore.title,
            description: campaignFirestore.description,
            image: campaignFirestore.image,
            status: CampaignStatus.Inactive,
            creatorAddress:
                EthereumAddress.fromHex(campaignFirestore.creatorAddress ?? ""),
            startDate: BigInt.from(campaignFirestore.startDate ?? 0),
            endDate: BigInt.from(campaignFirestore.endDate ?? 0),
            target: BigInt.from(int.parse(campaignFirestore.target ?? "0")),
          );
        }
      }

      // Pending
      if (result.isSuccess && result.value == null) {
        newCampaign = CampaignModel(
          title: campaignFirestore.title,
          description: campaignFirestore.description,
          image: campaignFirestore.image,
          status: CampaignStatus.Pending,
          creatorAddress:
              EthereumAddress.fromHex(campaignFirestore.creatorAddress ?? ""),
          startDate: BigInt.from(campaignFirestore.startDate ?? 0),
          endDate: BigInt.from(campaignFirestore.endDate ?? 0),
          target: BigInt.from(int.parse(campaignFirestore.target ?? "0")),
        );
      }

      newCampaigns.add(newCampaign);
    }

    // Emit
    emit(MyCampaignsLoaded(campaigns: newCampaigns));
  }
}
