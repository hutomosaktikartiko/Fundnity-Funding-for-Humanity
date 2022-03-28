part of 'auth_body_cubit.dart';

abstract class AuthBodyState extends Equatable {
  const AuthBodyState();

  @override
  List<Object> get props => [];
}

class AuthBodyLogin extends AuthBodyState {}

class AuthBodyCreateWallet extends AuthBodyState {}

class AuthBodyImportWallet extends AuthBodyState {}
