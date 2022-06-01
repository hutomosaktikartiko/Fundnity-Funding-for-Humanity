import 'package:flutter/material.dart';

import '../../../../../../shared/config/size_config.dart';
import '../../../../../../shared/widgets/show_image/show_image_local_logo.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: SizeConfig.screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShowImageLocalLogo(
              height: 200,
              width: 200,
            ),
            SizedBox(
              height: 20,
            ),
            child,
          ],
        ),
      ),
    );
  }
}
