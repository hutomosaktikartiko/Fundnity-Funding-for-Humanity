enum TransactionStatus {
  SUCCESS,
  FAILED,
}

class TransactionReceiptModel {
  String? blockHash, gasUsed;
  TransactionStatus? status;
  BigInt? blockNumber;

  TransactionReceiptModel({
    this.blockHash,
    this.blockNumber,
    this.gasUsed,
    this.status,
  });

  factory TransactionReceiptModel.fromJson(Map<String, dynamic> json) {
    return TransactionReceiptModel(
      blockHash: json['blockHash'] ?? null,
      blockNumber: convertStringToBigInt(json['blockNumber']),
      gasUsed: json['gasUsed'] ?? null,
      status: json['status'] == '0x1' ? TransactionStatus.SUCCESS : TransactionStatus.FAILED,
    );
  }

  static BigInt? convertStringToBigInt (String? value) {
    if (value == null) {
      return null;
    }

    return BigInt.parse(value);
  }
}
