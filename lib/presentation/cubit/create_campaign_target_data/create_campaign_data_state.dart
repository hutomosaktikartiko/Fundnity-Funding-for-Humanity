part of 'create_campaign_data_cubit.dart';

class CreateCampaignDataState extends Equatable {
  final int? time;
  final double? amount;
  final String? title, description;
  final File? image;

  const CreateCampaignDataState({
    this.time,
    this.amount,
    this.title,
    this.description,
    this.image,
  });

  @override
  List<Object?> get props => [
        time,
        amount,
        title,
        description,
        image,
      ];
}
