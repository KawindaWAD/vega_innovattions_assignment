import 'package:dio/dio.dart';
import '../../features/common/data/models/dio_response_model.dart';
import '../network/server_error_data.dart';

/// Throws when there's no shared pref data to fetch
class CacheException implements Exception {}

/// Exception for the HTTP requests from Dio
class ServerException implements Exception {
  late String errorMessage;
  late bool unexpectedError;
  ServerErrorData? data;

  ServerException({required this.errorMessage, required this.unexpectedError});

  /// Constructor for Dio package
  ServerException.fromDioError(DioError dioError) {
    data = ServerErrorData.fromDioError(dioError);
    switch (dioError.type) {
      case DioErrorType.cancel:
        errorMessage = "Request to the server was cancelled.";
        unexpectedError = false;
        break;
      case DioErrorType.connectTimeout:
        errorMessage = "Connection timed out. Try again or later!";
        unexpectedError = false;
        break;
      case DioErrorType.receiveTimeout:
        errorMessage = "Receiving timeout occurred. Try again or later!";
        unexpectedError = false;
        break;
      case DioErrorType.sendTimeout:
        errorMessage = "Request send timeout. . Try again or later!";
        unexpectedError = false;
        break;
      case DioErrorType.response:
        errorMessage = _handleStatusCode(dioError.response);
        break;
      case DioErrorType.other:
        if (dioError.message.contains('SocketException')) {
          errorMessage = "Request failed. Make sure your connection has internet access";
          unexpectedError = false;
          break;
        }
        errorMessage = "Unexpected error occurred.";
        unexpectedError = true;
        break;
      default:
        errorMessage = "Something went wrong. Please try again later!";
        unexpectedError = true;
        break;
    }
  }

  String _handleStatusCode(Response? response) {
    int? statusCode = response?.statusCode;
    switch (statusCode) {
      case 400:
        unexpectedError = true;
        return "Bad request!";
      case 401:
        unexpectedError = false;
        return "Authentication failed. Please Login again!";
      case 403:
        unexpectedError = false;
        return "The authenticated user is not allowed to access the specified API endpoint.";
      case 404:
        unexpectedError = true;
        return "The requested resource does not exist.";
      case 405:
        unexpectedError = true;
        return "Method not allowed. Please check the Allow header for the allowed HTTP methods.";
      case 415:
        unexpectedError = true;
        return "Unsupported media type. The requested content type or version number is invalid.";
      case 422:
        unexpectedError = false;
        return _getDataValidationErrorMessage(response) ?? "Data validation failed.";
      case 429:
        unexpectedError = true;
        return "Too many requests.";
      case 500:
        unexpectedError = true;
        return "Internal server error. Please contact admin!";
      default:
        unexpectedError = true;
        return "Oops something went wrong! Error ${statusCode.toString()}";
    }
  }

  /// Generate Validation Errors (Status 422)
  String? _getDataValidationErrorMessage(Response? response) {
    try {
      DioResponseModel res = dioResponseModelFromJson(response?.data);

      if (res.errors?.businessId != null) {
        return res.errors?.businessId?.first;
      }
      if (res.errors?.roleId != null) {
        return res.errors?.roleId?.first;
      }
      if (res.errors?.email != null) {
        return res.errors?.email?.first;
      }
      if (res.errors?.contactNumber != null) {
        return res.errors?.contactNumber?.first;
      }
      if (res.errors?.name != null) {
        return res.errors?.name?.first;
      }
      if (res.errors?.firebaseUid != null) {
        return res.errors?.firebaseUid?.first;
      }
      if (res.errors?.passwordIsAlreadyReset != null) {
        return res.errors?.passwordIsAlreadyReset?.first;
      }
      if (res.errors?.password != null) {
        return res.errors?.password?.first;
      }
      if (res.errors?.invalidDefaultPassword != null) {
        return res.errors?.invalidDefaultPassword?.first;
      }
      if (res.errors?.invalidCredentials != null) {
        return res.errors?.invalidCredentials?.first;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  @override
  String toString() {
    return 'ServerException{errorMessage: $errorMessage, unexpectedError: $unexpectedError, data: ${data.toString()}}';
  }
}

/// Use to throw exception when the user not grant device permissions
class NoPermission implements Exception {}

/// Use to throw platform related exceptions
class DeviceException implements Exception {
  final String message;

  const DeviceException({
    required this.message,
  });
}