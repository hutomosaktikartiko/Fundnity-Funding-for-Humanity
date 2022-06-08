import 'package:flutter/material.dart';

import '../../../../../../../../../../shared/widgets/campaign_card/my_campaign_card.dart';
import '../../../../../../../../../../shared/widgets/disable_layer.dart';
import '../../../../../../../../../../shared/widgets/widget_sized.dart';

class Error extends StatefulWidget {
  const Error({Key? key}) : super(key: key);

  @override
  State<Error> createState() => _ErrorState();
}

class _ErrorState extends State<Error> {
  Size? size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WidgetSize(
          child: MyCampaignCard(
            campaign: null,
          ),
          onChange: (newSize) {
            setState(() {
              size = newSize;
            });
          },
        ),
        DisabledLayer(
          height: size?.height,
          borderRadius: 5,
          message: "Failed to load campaign, tap to retry",
        ),
      ],
    );
  }
}
