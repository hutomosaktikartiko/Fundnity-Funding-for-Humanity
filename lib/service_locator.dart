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
import 'data/datasources/locals/deployed_contract_local_data_source.dart';
import 'data/datasources/locals/wallet_local_data_source.dart';
import 'data/datasources/remotes/campaign_remote_data_source.dart';
import 'data/datasources/remotes/ethereum_remote_data_source.dart';
import 'data/repositories/campaign_repository.dart';
import 'data/repositories/deployed_contract_repository.dart';
import 'data/repositories/ethereum_repository.dart';
import 'data/repositories/wallet_repository.dart';
import 'presentation/cubit/cubits.dart';

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
  sl.registerFactory(() => EthereumBalanceCubit(ethereumRepository: sl()));
  sl.registerFactory(() => CampaignDeployedContractCubit(deployedContractRepository: sl()));
  sl.registerFactory(() => GetCampaignCubit(campaignRepository: sl()));
  sl.registerFactory(() => CrowdfundingDeployedContractCubit(deployedContractRepository: sl()));
  sl.registerFactory(() => Web3ClientCubit(client: sl()));
  sl.registerFactory(() => GetAllAddressCampaignsCubit(campaignRepository: sl()));
  sl.registerFactory(() => WalletCubit(walletRepository: sl()));
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
  sl.registerLazySingleton<EthereumRepository>(() => EthereumRepositoryImpl(ethereumRemoteDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<DeployedContractRepository>(() => DeployedContractRepositoryImpl(deployedContractLocalDataSource: sl(), networkInfo: sl()));
  sl.registerLazySingleton<CampaignRepository>(() => CampaignRepositoryImpl(networkInfo: sl(), campaignRemoteDataSource: sl()));
  sl.registerLazySingleton<WalletRepository>(() => WalletRepositoryImpl(networkInfo: sl(), walletLocalDataSource: sl()));
}

Future<void> _remoteDataSource() async {
  sl.registerLazySingleton<EthereumRemoteDataSource>(() => EthereumRemoteDataSourceImpl(web3client: sl()));
  sl.registerLazySingleton<CampaignRemoteDataSource>(() => CampaignRemoteDataSourceImpl(client: sl()));
}

Future<void> _localDataSource() async {
  sl.registerLazySingleton<DeployedContractLocalDataSource>(() => DeplotedContractLocalDataSourceImpl());
  sl.registerLazySingleton<WalletLocalDataSource>(() => WalletLocalDataSourceImpl(preferences: sl()));
}

Future<void> _core() async {
  // NetworkInfo
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(connectivity: sl()));
  // UpdateInfo
  sl.registerLazySingleton<UpdateInfo>(() => UpdateInfoImpl(newVersion: sl()));
  // FirebaseAnalyticsObserverInfo
  sl.registerLazySingleton<FirebaseAnalyticsObserverInfo>(() => FirebaseAnalyticsObserverInfoImpl(analytics: sl()));
  // PreferencesInfo
  sl.registerLazySingleton<PreferencesInfo>(() => PreferencesInfoImpl(shared: sl()));
}

Future<void> _external() async {
  // SharedPreferences
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
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