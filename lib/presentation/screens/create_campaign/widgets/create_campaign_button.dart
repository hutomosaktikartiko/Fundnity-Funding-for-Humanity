import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/custom_color.dart';
import '../../../cubit/cubits.dart';
import '../../../widgets/button/custom_button_label.dart';

class CreateCampaignButton extends StatelessWidget {
  const CreateCampaignButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCampaignProgressCubit,
        CreateCampaignProgressState>(builder: (context, state) {
      if (state.index == 0) {
        // Title Body
        return CustomButtonLabel(
          label: 'Next',
          onTap: () => _setIndex(
            index: 1,
            context: context,
          ),
        );
      } else if (state.index == 1) {
        // Target Body
        return _buildDoubleButtons(
          onFirstButton: () => _setIndex(
            context: context,
            index: 0,
          ),
          onSecondButton: () => _setIndex(
            context: context,
            index: 2,
          ),
        );
      } else if (state.index == 2) {
        // Description Body
        return _buildDoubleButtons(
          onFirstButton: () => _setIndex(
            context: context,
            index: 1,
          ),
          onSecondButton: () => _setIndex(
            context: context,
            index: 3,
          ),
        );
      } else {
        // Confirmation Body
        return CustomButtonLabel(
          label: 'Create Campaign',
          onTap: () => _onCreateCampaign(
            context: context,
          ),
        );
      }
    });
  }

  void _setIndex({
    required int index,
    required BuildContext context,
  }) {
    context.read<CreateCampaignProgressCubit>().changeIndex(index: index);
  }

  void _onCreateCampaign({
    required BuildContext context,
  }) {
  }

  Widget _buildDoubleButtons({
    required Function() onFirstButton,
    required Function() onSecondButton,
  }) {
    return Row(
      children: [
        Flexible(
          child: CustomButtonLabel(
            label: 'Cancel',
            backgroundColor: UniversalColor.gray4,
            borderColor: UniversalColor.gray4,
            onTap: onFirstButton,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: CustomButtonLabel(
            label: 'Next',
            onTap: onSecondButton,
          ),
        ),
      ],
    );
  }
}
