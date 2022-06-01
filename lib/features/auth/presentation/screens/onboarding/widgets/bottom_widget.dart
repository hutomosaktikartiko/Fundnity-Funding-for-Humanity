import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/screen_navigator.dart';
import '../../../../../../shared/config/custom_text_style.dart';
import '../../../../../../shared/config/size_config.dart';
import '../../../../../../shared/widgets/button/custom_button_label.dart';
import '../../../../data/models/onboarding_model.dart';
import '../../../cubit/selected_onboarding/selected_onboarding_cubit.dart';
import '../../auth/auth_screen.dart';
import 'indicator_widget.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40,
      left: SizeConfig.defaultMargin,
      right: SizeConfig.defaultMargin,
      child: BlocBuilder<SelectedOnboardingCubit, SelectedOnboardingState>(
        builder: (context, state) {
          if ((context.read<SelectedOnboardingCubit>().state.index ==
              mockListOnboardings.length - 1)) {
            return CustomButtonLabel(
              label: "Masuk Sekarang",
              onTap: () => ScreenNavigator.replaceScreen(context, AuthScreen()),
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: mockListOnboardings
                      .asMap()
                      .map(
                        (key, value) => MapEntry(
                          key,
                          IndicatorWidget(
                            index: key,
                            isActive: state.index == key,
                          ),
                        ),
                      )
                      .values
                      .toList(),
                ),
                GestureDetector(
                  onTap: () => pageController.nextPage(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.ease,
                  ),
                  child: Text(
                    "Selanjutnya",
                    style: CustomTextStyle.green4TextStyle.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
