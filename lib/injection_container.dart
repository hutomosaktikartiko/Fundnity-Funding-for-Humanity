import 'dart:io';

import 'package:crowdfunding/core/error/interceptor_info.dart';
import 'package:crowdfunding/core/network/network_info.dart';
import 'package:crowdfunding/core/observer/firebase_analytics_observer_info.dart';
import 'package:crowdfunding/core/update/update_info.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:new_version/new_version.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubit

  // Repositories

  // Datasources

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
  // TODO => Http Register
  
  // TODO => DIO Client
  sl.registerLazySingleton<Dio>(() => Dio(
        BaseOptions(
          connectTimeout: 5000,
          receiveTimeout: 3000,
        ),
      )..interceptors.add(InterceptorInfo()));
}
