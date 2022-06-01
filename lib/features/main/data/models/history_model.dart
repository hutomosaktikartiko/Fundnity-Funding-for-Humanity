// Category => 1 => Donation,
// Category => 2 => Create Campaign,

class HistoryModel {
  int? category, timestamp;
  String? campaignTitle, transactionHash, amount;

  HistoryModel({
    this.category,
    this.timestamp,
    this.amount,
    this.campaignTitle,
    this.transactionHash,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      category: json['category'] ?? null,
      timestamp: json['timestamp'] ?? null,
      amount: json['amount'] ?? null,
      campaignTitle: json['campaign_title'] ?? null,
      transactionHash: json['transaction_hash'] ?? null,
    );
  }

  Map<String, dynamic> toJson() => {
        'category': category,
        'timestamp': timestamp,
        'amount': amount,
        'campaign_title': campaignTitle,
        'transaction_hash': transactionHash,
      };
}
