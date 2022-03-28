class IpfsUploadModel {
  String? name, hash, size;

  IpfsUploadModel({
    this.hash,
    this.name,
    this.size,
  });

  factory IpfsUploadModel.fromJson(Map<String, dynamic> json) {
    return IpfsUploadModel(
      name: json['Name'],
      hash: json['Hash'],
      size: json['Size'],
    );
  }
}
