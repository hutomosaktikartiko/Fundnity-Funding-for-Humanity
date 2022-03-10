import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/extenstions/date_time_parsing.dart';

part 'create_campaign_data_state.dart';

class CreateCampaignDataCubit
    extends Cubit<CreateCampaignDataState> {
  CreateCampaignDataCubit() : super(CreateCampaignDataState());

  void setAmount({required double? amount}) {
    emit(CreateCampaignDataState(
      amount: amount,
      time: state.time,
      title: state.title,
      image: state.image,
      description: state.description,
    ));
  }

  void setSelectedTime({required int? selectedTime}) {
    emit(CreateCampaignDataState(
      time: selectedTime,
      amount: state.amount,
      title: state.title,
      image: state.image,
      description: state.description,
    ));
  }

  void setSelectedDateTime({required DateTime? selectedTime}) {
    final int? days = selectedTime?.daysBetween();

    emit(CreateCampaignDataState(
      time: days,
      amount: state.amount,
      title: state.title,
      image: state.image,
      description: state.description,
    ));
  }
}
