import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_body_state.dart';

class AuthBodyCubit extends Cubit<AuthBodyState> {
  AuthBodyCubit() : super(AuthBodyImportWallet());

  void initialState() => emit(AuthBodyImportWallet());
}
