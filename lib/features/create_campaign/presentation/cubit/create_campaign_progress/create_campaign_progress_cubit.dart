import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_campaign_progress_state.dart';

class CreateCampaignProgressCubit extends Cubit<CreateCampaignProgressState> {
  CreateCampaignProgressCubit() : super(CreateCampaignProgressState(
    index: 0
  ));

  void changeIndex({required int index}) {
    emit(CreateCampaignProgressState(
      index: index
    ));
  }
}
