class CampaignFirestoreModel {
  String? image, title, description, creatorAddress, transactionHash;
  int? startDate, endDate, timestamp, target;

  CampaignFirestoreModel({
    this.image,
    this.title,
    this.description,
    this.target,
    this.creatorAddress,
    this.startDate,
    this.endDate,
    this.transactionHash,
    this.timestamp,
  });

  factory CampaignFirestoreModel.fromJson(Map<String, dynamic> json) {
    return CampaignFirestoreModel(
      image: json['image'],
      title: json['title'],
      description: json['description'],
      target: (json['target'] == null) ? null : json['target'].toInt(),
      creatorAddress: json['creator_address'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      transactionHash: json['transaction_hash'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() => {
        'image': image,
        'title': title,
        'description': description,
        'target': target,
        'creator_address': creatorAddress,
        'start_date': startDate,
        'end_date': endDate,
        'transaction_hash': transactionHash,
        'timestamp': timestamp,
      };
}
