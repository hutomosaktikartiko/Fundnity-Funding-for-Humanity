import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/observer/bloc_observer_info.dart';
import 'features/auth/presentation/cubit/auth_body/auth_body_cubit.dart';
import 'features/auth/presentation/cubit/connection_checker/connection_checker_cubit.dart';
import 'features/auth/presentation/cubit/selected_onboarding/selected_onboarding_cubit.dart';
import 'features/auth/presentation/cubit/wallet/wallet_cubit.dart';
import 'features/auth/presentation/screens/splash/splash_screen.dart';
import 'features/create_campaign/presentation/cubit/create_campaign/create_campaign_cubit.dart';
import 'features/create_campaign/presentation/cubit/create_campaign_progress/create_campaign_progress_cubit.dart';
import 'features/create_campaign/presentation/cubit/create_campaign_target_data/create_campaign_data_cubit.dart';
import 'features/create_campaign/presentation/cubit/selected_date/selected_date_cubit.dart';
import 'features/create_campaign/presentation/cubit/selected_image/selected_image_cubit.dart';
import 'features/donation/presentation/cubit/selected_transaction_speed/selected_transaction_speed_cubit.dart';
import 'features/main/presentation/cubit/account_balance/account_balance_cubit.dart';
import 'features/main/presentation/cubit/all_campaigns/all_campaigns_cubit.dart';
import 'features/main/presentation/cubit/campaign_by_wallet_addresses/campaign_by_wallet_addresses_cubit.dart';
import 'features/main/presentation/cubit/campaign_deployed_contract/campaign_deployed_contract_cubit.dart';
import 'features/main/presentation/cubit/campaigns/campaigns_cubit.dart';
import 'features/main/presentation/cubit/crowdfunding_deployed_contract/crowdfunding_deployed_contract_cubit.dart';
import 'features/main/presentation/cubit/main_campaign/main_campaign_cubit.dart';
import 'features/main/presentation/cubit/my_campaigns/my_campaigns_cubit.dart';
import 'features/main/presentation/cubit/web3client/web3client_cubit.dart';
import 'service_locator.dart' as di;
import 'shared/config/theme_config.dart';

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
        BlocProvider(
            create: (context) => di.sl<CampaignDeployedContractCubit>()),
        BlocProvider(
            create: (context) => di.sl<CrowdfundingDeployedContractCubit>()),
        BlocProvider(create: (context) => di.sl<Web3ClientCubit>()),
        BlocProvider(create: (context) => di.sl<WalletCubit>()),
        BlocProvider(create: (context) => di.sl<ConnectionCheckerCubit>()),
        BlocProvider(create: (context) => di.sl<SelectedOnboardingCubit>()),
        BlocProvider(create: (context) => di.sl<AuthBodyCubit>()),
        BlocProvider(
            create: (context) => di.sl<SelectedTransactionSpeedCubit>()),
        BlocProvider(create: (context) => di.sl<CreateCampaignProgressCubit>()),
        BlocProvider(create: (context) => di.sl<SelectedDateCubit>()),
        BlocProvider(create: (context) => di.sl<CreateCampaignDataCubit>()),
        BlocProvider(create: (context) => di.sl<SelectedImageCubit>()),
        BlocProvider(create: (context) => di.sl<CreateCampaignCubit>()),
        BlocProvider(create: (context) => di.sl<CampaignsCubit>()),
        BlocProvider(create: (context) => di.sl<AllCampaignsCubit>()),
        BlocProvider(create: (context) => di.sl<CampaignByWalletAddressesCubit>()),
        BlocProvider(create: (context) => di.sl<AccountBalanceCubit>()),
        BlocProvider(create: (context) => di.sl<MyCampaignsCubit>()),
        BlocProvider(create: (context) => di.sl<MainCampaignCubit>()),
      ],
      child: MaterialApp(
        home: SplashScreen(),
        themeMode: ThemeMode.light,
        theme: ThemeConfig.lightTheme,
        // TODO: Add dark theme
      ),
    );
  }
}
