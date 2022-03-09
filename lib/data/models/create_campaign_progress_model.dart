class CreateCampaignProgressModel {
  int? number;
  String? label;

  CreateCampaignProgressModel({
    this.label,
    this.number,
  });
}

final List<CreateCampaignProgressModel> mockListCreateCampaignProgresses = [
  CreateCampaignProgressModel(
    number: 1,
    label: 'Target',
  ),
  CreateCampaignProgressModel(
    number: 2,
    label: 'Title',
  ),
  CreateCampaignProgressModel(
    number: 3,
    label: 'Description',
  ),
];
