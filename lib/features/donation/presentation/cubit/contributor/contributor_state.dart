part of 'contributor_cubit.dart';

abstract class ContributorState extends Equatable {
  const ContributorState();

  @override
  List<Object?> get props => [];
}

class ContributorInitial extends ContributorState {}

class ContributorLoading extends ContributorState {}

class ContributorLoaded extends ContributorState {
  final List<ContributorModel?> contributors;

  const ContributorLoaded({
    required this.contributors,
  });

  @override
  List<Object?> get props => [contributors];
}

class ContributorEmpty extends ContributorState {}

class ContributorLoadingFailure extends ContributorState {
  final String? message;

  const ContributorLoadingFailure({required this.message});

  @override
  List<Object?> get props => [message];
}