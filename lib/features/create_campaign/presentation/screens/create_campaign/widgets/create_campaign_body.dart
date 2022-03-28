import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/create_campaign_progress/create_campaign_progress_cubit.dart';
import 'body/description/description_body.dart';
import 'body/target/target_body.dart';
import 'body/title/title_body.dart';

class CreateCampaignBody extends StatelessWidget {
  const CreateCampaignBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCampaignProgressCubit,
        CreateCampaignProgressState>(
      builder: (context, state) {
        if (state.index == 0) {
          // Target Body
          return TargetBody();
        } else if (state.index == 1) {
          // Title Body
          return TitleBody();
        } else {
          // Description Body
          return DescriptionBody();
        }
      },
    );
  }
}
