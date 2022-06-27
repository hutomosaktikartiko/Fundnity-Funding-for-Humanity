import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../../../../../shared/config/keys_config.dart';
import '../../../../../shared/config/label_config.dart';

part 'one_signal_state.dart';

class OneSignalCubit extends Cubit<OneSignalState> {
  OneSignalCubit({
    required this.oneSignal,
  }) : super(OneSignalInitial());

  final OneSignal oneSignal;

  void init() async {
    emit(OneSignalLoading());

    await oneSignal.setAppId(KeysConfig.oneSignalAppId);
    final OSDeviceState? osDeviceState = await oneSignal.getDeviceState();

    if (osDeviceState != null) {
      emit(OneSignalLoaded(osDeviceState: osDeviceState));
    } else {
      emit(OneSignalFailure(message: LabelConfig.connectOneSignalFailed));
    }
  }

  String? getOneSignalId() {
    if (state is OneSignalLoaded) {
      return (state as OneSignalLoaded).osDeviceState.userId;
    } else {
      return null;
    }
  }
}
