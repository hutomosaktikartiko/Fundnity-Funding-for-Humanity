import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:ndialog/ndialog.dart';
import 'package:new_version/new_version.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/web3dart.dart';

import 'core/config/keys_config.dart';
import 'core/config/urls_config.dart';
import 'core/error/interceptor_info.dart';
import 'core/network/network_info.dart';
import 'core/observer/firebase_analytics_observer_info.dart';
import 'core/preferences/preferences_info.dart';
import 'core/update/update_info.dart';
import 'data/datasources/locals/deployed_contract_local_data_source.dart';
import 'data/datasources/locals/wallet_local_data_source.dart';
import 'data/datasources/remotes/campaign_remote_data_source.dart';
import 'data/datasources/remotes/ethereum_remote_data_source.dart';
import 'data/repositories/campaign_repository.dart';
import 'data/repositories/deployed_contract_repository.dart';
import 'data/repositories/ethereum_repository.dart';
import 'data/repositories/wallet_repository.dart';
import 'presentation/cubit/cubits.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubit
  sl.registerFactory(() => EthereumBalanceCubit(ethereumRepository: sl()));
  sl.registerFactory(
      () => CampaignDeployedContractCubit(deployedContractRepository: sl()));
  sl.registerFactory(() => GetCampaignCubit(campaignRepository: sl()));
  sl.registerFactory(() =>
      CampaignFactoryDeployedContractCubit(deployedContractRepository: sl()));
  sl.registerFactory(() => Web3ClientCubit(client: sl()));
  sl.registerFactory(
      () => GetAllAddressCampaignsCubit(campaignRepository: sl()));
  sl.registerFactory(() => WalletCubit(walletRepository: sl()));
  sl.registerFactory(
      () => ConnectionCheckerCubit(internetConnectionChecker: sl()));
  sl.registerFactory(() => SelectedOnboardingCubit());
  sl.registerFactory(() => AuthBodyCubit());
  sl.registerFactory(() => SelectedTransactionSpeedCubit());

  // Repositories
  sl.registerLazySingleton<EthereumRepository>(() => EthereumRepositoryImpl(
      ethereumRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<DeployedContractRepository>(() =>
      DeployedContractRepositoryImpl(
          deployedContractLocalDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<CampaignRepository>(() => CampaignRepositoryImpl(
      networkInfo: sl(), campaignRemoteDataSource: sl()));
  sl.registerLazySingleton<WalletRepository>(() =>
      WalletRepositoryImpl(networkInfo: sl(), walletLocalDataSource: sl()));

  // Datasources Remote
  sl.registerLazySingleton<EthereumRemoteDataSource>(
      () => EthereumRemoteDataSourceImpl(web3client: sl()));
  sl.registerLazySingleton<CampaignRemoteDataSource>(
      () => CampaignRemoteDataSourceImpl());

  // Datasources Local
  sl.registerLazySingleton<DeployedContractLocalDataSource>(
      () => DeplotedContractLocalDataSourceImpl());
  sl.registerLazySingleton<WalletLocalDataSource>(
      () => WalletLocalDataSourceImpl(preferences: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));
  sl.registerLazySingleton<UpdateInfo>(() => UpdateInfoImpl(newVersion: sl()));
  sl.registerLazySingleton<FirebaseAnalyticsObserverInfo>(
      () => FirebaseAnalyticsObserverInfoImpl(analytics: sl()));
  sl.registerLazySingleton<PreferencesInfo>(
      () => PreferencesInfoImpl(shared: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  // TODO => Replace [androidId] with real app package name
  sl.registerLazySingleton<NewVersion>(() => NewVersion());
  sl.registerLazySingleton<NDialog>(() => NDialog());
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
  sl.registerLazySingleton<ImagePicker>(() => ImagePicker());
  sl.registerLazySingleton<FilePicker>(() => FilePicker.platform);
  sl.registerLazySingleton<FirebaseAnalytics>(() => FirebaseAnalytics.instance);
  sl.registerLazySingleton<Client>(() => Client());
  sl.registerLazySingleton<Web3Client>(
    () => Web3Client(
      UrlsConfig.infuraRinkbeyProvider + KeysConfig.infuraPrivateKey,
      sl(),
    ),
  );

  // TODO => DIO Client
  sl.registerLazySingleton<Dio>(() => Dio(
        BaseOptions(
          connectTimeout: 5000,
          receiveTimeout: 3000,
        ),
      )..interceptors.add(InterceptorInfo()));
}
