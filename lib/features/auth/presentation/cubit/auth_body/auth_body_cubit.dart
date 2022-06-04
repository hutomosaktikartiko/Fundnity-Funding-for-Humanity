import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_body_state.dart';

class AuthBodyCubit extends Cubit<AuthBodyState> {
  AuthBodyCubit() : super(AuthBodyCreateWallet());

  void initialState() => emit(AuthBodyCreateWallet());
}
