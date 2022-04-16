import 'package:flutter/material.dart';

import '../../../../../../../../shared/config/size_config.dart';
import '../../../../../../../../shared/widgets/custom_shimmer.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [1, 2, 3]
          .asMap()
          .map(
            (key, value) => MapEntry(
              key,
              Padding(
                padding: EdgeInsets.only(bottom: (value == 3) ? 0 : 10),
                child: CustomShimmer.circular(
                  width: SizeConfig.screenWidth,
                  height: 50,
                  shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          )
          .values
          .toList(),
    );
  }
}
