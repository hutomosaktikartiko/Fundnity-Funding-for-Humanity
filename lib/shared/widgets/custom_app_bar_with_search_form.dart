import 'package:flutter/material.dart';

import '../../core/utils/screen_navigator.dart';
import '../../shared/config/custom_color.dart';
import '../../shared/config/custom_text_style.dart';
import 'custom_text_field.dart';

class CustomAppBarWithSearchForm extends StatelessWidget {
  const CustomAppBarWithSearchForm({
    Key? key,
    required this.formHintText,
    this.isShowBackButton = false,
    this.isShowFavoriteButton = false,
    this.textEditingController,
    this.isReadOnly = false,
    this.onTap,
    this.isAutoFocus = false,
    this.onChanged,
  }) : super(key: key);

  final String formHintText;
  final Function()? onTap, onChanged;
  final bool isShowBackButton, isShowFavoriteButton, isReadOnly, isAutoFocus;
  final TextEditingController? textEditingController;

  AppBar build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          ShowBackButton(
            isShowBackButton: isShowBackButton,
          ),
          Expanded(
            child: CustomTextField(
              controller: textEditingController,
              borderRadius: 10,
              enabledBorderColor: UniversalColor.gray4,
              focusedBorderColor: UniversalColor.gray4,
              readOnly: isReadOnly,
              onTap: onTap,
              autofocus: isAutoFocus,
              hintText: formHintText,
              onChanged: onChanged,
              style: CustomTextStyle.gray2TextStyle.copyWith(fontSize: 15),
              hintStyle: CustomTextStyle.gray4TextStyle.copyWith(fontSize: 15),
            ),
          ),
          ShowFavoriteButton(
            isShowFavoriteButton: isShowFavoriteButton,
          ),
          // TODO: Add clear button, when keyword is not empty
        ],
      ),
    );
  }
}

class ShowBackButton extends StatelessWidget {
  const ShowBackButton({
    Key? key,
    required this.isShowBackButton,
  }) : super(key: key);

  final bool isShowBackButton;

  @override
  Widget build(BuildContext context) {
    if (isShowBackButton) {
      return GestureDetector(
        onTap: () => _onBackButtonTap(context),
        child: const Padding(
          padding: const EdgeInsets.only(right: 10),
          child: const Icon(
            Icons.arrow_back,
            color: UniversalColor.gray4,
            size: 28,
          ),
        ),
      );
    }
    return SizedBox.shrink();
  }

  void _onBackButtonTap(BuildContext context) {
    ScreenNavigator.closeScreen(context);
  }
}

class ShowFavoriteButton extends StatelessWidget {
  const ShowFavoriteButton({
    Key? key,
    required this.isShowFavoriteButton,
  }) : super(key: key);

  final bool isShowFavoriteButton;

  @override
  Widget build(BuildContext context) {
    if (isShowFavoriteButton) {
      return GestureDetector(
        onTap: () => _onFavoriteButtonTap(context),
        child: const Padding(
          padding: const EdgeInsets.only(left: 10),
          child: const Icon(
            Icons.favorite_border,
            color: UniversalColor.gray4,
            size: 28,
          ),
        ),
      );
    }
    return SizedBox.shrink();
  }

  void _onFavoriteButtonTap(BuildContext context) {
    // TODO: Navigator to favorite campaign
  }
}
