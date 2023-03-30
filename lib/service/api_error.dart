import 'package:dio/dio.dart';
import 'package:reqresapp/utils/app_string.dart';

/// Helper class for converting [DioError] into readable formats
class ApiError {
  /// description of error generated this is similar to convention [Error.message]
  String? errorDescription;

  ApiError({this.errorDescription});

  ApiError.fromDio(Object dioError) {
    _handleError(dioError);
  }

  /// sets value of class properties from [error]
  void _handleError(Object error) {
    if (error is DioError) {
      DioError dioError = error; // as DioError;
      switch (dioError.type) {
        case DioErrorType.cancel:
          errorDescription = AppString.cancelled;
          break;
        case DioErrorType.connectionTimeout:
          errorDescription = AppString.connectionTimeout;
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = AppString.timeout;
          break;
        case DioErrorType.badResponse:
          errorDescription = _handleStatusCodeResponse(dioError.response);
          break;
        case DioErrorType.sendTimeout:
          errorDescription = AppString.sendTimeout;
          break;
        default:
          errorDescription = AppString.systemErrorMessage;
          break;
      }
    } else {
      errorDescription = AppString.systemErrorMessage;
    }
  }

  @override
  String toString() => '$errorDescription';

  String _handleStatusCodeResponse(Response<dynamic>? response) {
    int? errorType = response?.statusCode;
    switch (errorType) {
      case 302:
        return AppString.errorInCommunication;
      case 400:
      case 401:
      case 403:
        return _extractMessageFromResponse(response);
      default:
    }
    return '';
  }

  String _extractMessageFromResponse(Response<dynamic>? response) {
    String message = "";
    try {
      if (response?.data != null && response?.data["message"] != null) {
        message = response?.data["message"];
      } else {
        message = response?.statusMessage ?? '';
      }
    } catch (error, _) {
      message = response?.statusMessage ?? error.toString();
    }
    return message;
  }
}
