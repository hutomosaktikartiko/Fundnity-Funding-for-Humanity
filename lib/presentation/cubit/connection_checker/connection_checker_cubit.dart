import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../core/config/label_config.dart';

part 'connection_checker_state.dart';

class ConnectionCheckerCubit extends Cubit<ConnectionCheckerState> {
  final InternetConnectionChecker? internetConnectionChecker;

  ConnectionCheckerCubit({required this.internetConnectionChecker})
      : super(InternetConnectionLoading()) {
    monitorInternetConnection();
  }

  // ignore: cancel_subscriptions
  StreamSubscription? internetConnectionStreamSubscription;

  void monitorInternetConnection() async {
    internetConnectionStreamSubscription =
        InternetConnectionChecker().onStatusChange.listen(
      (status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            emitInternetConnectionConnected(InternetConnectionStatus.connected);
            break;
          case InternetConnectionStatus.disconnected:
            emitInternetConnectionDisconnected();
            break;
        }
      },
    );
  }

  void emitInternetConnectionConnected(
    InternetConnectionStatus _internetConnectionStatus,
  ) {
    return emit(
      InternetConnectionConnected(
        internetConnectionStatus: _internetConnectionStatus,
      ),
    );
  }

  void emitInternetConnectionDisconnected() {
    return emit(
      InternetConnectionDisconnected(
        message: LabelConfig.noInternet,
      ),
    );
  }

  @override
  Future<void> close() async {
    internetConnectionStreamSubscription!.cancel();
    return super.close();
  }
}
