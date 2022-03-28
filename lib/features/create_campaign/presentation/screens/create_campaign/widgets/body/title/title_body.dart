import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubit/create_campaign_target_data/create_campaign_data_cubit.dart';
import 'widgets/image_widget.dart';
import 'widgets/title_widget.dart';

class TitleBody extends StatelessWidget {
  const TitleBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCampaignDataCubit, CreateCampaignDataState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleWidget(
              title: state.title,
            ),
            const SizedBox(
              height: 15,
            ),
            ImageWidget(
              image: state.image,
            )
          ],
        );
      },
    );
  }
}
