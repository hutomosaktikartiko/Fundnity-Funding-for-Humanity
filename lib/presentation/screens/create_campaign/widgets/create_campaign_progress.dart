import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/size_config.dart';
import '../../../../data/models/create_campaign_progress_model.dart';
import '../../../cubit/cubits.dart';
import 'create_campaign_progress_item.dart';

class CreateCampaignProress extends StatelessWidget {
  const CreateCampaignProress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCampaignProgressCubit, CreateCampaignProgressState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: mockListCreateCampaignProgresses
              .asMap()
              .map(
                (key, value) => MapEntry(
                  key,
                  CreateCampaignProgressItem(
                    progress: value,
                    isActive: key <= state.index,
                    isFirst: key == 0,
                    isLast: key == mockListCreateCampaignProgresses.length - 1,
                    width: ((SizeConfig.screenWidth -
                            (2 * SizeConfig.defaultMargin)) /
                        mockListCreateCampaignProgresses.length),
                  ),
                ),
              )
              .values
              .toList(),
        );
      },
    );
  }
}
