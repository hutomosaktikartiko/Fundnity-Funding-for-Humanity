import 'package:flutter/material.dart';

import '../../../../../shared/config/size_config.dart';
import '../../../../../shared/widgets/connection_screen.dart';
import 'states/connection_error.dart';
import 'states/connection_success.dart';
import 'states/connection_loading.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return ConnectionScreen(
      internetConnectionConnected: () {
        return ConnectionSuccess();
      },
      internetConnectionDisconnected: () {
        return ConnectionError();
      },
      loading: () {
        return ConnectionLoading();
      },
    );
  }
}
