import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/theme_config.dart';
import 'core/observer/bloc_observer_info.dart';
import 'injection_container.dart' as di;
import 'presentation/cubit/cubits.dart';
import 'presentation/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = BlocObserverInfo();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();
  
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
        BlocProvider(
            create: (context) => di.sl<CampaignDeployedContractCubit>()),
        BlocProvider(
            create: (context) => di.sl<CampaignFactoryDeployedContractCubit>()
              ..getDeployedContract()),
        BlocProvider(create: (context) => di.sl<GetCampaignCubit>()),
        BlocProvider(create: (context) => di.sl<Web3ClientCubit>()),
        BlocProvider(create: (context) => di.sl<GetAllAddressCampaignsCubit>()),
        BlocProvider(create: (context) => di.sl<WalletCubit>()),
        BlocProvider(create: (context) => di.sl<ConnectionCheckerCubit>()),
        BlocProvider(create: (context) => di.sl<SelectedOnboardingCubit>()),
        BlocProvider(create: (context) => di.sl<AuthBodyCubit>()),
      ],
      child: MaterialApp(
        home: SplashScreen(),
        theme: ThemeConfig.defaultTheme,
      ),
    );
  }
}
