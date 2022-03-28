import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/models/onboarding_model.dart';
import '../../../cubit/selected_onboarding/selected_onboarding_cubit.dart';
import 'page_view_item.dart';

class PageViewWidget extends StatelessWidget {
  const PageViewWidget({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: ClampingScrollPhysics(),
      controller: pageController,
      onPageChanged: (int index) => context
          .read<SelectedOnboardingCubit>()
          .changeOnboarding(index: index),
      children: mockListOnboarding
          .map(
            (onboarding) => PageViewItem(onboarding: onboarding),
          )
          .toList(),
    );
  }
}
