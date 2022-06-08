import 'package:flutter/material.dart';

import '../config/custom_color.dart';

class ObscurePasswordIcon extends StatelessWidget {
  const ObscurePasswordIcon({
    Key? key,
    required this.isObscure,
  }) : super(key: key);

  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    return Icon(
      (isObscure) ? Icons.visibility : Icons.visibility_off,
      color: UniversalColor.gray3,
    );
  }
}
