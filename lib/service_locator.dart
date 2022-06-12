import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:new_version/new_version.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/web3dart.dart';

import 'core/error/interceptor_info.dart';
import 'core/utils/directory_info.dart';
import 'core/utils/network_info.dart';
import 'core/utils/permission_info.dart';
import 'core/utils/preferences_info.dart';
import 'core/utils/secure_storage_info.dart';
import 'core/utils/update_info.dart';
import 'features/auth/data/datasources/auth_local_data_source.dart';
import 'features/auth/data/repositories/auth_repository.dart';
import 'features/auth/presentation/cubit/auth_body/auth_body_cubit.dart';
import 'features/auth/presentation/cubit/biometric_auth/biometric_auth_cubit.dart';
import 'features/auth/presentation/cubit/connection_checker/connection_checker_cubit.dart';
import 'features/auth/presentation/cubit/obsecure_password/obsecure_password_cubit.dart';
import 'features/auth/presentation/cubit/save_wallet/save_wallet_cubit.dart';
import 'features/auth/presentation/cubit/selected_onboarding/selected_onboarding_cubit.dart';
import 'features/auth/presentation/cubit/wallet/wallet_cubit.dart';
import 'features/create_campaign/data/datasources/create_campaign_remote_data_source.dart';
import 'features/create_campaign/data/repositories/create_campaign_repository.dart';
import 'features/create_campaign/presentation/cubit/create_campaign/create_campaign_cubit.dart';
import 'features/create_campaign/presentation/cubit/create_campaign_progress/create_campaign_progress_cubit.dart';
import 'features/create_campaign/presentation/cubit/create_campaign_target_data/create_campaign_data_cubit.dart';
import 'features/create_campaign/presentation/cubit/selected_date/selected_date_cubit.dart';
import 'features/create_campaign/presentation/cubit/selected_image/selected_image_cubit.dart';
import 'features/donation/data/datasources/contribute_remote_data_source.dart';
import 'features/donation/data/datasources/gas_remote_data_source.dart';
import 'features/donation/data/repositories/contribute_repository.dart';
import 'features/donation/data/repositories/gas_repository.dart';
import 'features/donation/presentation/cubit/contribute/contribute_cubit.dart';
import 'features/donation/presentation/cubit/contributor/contributor_cubit.dart';
import 'features/donation/presentation/cubit/gas_tracker/gas_tracker_cubit.dart';
import 'features/donation/presentation/cubit/selected_transaction_speed/selected_transaction_speed_cubit.dart';
import 'features/main/data/datasources/account_remote_data_balance.dart';
import 'features/main/data/datasources/campaign_remote_data_source.dart';
import 'features/main/data/datasources/deployed_contract_local_data_source.dart';
import 'features/main/data/datasources/history_remote_data_srouce.dart';
import 'features/main/data/datasources/transaction_remote_data_source.dart';
import 'features/main/data/repositories/account_repository.dart';
import 'features/main/data/repositories/campaign_repository.dart';
import 'features/main/data/repositories/deployed_contract_repository.dart';
import 'features/main/data/repositories/history_repository.dart';
import 'features/main/data/repositories/transaction_repository.dart';
import 'features/main/presentation/cubit/account_balance/account_balance_cubit.dart';
import 'features/main/presentation/cubit/campaign_by_wallet_addresses/campaign_by_wallet_addresses_cubit.dart';
import 'features/main/presentation/cubit/campaign_deployed_contract/campaign_deployed_contract_cubit.dart';
import 'features/main/presentation/cubit/campaigns/campaigns_cubit.dart';
import 'features/main/presentation/cubit/crowdfunding_deployed_contract/crowdfunding_deployed_contract_cubit.dart';
import 'features/main/presentation/cubit/filtered_campaigns/filtered_campaigns_cubit.dart';
import 'features/main/presentation/cubit/history/history_cubit.dart';
import 'features/main/presentation/cubit/latest_campaigns/latest_campaigns_cubit.dart';
import 'features/main/presentation/cubit/main_campaign/main_campaign_cubit.dart';
import 'features/main/presentation/cubit/my_campaigns/my_campaigns_cubit.dart';
import 'features/main/presentation/cubit/selected_filter_campaign/selected_filter_campaign_cubit.dart';
import 'features/main/presentation/cubit/web3client/web3client_cubit.dart';
import 'features/search_donation/presentation/cubit/recommended_campaign/recommended_campaign_cubit.dart';
import 'shared/config/urls_config.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Auth
  await _auth();

  // Create Campaign
  await _createCampaign();

  // Donation
  await _donation();

  // Favorite Donation
  await _favoriteDonation();

  // Main
  await _main();

  // Notification
  await _notification();

  // Search Donation
  await _searchDonation();

  // Settings
  await _settings();

  // Core
  await _core();

  // External
  await _external();
}

Future<void> _auth() async {
  // Datasources
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(preferences: sl(), secureStorage: sl()));
  sl.registerLazySingleton<DeployedContractLocalDataSource>(
      () => DeplotedContractLocalDataSourceImpl());

  // Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(networkInfo: sl(), authLocalDataSource: sl()));
  sl.registerLazySingleton<DeployedContractRepository>(() =>
      DeployedContractRepositoryImpl(
          deployedContractLocalDataSource: sl(), networkInfo: sl()));

  // Cubit
  sl.registerFactory(() =>
      CrowdfundingDeployedContractCubit(deployedContractRepository: sl()));
  sl.registerFactory(() => WalletCubit(authRepository: sl()));
  sl.registerFactory(() => AuthBodyCubit());
  sl.registerFactory(() => SelectedOnboardingCubit());
  sl.registerFactory(() => ConnectionCheckerCubit(connectivity: sl()));
  sl.registerFactory(
      () => SaveWalletCubit(directoryInfo: sl(), permissionInfo: sl()));
}

Future<void> _createCampaign() async {
  // Datasources
  sl.registerLazySingleton<CreateCampaignRemoteDataSource>(() =>
      CreateCampaignRemoteDataSourceImpl(
          client: sl(), dio: sl(), firestore: sl()));

  // Repository
  sl.registerLazySingleton<CreateCampaignRepository>(() =>
      CreateCampaignRepositoryImpl(
          networkInfo: sl(), createCampaignRemoteDataSource: sl()));

  // Cubit
  sl.registerFactory(() => CreateCampaignProgressCubit());
  sl.registerFactory(() => SelectedDateCubit());
  sl.registerFactory(() => CreateCampaignDataCubit());
  sl.registerFactory(() => SelectedImageCubit());
  sl.registerFactory(() => CreateCampaignCubit(createCampaignRepository: sl()));
}

Future<void> _donation() async {
  // Datasource
  sl.registerLazySingleton<ContributeRemoteDataSource>(
      () => ContributeRemoteDataSourceImpl(firestore: sl()));
  sl.registerLazySingleton<GasRemoteDataSource>(
      () => GasRemoteDataSourceImpl(dio: sl()));

  // Repository
  sl.registerLazySingleton<ContributeRepository>(() => ContributeRepositoryImpl(
      contributeRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<GasRepository>(
      () => GasRepositoryImpl(gasRemoteDataSource: sl(), networkInfo: sl()));

  // Cubit
  sl.registerFactory(() => SelectedTransactionSpeedCubit());
  sl.registerFactory(() => ContributorCubit(
      contributeRepository: sl(), campaignDeployedContractCubit: sl()));
  sl.registerFactory(() => GasTrackerCubit(gasRepository: sl()));
  sl.registerFactory(() => ContributeCubit(
      contributeRepository: sl(), campaignDeployedContractCubit: sl()));
}

Future<void> _favoriteDonation() async {}

Future<void> _main() async {
  // Datasources
  sl.registerLazySingleton<CampaignRemoteDataSource>(
      () => CampaignRemoteDataSourceImpl(firestore: sl()));
  sl.registerLazySingleton<AccountRemoteDataSource>(
      () => AccountRemoteDataSourceImpl());
  sl.registerLazySingleton<HistoryRemoteDataSource>(
      () => HistoryRemoteDataSourceImpl(firestore: sl()));
  sl.registerLazySingleton<TransactionRemoteDataSource>(
      () => TransactionRemoteDataSourceImpl(dio: sl()));

  // Repositories
  sl.registerLazySingleton<CampaignRepository>(() => CampaignRepositoryImpl(
      networkInfo: sl(), campaignRemoteDataSource: sl()));
  sl.registerLazySingleton<AccountRepository>(() =>
      AccountRepositoryImpl(networkInfo: sl(), accountRemoteDataSource: sl()));
  sl.registerLazySingleton<HistoryRepository>(() =>
      HistoryRepositoryImpl(historyRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<TransactionRepository>(() =>
      TransactionRepositoryImpl(
          transactionRemoteDataSource: sl(), networkInfo: sl()));

  // Cubit
  sl.registerFactory(
      () => CampaignDeployedContractCubit(deployedContractRepository: sl()));
  sl.registerFactory(() => Web3ClientCubit(client: sl()));
  sl.registerFactory(() => CampaignsCubit(
      campaignRepository: sl(), campaignDeployedContractCubit: sl()));
  sl.registerFactory(() => LatestCampaignsCubit());
  sl.registerFactory(() => CampaignByWalletAddressesCubit());
  sl.registerFactory(() => AccountBalanceCubit(accountRepository: sl()));
  sl.registerFactory(() => MyCampaignsCubit(
        campaignRepository: sl(),
        transactionRepository: sl(),
        campaignDeployedContractCubit: sl(),
      ));
  sl.registerFactory(() => MainCampaignCubit());
  sl.registerFactory(() => SelectedFilterCampaignCubit());
  sl.registerFactory(() => HistoryCubit(historyRepository: sl()));
  sl.registerFactory(() => BiometricAuthCubit(localAuth: sl()));
  sl.registerFactory(() => FilteredCampaignsCubit());
  sl.registerFactory(() => ObsecurePasswordCubit());
}

Future<void> _notification() async {
  // Datasources
  // Repository
  // Cubit
}

Future<void> _searchDonation() async {
  // Datasources
  // Repository
  // Cubit
  sl.registerFactory(() => RecommendedCampaignCubit());
}

Future<void> _settings() async {
  // Datasources
  // Repository
  // Cubit
}

Future<void> _core() async {
  // NetworkInfo
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectivity: sl()));
  // UpdateInfo
  sl.registerLazySingleton<UpdateInfo>(() => UpdateInfoImpl(newVersion: sl()));
  // FirebaseAnalyticsObserverInfo
  // sl.registerLazySingleton<FirebaseAnalyticsObserverInfo>(
  //     () => FirebaseAnalyticsObserverInfoImpl(analytics: sl()));
  // PreferencesInfo
  sl.registerLazySingleton<PreferencesInfo>(
      () => PreferencesInfoImpl(shared: sl()));
  sl.registerLazySingleton<SecureStorageInfo>(
      () => SecureStorageInfoImpl(flutterSecureStorage: sl()));
  sl.registerLazySingleton<DirectoryInfo>(() => DirectoryInfoImpl());
  sl.registerLazySingleton<PermissionInfo>(() => PermissionInfoImpl());
}

Future<void> _external() async {
  // SharedPreferences
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  // NewVersion
  sl.registerLazySingleton<NewVersion>(() => NewVersion(
        androidId: UrlsConfig.playstoreAndroidId,
      ));
  // Connectivity
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  // ImagePicker
  sl.registerLazySingleton<ImagePicker>(() => ImagePicker());
  // FilePicker
  sl.registerLazySingleton<FilePicker>(() => FilePicker.platform);
  // FirebaseAnalytics
  // sl.registerLazySingleton<FirebaseAnalytics>(() => FirebaseAnalytics.instance);
  // Cloud Firestore
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);
  // HTTPClient
  sl.registerLazySingleton<Client>(() => Client());
  // Web3Client
  sl.registerLazySingleton<Web3Client>(() => Web3Client(sl(), sl()));
  // ImageCropper
  sl.registerLazySingleton<ImageCropper>(() => ImageCropper());
  // Dio
  sl.registerLazySingleton<Dio>(
      () => Dio()..interceptors.add(InterceptorInfo()));
  // Local auth
  sl.registerLazySingleton<LocalAuthentication>(() => LocalAuthentication());
  // Secure Storage
  sl.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());
}
