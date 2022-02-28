import 'package:flutter/material.dart';

import 'states/loaded.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Loaded();
  }
}
