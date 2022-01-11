import 'package:flutter/material.dart';

import 'core/config/theme_config.dart';
import 'presentation/screens/splash/splash_screen.dart';
import 'injection_container.dart' as di;

void main() async {

  await di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      theme: ThemeConfig.defaultTheme,
    );
  }
}
