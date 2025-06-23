import 'package:dio/dio.dart';

class DioHelperPayMent {
  static Dio? dio;

  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://accept.paymob.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> postData({
    required String path,
    Map<String, dynamic>? data,
  }) async {
    return await dio!.post(path, data: data);
  }
}
