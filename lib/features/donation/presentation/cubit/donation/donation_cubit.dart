import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'donation_state.dart';

class DonationCubit extends Cubit<DonationState> {
  DonationCubit() : super(DonationInitial());
}
