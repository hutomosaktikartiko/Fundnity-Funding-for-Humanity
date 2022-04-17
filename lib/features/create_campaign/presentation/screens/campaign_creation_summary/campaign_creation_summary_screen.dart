import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ndialog/ndialog.dart';

import '../../../../../core/models/return_value_model.dart';
import '../../../../../core/utils/screen_navigator.dart';
import '../../../../../shared/config/custom_color.dart';
import '../../../../../shared/config/custom_text_style.dart';
import '../../../../../shared/config/size_config.dart';
import '../../../../../shared/extension/int_parsing.dart';
import '../../../../../shared/widgets/button/custom_button_label.dart';
import '../../../../../shared/widgets/custom_dialog.dart';
import '../../../../auth/presentation/cubit/wallet/wallet_cubit.dart';
import '../../../../main/presentation/cubit/crowdfunding_deployed_contract/crowdfunding_deployed_contract_cubit.dart';
import '../../../../main/presentation/cubit/web3client/web3client_cubit.dart';
import '../../../data/models/create_campaign_model.dart';
import '../../../data/models/ipfs_upload_model.dart';
import '../../cubit/create_campaign/create_campaign_cubit.dart';
import '../../cubit/create_campaign_target_data/create_campaign_data_cubit.dart';
import 'widgets/description_widget.dart';
import 'widgets/target_widget.dart';
import 'widgets/title_widget.dart';

class CampaignCreationSummary extends StatelessWidget {
  const CampaignCreationSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Campaign Creation Summary',
          style: CustomTextStyle.whiteTextStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocBuilder<CreateCampaignDataCubit, CreateCampaignDataState>(
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.defaultMargin,
            ),
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                "Review your campaign information",
                style: CustomTextStyle.gray2TextStyle.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "The following is the campaign information that you have filled",
                style: CustomTextStyle.gray2TextStyle.copyWith(
                  fontSize: 10,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TargetWidget(
                amount: state.amount,
                time: state.time,
              ),
              const SizedBox(
                height: 15,
              ),
              TitleWidget(
                image: state.image,
                title: state.title,
              ),
              const SizedBox(
                height: 15,
              ),
              DescriptionWidget(
                description: state.description,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        color: BackgroundColor.bgGray,
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultMargin,
          vertical: SizeConfig.defaultMargin + 5,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<CreateCampaignDataCubit, CreateCampaignDataState>(
              builder: (context, state) {
                return CustomButtonLabel(
                  label: "Create Campaign",
                  onTap: () => _onCreateCampaign(
                      context: context, createCampaignDataState: state),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _onCreateCampaign({
    required BuildContext context,
    required CreateCampaignDataState createCampaignDataState,
  }) async {
    // Check image is null
    if (createCampaignDataState.image != null) {
      // Image not null
      ProgressDialog progressDialog = CustomDialog.showProgressDialog(
          context: context, message: "Sedang mengupload gambar");
      // Show progressDialog
      progressDialog.show();
      // Upload Image
      final ReturnValueModel<IpfsUploadModel> resultUploadImage = await context
          .read<CreateCampaignCubit>()
          .uploadImage(image: createCampaignDataState.image!);
      // Check uploadImage is success
      if (resultUploadImage.isSuccess) {
        // uploadImage success
        // showToast success uploadImage
        CustomDialog.showToast(
          message: resultUploadImage.message,
          context: context,
          backgroundColor: UniversalColor.green4,
        );
        // Update progressDialog message
        progressDialog.setMessage(Text("Sedang mengupload data ke ethereum"));
        // Upload Campaign Data
        final ReturnValueModel resultCreateCampaign =
            await context.read<CreateCampaignCubit>().createCampaign(
                  walletPrivateKey: (context.read<WalletCubit>().state as WalletLoaded).wallet.privateKey,
                  campaign: CreateCampaignModel(
                    title: createCampaignDataState.title,
                    description: createCampaignDataState.description,
                    endDate: BigInt.from(createCampaignDataState.time
                            .calculateDayToDateTime()
                            ?.millisecondsSinceEpoch ??
                        0),
                    target: BigInt.from(createCampaignDataState.amount ?? 0),
                    image: resultUploadImage.value?.hash ?? "-",
                  ),
                  web3Client: context.read<Web3ClientCubit>().state.web3client,
                  contract: (context
                          .read<CrowdfundingDeployedContractCubit>()
                          .state as CrowdfundingDeployedContractLoaded)
                      .deployedContract,
                );

        // Dimiss progressDialog
        progressDialog.dismiss();

        // Check createCampaign is success
        if (resultCreateCampaign.isSuccess) {
          // createCampaign success
          // Close CampaignCreationSummaryScreen
          ScreenNavigator.closeScreen(context);
          // Close CreateCampaignScreen
          ScreenNavigator.closeScreen(context);
          // showToast success createCampaign
          CustomDialog.showToast(
            message: resultCreateCampaign.message,
            context: context,
            backgroundColor: UniversalColor.green4,
          );
        } else {
          // createCampaign failed
          // showToast failed createCampaign
          CustomDialog.showToast(
            message: resultCreateCampaign.message,
            context: context,
            backgroundColor: UniversalColor.red,
          );
        }
      } else {
        // uploadImage failed
        // Dimiss progressDialog
        progressDialog.dismiss();
        // showToast failed uploadImage
        CustomDialog.showToast(
          message: resultUploadImage.message,
          context: context,
          backgroundColor: UniversalColor.red,
        );
      }
    } else {
      // Image is null
      // showToast failed uploadImage
      CustomDialog.showToast(
        message: "Campaign image cannot be empty",
        context: context,
        backgroundColor: UniversalColor.red,
      );
    }
  }
}
