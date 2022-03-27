import 'package:flutter/material.dart';

import '../../../shared/config/custom_color.dart';
import '../../../shared/config/custom_text_style.dart';
import '../../../shared/config/size_config.dart';
import '../../../shared/extension/string_parsing.dart';
import '../../../shared/widgets/button/custom_button_label.dart';
import '../../../shared/widgets/show_image/show_image_network.dart';
import 'widgets/detail_amount/detail_amount_widget.dart';
import 'widgets/transaction_speed/transaction_speed_widget.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  final int? donationAmount;

  const PaymentConfirmationScreen({
    Key? key,
    required this.donationAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Review Donation",
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
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.defaultMargin,
        ),
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              ShowImageNetwork(
                imageUrl: "",
                height: 60,
                width: 70,
                borderRadius: BorderRadius.circular(5),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Help Avisa to Continue Her College Study on Stanford University",
                      style: CustomTextStyle.gray2TextStyle.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text.rich(
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "By",
                            style: CustomTextStyle.gray3TextStyle.copyWith(
                              fontSize: 12,
                            ),
                          ),
                          TextSpan(
                            text: " 0x4994986400D969EeA1f90bE393A5F1B1b72a664A"
                                .walletAddressSplit(),
                            style: CustomTextStyle.gray3TextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            height: 30,
          ),
          TransactionSpeedWidget(),
          const Divider(
            height: 30,
          ),
          DetailAmountWidget(
            donationAmount: donationAmount,
          ),
        ],
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
            CustomButtonLabel(
              label: "Send Donation",
              onTap: _onSendDonation,
            ),
          ],
        ),
      ),
    );
  }

  void _onSendDonation() {
    // TODO => Handle send donation
  }
}
