class TransactionStatusModel {
  String? isError, errorDescription;

  TransactionStatusModel({
    this.errorDescription,
    this.isError,
  });

  factory TransactionStatusModel.fromJson(Map<String, dynamic> json) {
    return TransactionStatusModel(
      errorDescription: json['errorDescription'] ?? null,
      isError: json['isError'] ?? null,
    );
  }
}