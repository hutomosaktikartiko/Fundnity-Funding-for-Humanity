import 'package:flutter/material.dart';

import '../../../../../../shared/config/custom_color.dart';
import '../../../../data/models/create_campaign_progress_model.dart';

class CreateCampaignProgressItem extends StatelessWidget {
  const CreateCampaignProgressItem({
    Key? key,
    required this.progress,
    required this.isActive,
    required this.width,
    required this.isFirst,
    required this.isLast,
  }) : super(key: key);

  final CreateCampaignProgressModel progress;
  final bool isActive, isFirst, isLast;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: width / 2,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          (isFirst) ? Colors.transparent : UniversalColor.gray3,
                    ),
                  ),
                ),
                Container(
                  width: width / 2,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          (isLast) ? Colors.transparent : UniversalColor.gray3,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 25,
              width: 25,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: (isActive) ? UniversalColor.green4 : Colors.white,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color:
                      (isActive) ? UniversalColor.green4 : UniversalColor.gray3,
                ),
              ),
              child: Text(
                progress.number.toString(),
                style: TextStyle(
                  color: (isActive) ? Colors.white : UniversalColor.gray3,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          progress.label ?? "-",
          style: TextStyle(
            color: (isActive) ? UniversalColor.green4 : UniversalColor.gray3,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
