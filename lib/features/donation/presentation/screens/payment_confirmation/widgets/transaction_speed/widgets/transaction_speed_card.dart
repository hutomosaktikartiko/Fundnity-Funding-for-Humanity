import 'package:flutter/material.dart';

import '../../../../../../../../shared/config/custom_color.dart';
import '../../../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../../../shared/extension/string_parsing.dart';
import '../../../../../../data/models/gas_model.dart';

class TransactionSpeedCard extends StatelessWidget {
  const TransactionSpeedCard({
    Key? key,
    required this.gas,
    required this.isActive,
  }) : super(key: key);

  final GasModel? gas;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 10,
          width: 10,
          decoration: BoxDecoration(
            color: (isActive) ? UniversalColor.green4 : UniversalColor.gray5,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color:
                    (isActive) ? UniversalColor.green4 : UniversalColor.gray5,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      gas?.title ?? "-",
                      style: CustomTextStyle.gray1TextStyle.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      "Gas Price ${gas?.gasPriceInGwei ?? 0} GWEI",
                      style: CustomTextStyle.gray2TextStyle.copyWith(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                Text(
                  "~ ${gas?.estimationTime.stringSecondsToStringMinutes() ?? 0}",
                  style: CustomTextStyle.gray3TextStyle,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
