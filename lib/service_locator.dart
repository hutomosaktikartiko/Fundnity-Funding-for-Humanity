import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_version/new_version.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/web3dart.dart';

import 'core/observer/firebase_analytics_observer_info.dart';
import 'core/utils/network_info.dart';
import 'core/utils/preferences_info.dart';
import 'core/utils/update_info.dart';
import 'features/auth/data/datasources/auth_local_data_source.dart';
import 'features/auth/data/repositories/auth_repository.dart';
import 'features/auth/presentation/cubit/auth_body/auth_body_cubit.dart';
import 'features/auth/presentation/cubit/connection_checker/connection_checker_cubit.dart';
import 'features/auth/presentation/cubit/selected_onboarding/selected_onboarding_cubit.dart';
import 'features/auth/presentation/cubit/wallet/wallet_cubit.dart';
import 'features/create_campaign/presentation/cubit/create_campaign_progress/create_campaign_progress_cubit.dart';
import 'features/create_campaign/presentation/cubit/create_campaign_target_data/create_campaign_data_cubit.dart';
import 'features/create_campaign/presentation/cubit/selected_date/selected_date_cubit.dart';
import 'features/create_campaign/presentation/cubit/selected_image/selected_image_cubit.dart';
import 'features/donation/presentation/cubit/selected_transaction_speed/selected_transaction_speed_cubit.dart';
import 'features/main/data/datasources/campaign_remote_data_source.dart';
import 'features/main/data/datasources/deployed_contract_local_data_source.dart';
import 'features/main/data/repositories/campaign_repository.dart';
import 'features/main/data/repositories/deployed_contract_repository.dart';
import 'features/main/presentation/cubit/campaign_deployed_contract/campaign_deployed_contract_cubit.dart';
import 'features/main/presentation/cubit/crowdfunding_deployed_contract/crowdfunding_deployed_contract_cubit.dart';
import 'features/main/presentation/cubit/get_all_address_campaigns/get_all_address_campaigns_cubit.dart';
import 'features/main/presentation/cubit/get_campaign/get_campaign_cubit.dart';
import 'features/main/presentation/cubit/web3client/web3client_cubit.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Cubit
  await _cubit();

  // Repositories
  await _repository();

  // Datasources Remote
  await _remoteDataSource();

  // Datasources Local
  await _localDataSource();

  // Core
  await _core();

  // External
  await _external();
}

Future<void> _cubit() async {
  sl.registerFactory(
      () => CampaignDeployedContractCubit(deployedContractRepository: sl()));
  sl.registerFactory(() => GetCampaignCubit(campaignRepository: sl()));
  sl.registerFactory(() =>
      CrowdfundingDeployedContractCubit(deployedContractRepository: sl()));
  sl.registerFactory(() => Web3ClientCubit(client: sl()));
  sl.registerFactory(
      () => GetAllAddressCampaignsCubit(campaignRepository: sl()));
  sl.registerFactory(() => WalletCubit(authRepository: sl()));
  sl.registerFactory(() => ConnectionCheckerCubit(connectivity: sl()));
  sl.registerFactory(() => SelectedOnboardingCubit());
  sl.registerFactory(() => AuthBodyCubit());
  sl.registerFactory(() => SelectedTransactionSpeedCubit());
  sl.registerFactory(() => CreateCampaignProgressCubit());
  sl.registerFactory(() => SelectedDateCubit());
  sl.registerFactory(() => CreateCampaignDataCubit());
  sl.registerFactory(() => SelectedImageCubit());
}

Future<void> _repository() async {
  sl.registerLazySingleton<DeployedContractRepository>(() =>
      DeployedContractRepositoryImpl(
          deployedContractLocalDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<CampaignRepository>(() => CampaignRepositoryImpl(
      networkInfo: sl(), campaignRemoteDataSource: sl()));
  sl.registerLazySingleton<AuthRepository>(() =>
      AuthRepositoryImpl(networkInfo: sl(), authLocalDataSource: sl()));
}

Future<void> _remoteDataSource() async {
  sl.registerLazySingleton<CampaignRemoteDataSource>(
      () => CampaignRemoteDataSourceImpl(client: sl()));
}

Future<void> _localDataSource() async {
  sl.registerLazySingleton<DeployedContractLocalDataSource>(
      () => DeplotedContractLocalDataSourceImpl());
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(preferences: sl()));
}

Future<void> _core() async {
  // NetworkInfo
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectivity: sl()));
  // UpdateInfo
  sl.registerLazySingleton<UpdateInfo>(() => UpdateInfoImpl(newVersion: sl()));
  // FirebaseAnalyticsObserverInfo
  sl.registerLazySingleton<FirebaseAnalyticsObserverInfo>(
      () => FirebaseAnalyticsObserverInfoImpl(analytics: sl()));
  // PreferencesInfo
  sl.registerLazySingleton<PreferencesInfo>(
      () => PreferencesInfoImpl(shared: sl()));
}

Future<void> _external() async {
  // SharedPreferences
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  // NewVersion
  // TODO: Set androidId with app packages name in ps
  sl.registerLazySingleton<NewVersion>(() => NewVersion());
  // Connectivity
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  // ImagePicker
  sl.registerLazySingleton<ImagePicker>(() => ImagePicker());
  // FilePicker
  sl.registerLazySingleton<FilePicker>(() => FilePicker.platform);
  // FirebaseAnalytics
  sl.registerLazySingleton<FirebaseAnalytics>(() => FirebaseAnalytics.instance);
  // HTTPClient
  sl.registerLazySingleton<Client>(() => Client());
  // Web3Client
  sl.registerLazySingleton<Web3Client>(() => Web3Client(sl(), sl()));
  // ImageCropper
  sl.registerLazySingleton<ImageCropper>(() => ImageCropper());
  // Dio
  sl.registerLazySingleton<Dio>(() => Dio());
}
