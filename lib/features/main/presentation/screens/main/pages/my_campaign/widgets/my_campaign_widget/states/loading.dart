import 'package:flutter/material.dart';

import '../../../../../../../../../../shared/config/size_config.dart';
import '../../../../../../../../../../shared/widgets/custom_shimmer.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomShimmer.circular(
      width: SizeConfig.screenWidth,
      height: 100,
      shapeBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
