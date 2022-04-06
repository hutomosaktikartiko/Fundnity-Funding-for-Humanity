class GasTrackerModel {
  String? lastBlock, safeGasPrice, proposeGasPrice, fastGasPrice, suggestBaseFee, gasUsedRatio;

  GasTrackerModel({
    this.lastBlock,
    this.safeGasPrice,
    this.proposeGasPrice,
    this.fastGasPrice,
    this.suggestBaseFee,
    this.gasUsedRatio,
  });
  
  factory GasTrackerModel.fromJson(Map<String, dynamic> json) => GasTrackerModel(
    lastBlock: json['LastBlock'] == null ? null : json['LastBlock'],
    safeGasPrice: json['SafeGasPrice'] == null ? null : json['SafeGasPrice'],
    proposeGasPrice: json['ProposeGasPrice'] == null ? null : json['ProposeGasPrice'],
    fastGasPrice: json['FastGasPrice'] == null ? null : json['FastGasPrice'],
    suggestBaseFee: json['suggestBaseFee'] == null ? null : json['suggestBaseFee'],
    gasUsedRatio: json['gasUsedRatio'] == null ? null : json['gasUsedRatio'],
  );
}