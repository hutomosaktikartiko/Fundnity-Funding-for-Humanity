import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../../shared/config/custom_color.dart';
import '../../../../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../../../../shared/widgets/custom_text_field.dart';
import '../../../../../../cubit/create_campaign_target_data/create_campaign_data_cubit.dart';
import '../../../custom_text_title.dart';

import 'package:crowdfunding/shared/extension/string_parsing.dart';

class CostWidget extends StatefulWidget {
  const CostWidget({
    Key? key,
    required this.amount,
  }) : super(key: key);

  final double? amount;

  @override
  _CostWidgetState createState() => _CostWidgetState();
}

class _CostWidgetState extends State<CostWidget> {
  TextEditingController? amountController;

  @override
  void initState() {
    super.initState();
    amountController =
        TextEditingController(text: widget.amount?.toStringAsFixed(2) ?? "0");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextTitle(
          title: "Determine the estimated cost",
        ),
        const SizedBox(
          height: 5,
        ),
        CustomTextField(
          controller: amountController,
          enabledBorderColor: UniversalColor.gray4,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.right,
          onEditingComplete: _onSave,
          onChanged: _onSave,
          style: CustomTextStyle.blackTextStyle.copyWith(
            fontSize: 15,
          ),
          prefixIcon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ETH",
                style: CustomTextStyle.blackTextStyle.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onSave() {
    if (amountController?.text.contains(',') == true) {
      setState(() {
        amountController =
            TextEditingController(text: amountController?.text.removeComa());
      });
    }
    if (amountController?.text != '' || amountController?.text != "0") {
      context.read<CreateCampaignDataCubit>().setAmount(
            amount: double.parse(amountController?.text ?? "0"),
          );
    }
  }
}
