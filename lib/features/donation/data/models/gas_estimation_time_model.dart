class GasEstimationTimeModel {
  String? timeInSecond;
  
  GasEstimationTimeModel({
    this.timeInSecond,
  });

  factory GasEstimationTimeModel.fromJson(Map<String, dynamic> json) => GasEstimationTimeModel(
    timeInSecond: json['result'] == null ? null : json['result'],
  );
}