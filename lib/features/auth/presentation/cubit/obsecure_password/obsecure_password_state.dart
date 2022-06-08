part of 'obsecure_password_cubit.dart';

class ObsecurePasswordState extends Equatable {
  const ObsecurePasswordState({
    this.isObsecure = false,
  });

  final bool isObsecure;

  @override
  List<Object> get props => [isObsecure];
}
