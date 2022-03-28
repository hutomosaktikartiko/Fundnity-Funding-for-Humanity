import 'package:flutter/material.dart';

import '../../../../../../../../../../shared/config/custom_color.dart';
import '../../../../../../../../../../shared/widgets/icon_button_with_counter.dart';

class Loaded extends StatelessWidget {
  const Loaded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconWithCounter(
      counter: "99",
      icon: const Icon(
        Icons.notifications_none_rounded,
        color: UniversalColor.gray4,
        size: 28,
      ),
    );
  }
}
