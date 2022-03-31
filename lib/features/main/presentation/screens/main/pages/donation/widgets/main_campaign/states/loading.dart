import 'package:flutter/material.dart';

import '../../../../../../../../../../shared/config/size_config.dart';
import '../../../../../../../../../../shared/widgets/custom_shimmer.dart';
import '../../../../../../../../../../shared/widgets/widget_with_default_horizontal_padding.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        WidgetWithDefaultHorizontalPadding(
          child: CustomShimmer.circular(
            width: SizeConfig.screenWidth,
            height: 30,
            shapeBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [0, 1, 2]
                .asMap()
                .map(
                  (key, value) => MapEntry(
                    key,
                    Padding(
                      padding: EdgeInsets.only(
                        left: (key == 0) ? SizeConfig.defaultMargin : 15,
                        right: (key == 5) ? SizeConfig.defaultMargin : 0,
                      ),
                      child: CustomShimmer.circular(
                        width: SizeConfig.screenWidth -
                            SizeConfig.defaultMargin * 3,
                        height: 210,
                        shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                )
                .values
                .toList(),
          ),
        ),
      ],
    );
  }
}
