import 'dart:io';

import 'package:crowdfunding/core/utils/screen_navigator.dart';
import 'package:crowdfunding/presentation/screens/campaign_creation_summary/campaign_creation_summary_screen.dart';
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
          // TODO => Handle alert target data null
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
          // TODO => Handle alert title data null
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
          // TODO => Handle alert description data null,
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
