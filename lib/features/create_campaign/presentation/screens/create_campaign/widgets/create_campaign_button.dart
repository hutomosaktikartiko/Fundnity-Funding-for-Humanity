import 'dart:io';

import '../../../../../../shared/config/label_config.dart';
import '../../../../../../shared/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/screen_navigator.dart';
import '../../../../../../shared/config/custom_color.dart';
import '../../../../../../shared/widgets/button/custom_button_label.dart';
import '../../../cubit/create_campaign_progress/create_campaign_progress_cubit.dart';
import '../../../cubit/create_campaign_target_data/create_campaign_data_cubit.dart';
import '../../campaign_creation_summary/campaign_creation_summary_screen.dart';

class CreateCampaignButton extends StatelessWidget {
  const CreateCampaignButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCampaignDataCubit, CreateCampaignDataState>(
      builder: (context, createCampaignDataState) {
        return BlocBuilder<CreateCampaignProgressCubit,
            CreateCampaignProgressState>(
          builder: (context, createCampaignProgressState) {
            if (createCampaignProgressState.index == 0) {
              // Target Button
              return builTargetButton(
                context: context,
                amount: createCampaignDataState.amount,
                time: createCampaignDataState.time,
              );
            } else if (createCampaignProgressState.index == 1) {
              // Title Button
              return buildTitleButton(
                title: createCampaignDataState.title,
                image: createCampaignDataState.image,
                context: context,
              );
            } else {
              // Description Button
              return buildDescriptionButton(
                description: createCampaignDataState.description,
                context: context,
              );
            }
          },
        );
      },
    );
  }

  Widget builTargetButton({
    required int? time,
    required double? amount,
    required BuildContext context,
  }) {
    if (time != null && amount != null) {
      return CustomButtonLabel(
        label: 'Next',
        onTap: () => _setIndex(
          index: 1,
          context: context,
        ),
      );
    } else {
      return CustomButtonLabel(
        label: 'Next',
        backgroundColor: UniversalColor.gray4,
        borderColor: UniversalColor.gray4,
        onTap: () {
          if (amount == null) {
            CustomDialog.showToast(
            message: LabelConfig.targetCostEmpty,
            context: context,
            backgroundColor: UniversalColor.red,
          );
          } else {
            CustomDialog.showToast(
            message: LabelConfig.targetTimeEmpty,
            context: context,
            backgroundColor: UniversalColor.red,
          );
          }
        },
      );
    }
  }

  Widget buildTitleButton({
    required String? title,
    required File? image,
    required BuildContext context,
  }) {
    if (title != null && title != "" && image != null) {
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
    } else {
      return _buildDoubleButtons(
        onFirstButton: () => _setIndex(
          context: context,
          index: 0,
        ),
        onSecondButton: () {
          if (title == null) {
            CustomDialog.showToast(
              message: LabelConfig.titleEmpty,
              context: context,
              backgroundColor: UniversalColor.red,
            );
          } else {
            CustomDialog.showToast(
              message: LabelConfig.imageEmpty,
              context: context,
              backgroundColor: UniversalColor.red,
            );
          }
        },
        isDisableNextButon: true,
      );
    }
  }

  Widget buildDescriptionButton({
    required String? description,
    required BuildContext context,
  }) {
    if (description != null && description != "") {
      return _buildDoubleButtons(
        onFirstButton: () => _setIndex(
          context: context,
          index: 1,
        ),
        onSecondButton: () => ScreenNavigator.startScreen(
          context,
          CampaignCreationSummary(),
        ),
      );
    } else {
      return _buildDoubleButtons(
        onFirstButton: () => _setIndex(
          context: context,
          index: 1,
        ),
        onSecondButton: () {
          CustomDialog.showToast(
            message: LabelConfig.descriptionEmpty,
            context: context,
            backgroundColor: UniversalColor.red,
          );
        },
        isDisableNextButon: true,
      );
    }
  }

  void _setIndex({
    required int index,
    required BuildContext context,
  }) {
    context.read<CreateCampaignProgressCubit>().changeIndex(index: index);
  }

  Widget _buildDoubleButtons({
    required Function() onFirstButton,
    required Function() onSecondButton,
    bool isDisableNextButon = false,
  }) {
    return Row(
      children: [
        Flexible(
          child: CustomButtonLabel(
            label: 'Back',
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
            backgroundColor: (isDisableNextButon)
                ? UniversalColor.gray4
                : UniversalColor.green4,
            borderColor: (isDisableNextButon)
                ? UniversalColor.gray4
                : UniversalColor.green4,
            onTap: onSecondButton,
          ),
        ),
      ],
    );
  }
}
