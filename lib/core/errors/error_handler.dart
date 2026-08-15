import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/errors/error.dart';
import 'package:e_commerce_app/core/failure/failure.dart';

class ErrorHandler {
  static Failure handle(dynamic exception) {
    if (exception is DioException) {
      return _handleDioError(exception);
    } else if (exception is RemoteException) {
      return _handleRemoteError(exception.errormessage);
    } else if (exception is LocalException) {
      return Failure(exception.errormessage);
    } else if (exception is Appexception) {
      return Failure(exception.errormessage);
    } else if (exception is Exception) {
      return Failure(exception.toString().replaceAll("Exception: ", ""));
    } else {
      return Failure("Something went wrong, please try again later.");
    }
  }

  static Failure _handleDioError(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Failure("Connection timed out. The server is not responding.");
      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode;
        if (statusCode != null) {
          if (statusCode == 401) {
            return Failure("Your session has expired. Please login again.");
          } else if (statusCode == 403) {
            return Failure("You don't have permission to perform this action.");
          } else if (statusCode == 404) {
            return Failure("The requested resource was not found.");
          } else if (statusCode == 422) {
            return Failure("Invalid information provided. Please check your inputs.");
          } else if (statusCode >= 500) {
            return Failure(
              "Our server is having trouble. Please try again in a few minutes.",
            );
          }
        }
        return Failure(
          exception.response?.statusMessage ?? "A server error occurred.",
        );
      case DioExceptionType.cancel:
        return Failure("Request was cancelled.");
      case DioExceptionType.connectionError:
        return Failure("No internet connection. Please check your network.");
      case DioExceptionType.badCertificate:
        return Failure("Security certificate error.");
      case DioExceptionType.unknown:
      default:
        final message = exception.message ?? "";
        if (message.isNotEmpty) {
          return _handleRemoteError(message);
        }
        return Failure("Something went wrong, please try again later.");
    }
  }

  static Failure _handleRemoteError(String message) {
    if (message.contains("401") ||
        message.contains("Unauthorized") ||
        message.contains("Unauthenticated")) {
      return Failure("Your session has expired. Please login again.");
    } else if (message.contains("403") || message.contains("Forbidden")) {
      return Failure("You don't have permission to perform this action.");
    } else if (message.contains("404") || message.contains("Not Found")) {
      return Failure("The requested resource was not found.");
    } else if (message.contains("500") ||
        message.contains("Internal Server Error")) {
      return Failure(
        "Our server is having trouble. Please try again in a few minutes.",
      );
    } else if (message.contains("422") ||
        message.contains("Unprocessable Content")) {
      return Failure("Invalid information provided. Please check your inputs.");
    } else if (message.contains("SocketException") ||
        message.contains("Connection failed") ||
        message.contains("HandshakeException")) {
      return Failure("No internet connection. Please check your network.");
    } else if (message.contains("Timeout") || message.contains("Deadline")) {
      return Failure("Connection timed out. The server is not responding.");
    } else if (message.contains("TypeError") ||
        message.contains("FormatException")) {
      return Failure("We encountered a technical issue while processing data.");
    } else if (message.isNotEmpty &&
        !message.contains("400") &&
        !message.contains("Exception")) {
      return Failure(message);
    } else {
      return Failure(message.isNotEmpty ? message : "Something went wrong, please try again later.");
    }
  }
}
