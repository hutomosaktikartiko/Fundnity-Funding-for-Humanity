enum TransactionStatus {
  SUCCESS,
  FAILED,
}

class TransactionReceiptModel {
  String? blockHash, blockNumber, gasUsed;
  TransactionStatus? status;

  TransactionReceiptModel({
    this.blockHash,
    this.blockNumber,
    this.gasUsed,
    this.status,
  });

  factory TransactionReceiptModel.fromJson(Map<String, dynamic> json) {
    return TransactionReceiptModel(
      blockHash: json['blockHash'] ?? null,
      blockNumber: json['blockNumber'] ?? null,
      gasUsed: json['gasUsed'] ?? null,
      status: json['status'] == '0x1' ? TransactionStatus.SUCCESS : TransactionStatus.FAILED,
    );
  }
}
