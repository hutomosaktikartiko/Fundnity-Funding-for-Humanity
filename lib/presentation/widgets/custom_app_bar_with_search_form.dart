import 'package:flutter/material.dart';

import '../../core/config/custom_color.dart';
import '../../core/config/custom_text_style.dart';
import '../screens/main/pages/donation/widgets/notification/notification_widget.dart';

class CustomAppBarWithSearchForm extends StatelessWidget {
  const CustomAppBarWithSearchForm({
    Key? key,
    required this.formHintText,
    required this.openSearchScreen,
  }) : super(key: key);

  final String formHintText;
  final Function() openSearchScreen;

  AppBar build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: openSearchScreen,
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
                      formHintText,
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

  void _openNotificationScreen() {
    // TODO => Navigator to search screen
  }
}
