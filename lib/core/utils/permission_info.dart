import 'package:permission_handler/permission_handler.dart';

abstract class PermissionInfo {
  Future<bool> get directoryPermission;
}

class PermissionInfoImpl implements PermissionInfo {
  @override
  Future<bool> get directoryPermission async {
    final PermissionStatus permissionStatus = await Permission.storage.request();

    if (permissionStatus.isGranted) {
      return true;
    } else {
      return false;
    }
  }
}
