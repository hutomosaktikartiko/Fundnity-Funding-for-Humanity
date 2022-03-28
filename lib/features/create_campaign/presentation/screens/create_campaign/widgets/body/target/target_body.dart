import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../cubit/create_campaign_target_data/create_campaign_data_cubit.dart';
import 'widgets/cost_widget.dart';
import 'widgets/days_widget.dart';

class TargetBody extends StatelessWidget {
  const TargetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCampaignDataCubit, CreateCampaignDataState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CostWidget(
              amount: state.amount,
            ),
            const SizedBox(
              height: 15,
            ),
            DaysWidget(),
          ],
        );
      },
    );
  }
}
