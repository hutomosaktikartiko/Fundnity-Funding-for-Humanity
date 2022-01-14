import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/theme_config.dart';
import 'injection_container.dart' as di;
import 'presentation/cubit/cubits.dart';
import 'presentation/screens/splash/splash_screen.dart';

void main() async {
  await di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<EthereumBalanceCubit>()),
        BlocProvider(create: (context) => di.sl<CampaignDeployedContractCubit>()..getDeployedContract()),
        BlocProvider(create: (context) => di.sl<CampaignFactoryDeployedContractCubit>()..getDeployedContract()),
        BlocProvider(create: (context) => di.sl<GetAllCampaignsCubit>()),
      ],
      child: MaterialApp(
        home: SplashScreen(),
        theme: ThemeConfig.defaultTheme,
      ),
    );
  }
}
