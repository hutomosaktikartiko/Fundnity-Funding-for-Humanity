import 'package:new_version/new_version.dart';

abstract class UpdateInfo {
  Future<VersionStatus?> get versionStatus;
}

class UpdateInfoImpl implements UpdateInfo {
  final NewVersion newVersion;

  UpdateInfoImpl({required this.newVersion});

  @override
  Future<VersionStatus?> get versionStatus => newVersion.getVersionStatus();
}
