import 'package:flutter/material.dart';

import '../../../../../../shared/widgets/custom_dialog.dart';
import '../widgets/body.dart';

class ConnectionLoading extends StatelessWidget {
  const ConnectionLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Body(
      child: CustomDialog.showCircularProgressIndicator(),
    );
  }
}
