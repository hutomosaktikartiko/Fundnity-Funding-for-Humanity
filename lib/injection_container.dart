import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:new_version/new_version.dart';
import 'package:web3dart/web3dart.dart';

import 'core/config/keys_config.dart';
import 'core/config/urls_config.dart';
import 'core/error/interceptor_info.dart';
import 'core/network/network_info.dart';
import 'core/observer/firebase_analytics_observer_info.dart';
import 'core/update/update_info.dart';
import 'data/datasources/remotes/ethereum_remote_data_source.dart';
import 'data/repositories/ethereum_repository.dart';
import 'presentation/cubit/cubits.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubit
  sl.registerFactory(() => EthereumBalanceCubit(ethereumRepository: sl()));

  // Repositories
  sl.registerLazySingleton<EthereumRepository>(() => EthereumRepositoryImpl(ethereumRemoteDataSource: sl(), networkInfo: sl()));

  // Datasources
  sl.registerLazySingleton<EthereumRemoteDataSource>(() => EthereumRemoteDataSourceImpl(web3client: sl()));

  // Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(internetConnectionChecker: sl()));
  // TODO => Replace [androidId] with real app package name
  sl.registerLazySingleton<UpdateInfo>(() => UpdateInfoImpl(newVersion: sl()));
  sl.registerLazySingleton<FirebaseAnalyticsObserverInfo>(
      () => FirebaseAnalyticsObserverInfoImpl(analytics: sl()));

  // External
  sl.registerLazySingleton<NewVersion>(() => NewVersion());
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
  sl.registerLazySingleton<ImagePicker>(() => ImagePicker());
  sl.registerLazySingleton<FirebaseAnalytics>(() => FirebaseAnalytics.instance);
  sl.registerLazySingleton<Client>(() => Client());
  sl.registerLazySingleton<Web3Client>(() => Web3Client(UrlsConfig.infuraRopstenProvider + KeysConfig.infuraPrivateKey, sl()));
  
  // TODO => DIO Client
  sl.registerLazySingleton<Dio>(() => Dio(
        BaseOptions(
          connectTimeout: 5000,
          receiveTimeout: 3000,
        ),
      )..interceptors.add(InterceptorInfo()));
}
