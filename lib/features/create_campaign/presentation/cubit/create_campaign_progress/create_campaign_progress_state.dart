part of 'create_campaign_progress_cubit.dart';

class CreateCampaignProgressState extends Equatable {
  final int index;

  const CreateCampaignProgressState({
    required this.index
  });

  @override
  List<Object?> get props => [index];
}
