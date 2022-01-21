import 'package:crowdfunding/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/theme_config.dart';
import 'injection_container.dart' as di;
import 'presentation/cubit/cubits.dart';
import 'presentation/screens/main/home/home_page.dart';

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
        BlocProvider(create: (context) => di.sl<CampaignDeployedContractCubit>()),
        BlocProvider(create: (context) => di.sl<CampaignFactoryDeployedContractCubit>()..getDeployedContract()),
        BlocProvider(create: (context) => di.sl<GetCampaignCubit>()),
        BlocProvider(create: (context) => di.sl<Web3clientCubit>()),
        BlocProvider(create: (context) => di.sl<GetAllAddressCampaignsCubit>()),
        BlocProvider(create: (context) => di.sl<WalletCubit>())
      ],
      child: MaterialApp(
        home: SplashScreen(),
        theme: ThemeConfig.defaultTheme,
      ),
    );
  }
}
