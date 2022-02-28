import 'package:flutter/material.dart';

import '../../../../../../core/config/custom_color.dart';
import '../../../../../../core/config/custom_text_style.dart';
import 'notification/notification_widget.dart';

class DonationPageAppBar extends StatelessWidget {
  const DonationPageAppBar({Key? key}) : super(key: key);

  AppBar build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: _openSearchScreen,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: UniversalColor.gray4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: UniversalColor.gray4,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Type Children, Health, etc...",
                      style:
                          CustomTextStyle.gray4TextStyle.copyWith(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Icon(
            Icons.favorite_border,
            color: UniversalColor.gray4,
            size: 28,
          ),
          const SizedBox(
            width: 5,
          ),
           GestureDetector(
            onTap: _openNotificationScreen,
            child: NotificationWidget(),
          ),
        ],
      ),
    );
  }

  void _openSearchScreen() {
    // TODO => Navigator to search screen
  }

  void _openNotificationScreen() {
    // TODO => Navigator to search screen
  }
}
