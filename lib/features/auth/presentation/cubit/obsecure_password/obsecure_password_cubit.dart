import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'obsecure_password_state.dart';

class ObsecurePasswordCubit extends Cubit<ObsecurePasswordState> {
  ObsecurePasswordCubit() : super(ObsecurePasswordState());

  void changeObsecureState() {
    emit(ObsecurePasswordState(isObsecure: !this.state.isObsecure));
  }
}
