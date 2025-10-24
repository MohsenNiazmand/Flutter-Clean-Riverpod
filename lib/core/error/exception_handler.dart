import 'package:dio/dio.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_toast.dart';

class ExceptionHandler {
  /// Exception handler structure varies based on backend implementation.
  /// This class handles different error response formats from various APIs.
  dynamic get responseData => exception?.response?.data;
  DioException? get exception => dioException;
  int? get statusCode => exception?.response?.statusCode;
  ExceptionHandler({
    this.dioException,
    this.messageException,
  }) {
    final responseData = exception?.response?.data;
    if (messageException != null) {
      PrimaryToast.show(message);
    } else if (responseData != null) {
      // Extract error message from backend response
      String message = _extractErrorMessage(responseData);
      PrimaryToast.show(message);
    } else if (responseData == null) {
      PrimaryToast.show('Connection Failed, Try again later!');
    } else {
      PrimaryToast.show('An unexpected error occurred!');
    }

    if (exception?.response?.statusCode == 500) {
      PrimaryToast.show(
        'Server is busy now,try again later!',
      );
    }
    // Debug logging can be enabled here
  }
  final DioException? dioException;
  final String? messageException;

  /// Extract error message from various backend response formats
  String _extractErrorMessage(dynamic responseData) {
    if (responseData == null) return 'Unknown error';
    
    // Handle Django REST Framework error formats
    if (responseData is Map<String, dynamic>) {
      // Check for 'detail' field (common in DRF)
      if (responseData.containsKey('detail')) {
        final detail = responseData['detail'];
        if (detail is String) return detail;
        if (detail is List && detail.isNotEmpty) {
          return detail.first.toString();
        }
      }
      
      // Check for 'non_field_errors' (DRF validation errors)
      if (responseData.containsKey('non_field_errors')) {
        final errors = responseData['non_field_errors'];
        if (errors is List && errors.isNotEmpty) {
          return errors.first.toString();
        }
      }
      
      // Check for field-specific errors (e.g., 'title': ['error message'])
      for (final entry in responseData.entries) {
        if (entry.value is List && (entry.value as List).isNotEmpty) {
          return '${entry.key}: ${(entry.value as List).first}';
        }
      }
      
      // Check for 'message' field
      if (responseData.containsKey('message')) {
        return responseData['message'].toString();
      }
      
      // Check for 'error' field
      if (responseData.containsKey('error')) {
        return responseData['error'].toString();
      }
    }
    
    return 'Unknown error';
  }

  String? get message =>
      messageException ??
      (exception?.message?.contains('The request connection took longer') ==
              true
          ? 'Connection Failed, Try Again later'
          : exception?.message);

  @override
  String toString() {
    if (dioException != null) {
      return 'ExceptionHandler: \n---[Dio Failed]\n---URL: '
          '${dioException!.requestOptions.uri} \n'
          '---headers: ${dioException?.requestOptions.headers}'
          ' \n---Message: $message\n---StatusCode: $statusCode';
    }
    if (messageException != null) {
      return 'ExceptionHandler: \n---[Exception Message]\n---Message: $messageException';
    }
    return 'ExceptionHandler: unknown Error!';
  }

  ExceptionHandler copyWith({
    DioException? dioException,
    String? messageException,
  }) {
    return ExceptionHandler(
      dioException: dioException ?? this.dioException,
      messageException: messageException ?? this.messageException,
    );
  }
}
