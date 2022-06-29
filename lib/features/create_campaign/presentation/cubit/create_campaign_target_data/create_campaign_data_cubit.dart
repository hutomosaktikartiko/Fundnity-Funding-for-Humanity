import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../shared/extension/date_time_parsing.dart';

part 'create_campaign_data_state.dart';

class CreateCampaignDataCubit extends Cubit<CreateCampaignDataState> {
  CreateCampaignDataCubit() : super(CreateCampaignDataState());

  void clear() {
    emit(CreateCampaignDataState());
  }

  void reCreateCampaign({
    double? amount,
    String? description,
    String? title,
    int? time,
  }) {
    emit(CreateCampaignDataState(
      amount: (amount == 0) ? null : amount,
      description: description,
      time: (time == 0) ? null : time,
      title: title,
    ));
  }

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

  void setTitle({
    required String? title,
  }) {
    if (title?.trim() != "") {
      emit(CreateCampaignDataState(
        title: title,
        amount: state.amount,
        description: state.description,
        image: state.image,
        time: state.time,
      ));
    }
  }

  void setImage({
    required File? image,
  }) {
    emit(CreateCampaignDataState(
      image: image,
      amount: state.amount,
      title: state.title,
      time: state.time,
      description: state.description,
    ));
  }

  void setDescription({
    required String? description,
  }) {
    if (description?.trim() != "") {
      emit(CreateCampaignDataState(
        description: description,
        title: state.title,
        amount: state.amount,
        image: state.image,
        time: state.time,
      ));
    }
  }
}
