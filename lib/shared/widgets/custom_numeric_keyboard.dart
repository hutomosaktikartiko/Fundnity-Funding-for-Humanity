import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

import '../config/custom_color.dart';

class CustomNumericKeyboard extends StatelessWidget {
  const CustomNumericKeyboard({
    Key? key,
    required this.onKeyboardTap,
    this.leftIcon,
    this.onLeftButtonTap,
    this.onRightButtonTap,
  }) : super(key: key);

  final Function(String value) onKeyboardTap;
  final Function()? onLeftButtonTap, onRightButtonTap;
  final Icon? leftIcon;

  @override
  Widget build(BuildContext context) {
    return NumericKeyboard(
      onKeyboardTap: onKeyboardTap,
      leftButtonFn: onLeftButtonTap,
      rightButtonFn: onRightButtonTap,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      textColor: UniversalColor.gray1,
      rightIcon: Icon(
        Icons.backspace_outlined,
        color: UniversalColor.gray1,
      ),
      leftIcon: leftIcon,
    );
  }
}
