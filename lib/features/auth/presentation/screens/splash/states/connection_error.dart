import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../shared/widgets/button/custom_button_label.dart';
import '../../../../../../shared/widgets/custom_dialog.dart';
import '../../../cubit/connection_checker/connection_checker_cubit.dart';
import '../widgets/body.dart';

class ConnectionError extends StatelessWidget {
  const ConnectionError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context: context);
  }

  Widget buildBody({required BuildContext context}) {
    Future.delayed(
      Duration.zero,
      () => CustomDialog.showToast(
        message: "Periksa internet anda",
        context: context,
      ),
    );

    return Body(
      child: CustomButtonLabel(
        label: "Muat ulang",
        width: 100,
        onTap: () => context.read<ConnectionCheckerCubit>(),
      ),
    );

    // DEV -> Comment this for go in with no internet
    // SchedulerBinding.instance?.addPostFrameCallback((_) async {
    //   ScreenNavigator.replaceScreen(context, MainScreen());
    // });

    // return Body(
    //   child: CustomDialog.showCircularProgressIndicator(),
    // );
  }
}
