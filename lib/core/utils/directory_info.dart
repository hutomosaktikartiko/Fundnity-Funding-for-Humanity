import 'dart:io';

import 'package:path_provider/path_provider.dart';

abstract class DirectoryInfo {
  Future<Directory?> get externalStorageDirectory;
  Future<Directory?> get documentsDirectory;
}

class DirectoryInfoImpl implements DirectoryInfo {
  @override
  Future<Directory?> get externalStorageDirectory async {
    return await getExternalStorageDirectory();
  }

  @override
  Future<Directory?> get documentsDirectory async {
    return await getApplicationDocumentsDirectory();
  }
}
