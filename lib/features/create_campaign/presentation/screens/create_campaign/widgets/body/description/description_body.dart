import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubit/create_campaign_target_data/create_campaign_data_cubit.dart';
import 'widgets/description_widget.dart';

class DescriptionBody extends StatelessWidget {
  const DescriptionBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCampaignDataCubit, CreateCampaignDataState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DescriptionWidget(description: state.description),
          ],
        );
      },
    );
  }
}
