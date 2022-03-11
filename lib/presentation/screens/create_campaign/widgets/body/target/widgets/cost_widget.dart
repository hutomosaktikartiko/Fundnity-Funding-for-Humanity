import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/config/custom_color.dart';
import '../../../../../../../core/config/custom_text_style.dart';
import '../../../../../../cubit/cubits.dart';
import '../../../../../../widgets/custom_text_field.dart';
import '../../../custom_text_title.dart';

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
        TextEditingController(text: widget.amount?.toStringAsFixed(2));
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
    context.read<CreateCampaignDataCubit>().setAmount(
          amount: double.parse(amountController?.text ?? "0"),
        );
  }
}
