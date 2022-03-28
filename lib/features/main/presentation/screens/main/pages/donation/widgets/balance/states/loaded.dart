import 'package:flutter/material.dart';

import '../../../../../../../../../../shared/config/custom_color.dart';
import '../../../../../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../../../../../shared/extension/string_parsing.dart';
import '../../../../../../../../../../shared/widgets/custom_box_shadow.dart';

class Loaded extends StatelessWidget {
  const Loaded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: UniversalColor.green4,
        boxShadow: [CustomBoxShadow.defaultBoxShadow()],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "0x4994986400D969EeA1f90bE393A5F1B1b72a664A"
                    .walletAddressSplit(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "100.00 ETH",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          Material(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              onTap: () => _openAddBalanceBottomSheet(context),
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                child: Text(
                  "ADD BALANCE",
                  style: CustomTextStyle.green4TextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openAddBalanceBottomSheet(BuildContext context) {
    // TODO => Open Add Balance BottomSheet
  }
}
