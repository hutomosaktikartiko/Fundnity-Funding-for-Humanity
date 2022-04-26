// Category => 1 => Donation,
// Category => 2 => Create Campaign,

class HistoryModel {
  int? category;
  String? date;

  HistoryModel({
    this.category,
    this.date,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json){
    return HistoryModel(
      category: json['category'] ?? null,
      date: json['date'] ?? null,
    );
  }
}