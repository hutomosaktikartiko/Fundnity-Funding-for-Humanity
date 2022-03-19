import 'package:crowdfunding/core/ipfs/ipfs_service.dart';
import 'package:dio/dio.dart';

class IpfsClient {
  final String url;
  final String authorizationToken;
  final IpfsService ipfsService;

  IpfsClient({
    required this.url,
    required this.authorizationToken,
    required this.ipfsService,
  });

  /// Make a directory in IPFS
  /// For more: https://docs.ipfs.io/reference/api/http/#post-api-v0-files-mkdir
  Future<dynamic> mkdir({required String dir}) async {
    _checkDir(dir: dir);

    var params = {
      'arg': dir,
      'parent': true,
    };

    try {
      var response = await ipfsService.post(
        url: '$url/api/v0/files/mkdir?',
        queryParameters: params,
        authorizationToken: authorizationToken,
      );

      return response;
    } on DioError catch (error) {
      // The request was made and the server responded with a statuc code
      // that falls out of the range of 2xx and is also not 304.
      if (error.response != null) {
        return error.response?.data;
      }
    }
  }

  /// List directories in the local mutable namspace
  /// For more: https://docs.ipfs.io/reference/api/http/#post-api-v0-files-ls
  Future<dynamic> ls({
    required String dir,
  }) async {
    _checkDir(dir: dir);

    var params = {
      'arg': dir,
      'long': true,
      'U': true,
    };

    try {
      var response = await ipfsService.post(
        url: '$url/api/v0/files/ls?',
        queryParameters: params,
        authorizationToken: authorizationToken,
      );

      return response;
    } on DioError catch (error) {
      // The request was made and the server responded with a statuc code
      // that falls out of the range of 2xx and is also not 304.
      if (error.response != null) {
        return error.response?.data;
      }
    }
  }

  /// Diplay file status
  /// For more: https://docs.ipfs.io/reference/api/http/#post-api-v0-files-stat
  Future<dynamic> stat({
    required String dir,
    Map<String, dynamic> dataParams = const {},
  }) async {
    _checkDir(dir: dir);

    var params = {
      'arg': dir,
      ...dataParams,
    };

    try {
      var response = await ipfsService.post(
        url: '$url/api/v0/files/stat?',
        queryParameters: params,
        authorizationToken: authorizationToken,
      );

      return response;
    } on DioError catch (error) {
      // The request was made and the server responded with a statuc code
      // that falls out of the range of 2xx and is also not 304.
      if (error.response != null) {
        return error.response?.data;
      }
    }
  }

  /// Wwite to a file in a given filesystem.
  /// For more: https://docs.ipfs.io/reference/api/http/#post-api-v0-files-write
  Future<dynamic> write({
    required String dir,
    required String filePath,
    String fileName = '',
  }) async {
    _checkDir(dir: dir);

    var params = {
      'arg': dir,
      'create': true,
    };

    try {
      var response = await ipfsService.postFile(
        url: url,
        formData: await _getFormData(filePath: filePath, fileName: fileName),
        queryParameters: params,
        authorizationsToken: authorizationToken,
      );

      return response;
    } on DioError catch (error) {
      // The request was made and the server responded with a statuc code
      // that falls out of the range of 2xx and is also not 304.
      if (error.response != null) {
        return error.response?.data;
      }
    }
  }

  /// Read a file in a given MFS.
  /// For more: https://docs.ipfs.io/reference/api/http/#post-api-v0-files-read
  Future<dynamic> read({
    required String dir,
  }) async {
    _checkDir(dir: dir);

    var params = {
      'arg': dir,
      'offset': 0,
      'count': -1,
    };

    try {
      var response = await ipfsService.post(
        url: '$url/api/v0/files/read?',
        queryParameters: params,
        authorizationToken: authorizationToken,
        responseType: ResponseType.bytes,
      );

      return response;
    } on DioError catch (error) {
      // The request was made and the server responded with a statuc code
      // that falls out of the range of 2xx and is also not 304.
      if (error.response != null) {
        return error.response?.data;
      }
    }
  }

  /// Remove a file/dir
  /// For more: https://docs.ipfs.io/reference/api/http/#post-api-v0-files-rm
  /// recursive [bool]: recursively remove directories. Required: no.
  Future<dynamic> rm({
    required String dir,
    bool recursive = true,
  }) async {
    _checkDir(dir: dir);

    var params = {
      'arg': dir,
      'recursive': recursive,
    };

    try {
      var response = await ipfsService.post(
        url: '$url/api/v0/files/rm?',
        queryParameters: params,
        authorizationToken: authorizationToken,
      );

      return response;
    } on DioError catch (error) {
      // The request was made and the server responded with a statuc code
      // that falls out of the range of 2xx and is also not 304.
      if (error.response != null) {
        return error.response?.data;
      }
    }
  }

  /// Move a file/mv
  /// For more: https://docs.ipfs.io/reference/api/http/#post-api-v0-files-mv
  Future<dynamic> mv({
    required String oldPath,
    required String newPath,
  }) async {
    _checkDir(dir: oldPath);
    _checkDir(dir: newPath);

    try {
      var response = await ipfsService.post(
        url: '$url/api/v0/files/mv?arg=$oldPath&arg=$newPath',
        authorizationToken: authorizationToken,
      );

      return response;
    } on DioError catch (error) {
      // The request was made and the server responded with a statuc code
      // that falls out of the range of 2xx and is also not 304.
      if (error.response != null) {
        return error.response?.data;
      }
    }
  }

  String _checkDir({
    required String dir,
  }) {
    if (!dir.startsWith("/")) return dir = "/$dir";

    return dir;
  }

  Future<FormData> _getFormData({
    required String filePath,
    required String fileName,
  }) async {
    return FormData.fromMap({
      "file": await MultipartFile.fromFile(
        filePath,
        filename: fileName,
      ),
    });
  }
}
