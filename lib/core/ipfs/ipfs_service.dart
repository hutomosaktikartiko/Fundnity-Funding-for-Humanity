import 'package:dio/dio.dart';

class IpfsService {
  final Dio dio;

  IpfsService({required this.dio});

  Future<dynamic> postFile({
    required String url,
    var queryParameters,
    var formData,
    var authorizationsToken,
  }) async {
    try {
      Response response = await dio.post(
        url,
        queryParameters: queryParameters,
        data: formData,
        options: Options(
          headers: {
            'Authorization': "Basic $authorizationsToken",
          },
        ),
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print((received / total * 100).toStringAsFixed(0) + "%");
          }
        }
      );

      return response.data;
    } on DioError catch (error) {
      // The request was made and the server responded with a statuc code
      // that falls out of the range of 2xx and is also not 304.
      if (error.response != null) {
        return error.response?.data;
      }
    }
  }

  Future<dynamic> post({
    required String url,
    var queryParameters,
    var authorizationToken,
    ResponseType responseType = ResponseType.plain,
  }) async {
    try {
      Response response = await dio.post(url,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Authorization': "Basic $authorizationToken",
          },
        ),
        
      );

      return {
        "statusCode": response.statusCode,
        "data": response.data,
      };
    } on DioError catch (error) {
      // The request was made and the server responded with a statuc code
      // that falls out of the range of 2xx and is also not 304.
      if (error.response != null) {
        return error.response?.data;
      }
    }
  }
}
