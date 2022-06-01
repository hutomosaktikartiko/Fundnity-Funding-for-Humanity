import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';

import '../../../../../core/utils/screen_navigator.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../../shared/config/custom_color.dart';
import '../../../../../shared/config/custom_text_style.dart';
import '../../../../../shared/config/size_config.dart';
import '../../../../../shared/widgets/button/custom_button_label.dart';
import '../../../../../shared/widgets/custom_dialog.dart';
import '../../../../../shared/widgets/custom_text_field.dart';
import '../../../../main/data/models/campaign_model.dart';
import '../../../data/models/donation_amount_model.dart';
import '../payment_confirmation/payment_confirmation_screen.dart';
import 'widgets/custom_amount_card.dart';
import 'widgets/custom_container_with_border.dart';

class FillDonationAmount extends StatefulWidget {
  const FillDonationAmount({
    Key? key,
    required this.campaign,
    required this.address,
  }) : super(key: key);

  final CampaignModel? campaign;
  final EthereumAddress? address;

  @override
  _FillDonationAmountState createState() => _FillDonationAmountState();
}

class _FillDonationAmountState extends State<FillDonationAmount> {
  TextEditingController amountController = TextEditingController();

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.campaign?.title ?? "-",
          style: CustomTextStyle.gray1TextStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: IconThemeData(
          color: UniversalColor.gray1,
        ),
        backgroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: () => Utils.hideKeyboard(context),
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.defaultMargin,
          ),
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "Enter the donation amount",
                style: CustomTextStyle.gray2TextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ...mockListDonationAmounts
                .asMap()
                .map(
                  (key, value) => MapEntry(
                    key,
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                        onTap: () => _onAmountPayment(amount: value),
                        child: CustomAmountCard(
                          amount: value,
                        ),
                      ),
                    ),
                  ),
                )
                .values
                .toList(),
            CustomContainerWithBorder(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Other donation amount",
                    style: CustomTextStyle.gray1TextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // TODO: Fix manual input donation amount
                  CustomTextField(
                    controller: amountController,
                    fillColor: UniversalColor.gray6,
                    enabledBorderColor: UniversalColor.gray6,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    prefixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Rp",
                          style: CustomTextStyle.blackTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    hintStyle: CustomTextStyle.gray1TextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black26,
                    ),
                    textAlign: TextAlign.right,
                    hintText: "0",
                    style: CustomTextStyle.blackTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: _onChanged,
                    onEditingComplete: _onPayment,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Min. donation 0.0001 ETH",
                    style: CustomTextStyle.gray3TextStyle.copyWith(
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultMargin,
          vertical: SizeConfig.defaultMargin + 5,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildButtonPayment(),
          ],
        ),
      ),
    );
  }

  Widget buildButtonPayment() {
    if (amountController.text.trim() != "") {
      return CustomButtonLabel(
        label: "Continue Payment",
        onTap: _onPayment,
      );
    } else {
      return CustomButtonLabel(
        label: "Continue Payment",
        backgroundColor: BackgroundColor.bgGray,
        borderColor: BackgroundColor.bgGray,
        labelColor: UniversalColor.gray5,
        onTap: _onPayment,
      );
    }
  }

  void _onChanged() {
    // Rebuild widget
    setState(() {});
  }

  void _onAmountPayment({required DonationAmountModel? amount}) {
    ScreenNavigator.startScreen(
        context,
        PaymentConfirmationScreen(
          donationAmount: amount!.amountInWei!,
          campaign: widget.campaign,
          address: widget.address,
        ));
  }

  void _onPayment() {
    if (amountController.text.trim() == "" ||
        double.parse(amountController.text.trim()) < 0.0001) {
      CustomDialog.showToast(
        message: "Minimum contribution 0.0001 ETH",
        context: context,
        backgroundColor: UniversalColor.red,
      );
    } else {
      ScreenNavigator.startScreen(
          context,
          PaymentConfirmationScreen(
            campaign: widget.campaign,
            // TODO: Fix manual input donation amount
            donationAmount: BigInt.from(int.parse(amountController.text)),
            address: widget.address,
          ));
    }
  }
}
