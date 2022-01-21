import 'package:flutter/material.dart';

import '../../../core/config/size_config.dart';
import '../../widgets/connection_screen.dart';
import 'states/error.dart';
import 'states/loaded.dart';
import 'states/loading.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return ConnectionScreen(
      internetConnectionConnected: () {
        return Loaded();
      },
      internetConnectionDisconnected: () {
        return Error();
      },
      loading: () {
        return Loading();
      },
    );
  }
}
