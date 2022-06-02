import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_campaign_state.dart';

class SearchCampaignCubit extends Cubit<SearchCampaignState> {
  SearchCampaignCubit() : super(SearchCampaignInitial());
}
