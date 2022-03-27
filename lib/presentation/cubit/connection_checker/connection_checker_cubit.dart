import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

import '../../../shared/config/label_config.dart';

part 'connection_checker_state.dart';

class ConnectionCheckerCubit extends Cubit<ConnectionCheckerState> {
  final Connectivity connectivity;

  ConnectionCheckerCubit({required this.connectivity})
      : super(InternetConnectionLoading()) {
    monitorInternetConnection();
  }

  // ignore: cancel_subscriptions
  StreamSubscription? internetConnectionStreamSubscription;

  void monitorInternetConnection() async {
    if (await connectivity.checkConnectivity() == ConnectivityResult.none) {
      emitInternetConnectionDisconnected();
      internetConnectionStreamSubscription = connectivity.onConnectivityChanged
          .listen((ConnectivityResult result) {
        if (result == ConnectivityResult.none) {
          emitInternetConnectionDisconnected();
        } else {
          // Close strem subscribtion
          close();
          emitInternetConnectionConnected();
        }
      });
    } else {
      emitInternetConnectionConnected();
    }
  }

  void emitInternetConnectionConnected() {
    return emit(InternetConnectionConnected());
  }

  void emitInternetConnectionDisconnected() {
    return emit(InternetConnectionDisconnected(
      message: LabelConfig.noInternet,
    ));
  }

  @override
  Future<void> close() async {
    internetConnectionStreamSubscription?.cancel();
    return super.close();
  }
}
