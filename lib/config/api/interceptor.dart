import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_clean_riverpod/config/routes/app_router.dart';
import 'package:flutter_clean_riverpod/config/routes/routes.dart';
import 'package:flutter_clean_riverpod/core/constants/constants.dart';
import 'package:flutter_clean_riverpod/core/constants/keys.dart';
import 'package:flutter_clean_riverpod/core/error/exception_handler.dart';
import 'package:flutter_clean_riverpod/core/injection_container.dart';
import 'package:flutter_clean_riverpod/core/utils/logger_helper.dart';
import 'package:flutter_clean_riverpod/data/local/secure_storage.dart';
import 'package:flutter_clean_riverpod/domain/entities/data_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Global maintenance flag; if true, requests are short-circuited
bool isMaintaining = false;

List<FailedRequest> _failedRequestStack = [];

class FailedRequest {
  FailedRequest({
    required this.err,
    required this.handler,
  });

  final DioException err;
  final ErrorInterceptorHandler handler;
}

class MyInterceptor extends Interceptor {
  MyInterceptor({
    required this.dio,
  });

  final Dio dio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (isMaintaining) {
      return;
    }
    const requestDuration = Duration(seconds: 10);
    options.baseUrl = Constants.baseUrl;

    final updatedOptions = options.copyWith(
      sendTimeout: requestDuration,
      connectTimeout: requestDuration,
      receiveTimeout: requestDuration,
    )..receiveDataWhenStatusError = true;

    updatedOptions.headers
        .removeWhere((key, value) => key == HttpHeaders.contentTypeHeader);
    updatedOptions.headers.addAll({
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    });

    final isUserLogin =
        await getIt<SecureStorage>().get(accessTokenKey) != null;

    if (isUserLogin) {
      final String? accessToken =
          await getIt<SecureStorage>().get(accessTokenKey);

      final authorizationHeader = 'Bearer $accessToken';

      if (updatedOptions.headers.containsKey(HttpHeaders.authorizationHeader)) {
        updatedOptions.headers[HttpHeaders.authorizationHeader] =
            authorizationHeader;
      } else {
        updatedOptions.headers.addAll(
          {
            HttpHeaders.authorizationHeader: authorizationHeader,
          },
        );
      }
    }

    // Debug request logging
    printRequest(updatedOptions);

    handler.next(updatedOptions);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    // Debug response logging
    printOnResponse(response);
    handler.next(response);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    onErrorPrint(err);

    if (err.response?.statusCode == 401) {
      await getIt<SecureStorage>().remove(accessTokenKey);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        rootNavigatorKey.currentContext!.go(Routes.login);
      });
      return;
    }
    handler.next(err);
  }

  void addToFailedStack({
    required DioException err,
    required ErrorInterceptorHandler handler,
  }) {
    if (_failedRequestStack.indexWhere(
          (element) =>
              element.err.requestOptions.path == err.requestOptions.path,
        ) ==
        -1) {
      _failedRequestStack.add(FailedRequest(err: err, handler: handler));
    }
  }
}

class RetryRequest {
  RetryRequest() {
    _dio = Dio();
  }

  late Dio _dio;

  Future<DataState<dynamic>> retryRequest(RequestOptions requestOptions) async {
    try {
      final accessToken = await getIt<SecureStorage>().get(accessTokenKey);

      final authorizationHeader = 'Bearer $accessToken';

      if (requestOptions.headers.containsKey(HttpHeaders.authorizationHeader)) {
        requestOptions.headers[HttpHeaders.authorizationHeader] =
            authorizationHeader;
      } else {
        requestOptions.headers.addAll(
          {
            HttpHeaders.authorizationHeader: authorizationHeader,
          },
        );
      }

      final request = await _dio.request<Response<dynamic>>(
        requestOptions.baseUrl + requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: Options(
          method: requestOptions.method,
          extra: requestOptions.extra,
          headers: requestOptions.headers,
          receiveDataWhenStatusError: true,
          responseDecoder: requestOptions.responseDecoder,
          requestEncoder: requestOptions.requestEncoder,
          responseType: requestOptions.responseType,
          contentType: requestOptions.contentType,
          receiveTimeout: requestOptions.receiveTimeout,
          sendTimeout: requestOptions.sendTimeout,
        ),
      );
      return DataSuccess(request);
    } on DioException catch (e) {
      return DataFailed(ExceptionHandler(dioException: e));
    }
  }
}
