import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:reqresapp/utils/app_string.dart';

final RegExp isHTMLElementRegExp = RegExp(r'<\/?[^>]*>');

class ApiService {
  ApiService._internal();
  factory ApiService() => _instance;
  static final ApiService _instance = ApiService._internal();
  static ApiService get instance => _instance;

  final Dio client = Dio();
  Future<void> clientSetup(String baseUrl) async {
    client.options.baseUrl = baseUrl;
    if (kDebugMode) {
      client.interceptors
          .add(PrettyDioLogger(responseBody: true, requestBody: true));
    }
    client.interceptors
        .add(InterceptorsWrapper(onError: (DioError e, handler) async {
      if (e.response?.data.runtimeType == String &&
          isHTMLElementRegExp.hasMatch(e.response?.data)) {
        e.response!.data = AppString.systemErrorMessage;
      }
      return handler.next(e); //continue
      // If you want to resolve the request with some custom data，
      // you can resolve a `Response` object eg: return `dio.resolve(response)`.
      // If you want to reject the request with a error message,
      // you can reject a `DioError` object eg: return `dio.reject(dioError)`
    }));
  }
}
