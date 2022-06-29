import 'package:crowdfunding/core/models/return_value_model.dart';
import 'package:crowdfunding/features/auth/presentation/cubit/wallet/wallet_cubit.dart';
import 'package:crowdfunding/features/main/presentation/cubit/my_campaigns/my_campaigns_cubit.dart';
import 'package:crowdfunding/features/main/presentation/cubit/web3client/web3client_cubit.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/screen_navigator.dart';
import '../../../features/main/data/models/campaign_model.dart';
import '../../config/custom_color.dart';
import '../../config/custom_text_style.dart';
import '../../extension/big_int_parsing.dart';
import '../../extension/campaign_status_parsing.dart';
import '../../extension/string_parsing.dart';
import '../button/custom_button_label.dart';
import '../custom_dialog.dart';
import '../show_image/show_image_network.dart';

class MyCampaignCard extends StatelessWidget {
  const MyCampaignCard({
    Key? key,
    required this.campaign,
  }) : super(key: key);

  final CampaignModel? campaign;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: UniversalColor.gray4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ShowImageNetwork(
                height: 70,
                width: 80,
                imageUrl: campaign?.image.stringHashImageToImageUrl() ?? "",
                borderRadius: BorderRadius.circular(5),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: SizedBox(
                  height: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        campaign?.title ?? "-",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: CustomTextStyle.gray2TextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: campaign?.status.campaignStatusToBgColor(),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          campaign?.status.campaignStatusToLabel() ?? "-",
                          style: CustomTextStyle.gray4TextStyle.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color:
                                campaign?.status?.campaignStatusToStrongColor(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          buildBottomWidget(context),
        ],
      ),
    );
  }

  Widget buildBottomWidget(BuildContext context) {
    if (campaign?.status == CampaignStatus.Inactive) {
      return CustomButtonLabel(
        label: "Re-Create Campaign",
        onTap: () {
          // TODO: Re-create campaign
        },
      );
    } else if (campaign?.status == CampaignStatus.Draft) {
      return CustomButtonLabel(
        label: "Continue Create Campaign",
        onTap: () {
          // TODO: Continue create campaign
        },
      );
    } else if (campaign?.status == CampaignStatus.Complete) {
      return CustomButtonLabel(
        label: "Claim Balance",
        onTap: () => _onClaimBalance(context),
      );
    } else if (campaign?.status == CampaignStatus.Claimed) {
      return CustomButtonLabel(
        label: "Balance Has Been Claimed",
        onTap: () => _onBalanceHasBeenClaimed(context),
        backgroundColor: Colors.white,
        borderColor: UniversalColor.green4,
        labelColor: UniversalColor.green4,
      );
    } else if (campaign?.status == CampaignStatus.EmptyBalance) {
      return CustomButtonLabel(
        label: "Balance is Empty",
        onTap: () => _onBalanceEmpty(context),
        backgroundColor: UniversalColor.gray6,
        borderColor: UniversalColor.gray4,
        labelColor: UniversalColor.gray4,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: <TextSpan>[
              TextSpan(
                text:
                    "${campaign?.balance.weiEtherToDoubleEther().toStringAsFixed(4)} ETH",
                style: CustomTextStyle.green4TextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: " Funds Collected | ",
                style: CustomTextStyle.gray3TextStyle.copyWith(
                  fontSize: 12,
                ),
              ),
              TextSpan(
                text: (campaign?.endDate.timestampToIntDays() ?? 0).toString(),
                style: CustomTextStyle.green4TextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: " Days left",
                style: CustomTextStyle.gray3TextStyle.copyWith(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        LinearPercentIndicator(
          percent: campaign?.balance
                  .bigIntToPercentTargetMax1(target: campaign?.target) ??
              0,
          lineHeight: 8,
          barRadius: Radius.circular(3),
          padding: EdgeInsets.only(right: 5),
          progressColor: UniversalColor.green4,
          animation: true,
          trailing: Text(
            (campaign?.balance
                        ?.bigIntToPercentTarget(target: campaign?.target)
                        .toStringAsFixed(1) ??
                    "0") +
                "%",
            style: CustomTextStyle.green4TextStyle.copyWith(
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  void _onClaimBalance(BuildContext context) {
    CustomDialog.alertDialogConfirmation(
      context: context,
      onConfirmation: () async {
        CustomProgressDialog progressDialog =
            CustomDialog.showCustomProgressDialog(context: context);

        // Show progressDialog
        progressDialog.show();

        // Claim balance
        final ReturnValueModel result =
            await context.read<MyCampaignsCubit>().claimCampaign(
                  web3Client: context.read<Web3ClientCubit>().state.web3client,
                  walletPrivateKey:
                      (context.read<WalletCubit>().state as WalletLoaded)
                          .wallet
                          .privateKey,
                  campaign: campaign,
                  address: campaign?.address,
                );

        // Close progressDialog
        progressDialog.dismiss();

        // Close ConfirmationDialog
        ScreenNavigator.closeScreen(context);

        // Check status claim campaign
        if (result.isSuccess) {
          // Success claim
          CustomDialog.showToast(
            message: result.message,
            context: context,
            backgroundColor: UniversalColor.green4,
          );
        } else {
          // Failed claim
          CustomDialog.showToast(
            message: result.message,
            context: context,
            backgroundColor: UniversalColor.red,
          );
        }
      },
      buttonOkLabel: "Claim",
      icon: Icons.attach_money,
      iconColor: UniversalColor.green4,
      label: "Are your sure want claim this campaign balance?",
    ).show(context);
  }

  void _onBalanceHasBeenClaimed(BuildContext context) {
    CustomDialog.alertDialogInfo(
      context: context,
      label: "Your campaign balance is Claimed",
      icon: Icons.done,
      iconColor: UniversalColor.blue1,
      onTap: () => ScreenNavigator.closeScreen(context),
      buttonLabel: "Close",
    ).show(context);
  }

  void _onBalanceEmpty(BuildContext context) {
    CustomDialog.alertDialogInfo(
      context: context,
      label: "Your campaign balance is Empty",
      icon: Icons.money_off,
      iconColor: UniversalColor.yellow,
      onTap: () => ScreenNavigator.closeScreen(context),
      buttonLabel: "Close",
    ).show(context);
  }
}
