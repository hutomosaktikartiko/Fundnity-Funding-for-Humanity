import '../../../../../../../../shared/config/size_config.dart';
import '../../../../../../../../shared/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';

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
                padding: EdgeInsets.only(bottom: (key == 2) ? 0 : 10),
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
