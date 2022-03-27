import 'package:flutter/material.dart';

import '../../../../../../../../shared/config/custom_color.dart';

class Error extends StatelessWidget {
  const Error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.notifications_none_rounded,
      color: UniversalColor.gray4,
      size: 28,
    );
  }
}
