import 'package:flutter/material.dart';

import '../../../../core/config/custom_color.dart';
import '../../../../core/config/custom_text_style.dart';
import '../../../widgets/custom_box_shadow.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({
    Key? key,
    required this.onEdit,
    required this.bodyCard,
    required this.number,
    required this.title,
  }) : super(key: key);

  final Function() onEdit;
  final Widget bodyCard;
  final String number, title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        border: Border.all(color: UniversalColor.gray5),
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          CustomBoxShadow.defaultBoxShadow(),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: UniversalColor.green4,
                      ),
                      child: Text(
                        number,
                        style: CustomTextStyle.whiteTextStyle
                            .copyWith(fontSize: 12),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      title,
                      style: CustomTextStyle.gray2TextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: onEdit,
                  child: Text(
                    "Edit",
                    style:
                        CustomTextStyle.blue2TextStyle.copyWith(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: UniversalColor.gray5,
            thickness: 1,
            height: 30,
          ),
          bodyCard,
        ],
      ),
    );
  }
}
