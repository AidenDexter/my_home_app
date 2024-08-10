// ignore_for_file: always_use_package_imports, library_private_types_in_public_api

import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:l/l.dart';

import '../app_connect/app_connect.dart';
import 'api_error/error_model.dart';
import 'api_error/field_error_model.dart';

@immutable
abstract class IErrorHandler {
  E when<E>({
    required E Function(TimeoutException error) timeout,
    required E Function(DioException error) dio,
    required E Function() connection,
    required E Function(Object error) unknown,
    required E Function(ErrorModel error) apiError,
    required E Function(List<FieldErrorModel> errors) apiFields,
    required E Function(String message) message,
  });

  E map<E>({
    required E Function(_TimeoutError error) timeout,
    required E Function(_DioError error) dio,
    required E Function(_ConnectionError error) connection,
    required E Function(_UnknownError error) unknown,
    required E Function(_ApiError error) apiError,
    required E Function(_ApiFieldError error) apiField,
    required E Function(_MessageError error) message,
  });
}

@immutable
abstract class ErrorHandler implements IErrorHandler {
  const ErrorHandler();

  factory ErrorHandler.fromError(Object object) {
    /// TimeoutException
    if (object is TimeoutException) {
      return _TimeoutError(object);
    }

    /// Connect Dio Error
    if (object is ConnectDioError) {
      return const _ConnectionError();
    }

    if (object is HasNoConnect) {
      return const _ConnectionError();
    }

    /// Dio Error
    if (object is DioException) {
      if (object.error is SocketException) {
        return const _ConnectionError();
      }

      final response = object.response;

      if (response != null && response.statusCode == 422 && response.data is List) {
        try {
          final responseData = response.data as List;
          final errorsList = List<Map<String, Object?>>.from(responseData);
          final errors = errorsList.map(FieldErrorModel.fromJson).toList();
          return _ApiFieldError(errors: errors);
        } on Object catch (error, sk) {
          l.e('Нарушен контракт модели ошибки $error', sk);
        }
      }

      if (response != null && response.data is Map<String, Object?>) {
        final json = response.data as Map<String, Object?>;
        try {
          final errorModel = ErrorModel.fromJson(json);
          return _ApiError(error: errorModel);
        } on Object catch (error, sk) {
          l.e('Нарушен контракт модели ошибки $error', sk);
        }
      }
      return _DioError(error: object);
    }

    /// Custom Message Error
    if (object is String) {
      return _MessageError(message: object);
    }

    /// Unknown Error
    return _UnknownError(error: object);
  }
}

@immutable
class _TimeoutError extends ErrorHandler {
  final TimeoutException exception;

  const _TimeoutError(this.exception);

  @override
  E when<E>({
    required E Function(TimeoutException error) timeout,
    required E Function(DioException error) dio,
    required E Function() connection,
    required E Function(Object error) unknown,
    required E Function(ErrorModel error) apiError,
    required E Function(List<FieldErrorModel> errors) apiFields,
    required E Function(String message) message,
  }) =>
      timeout(exception);

  @override
  E map<E>({
    required E Function(_TimeoutError error) timeout,
    required E Function(_DioError error) dio,
    required E Function(_ConnectionError error) connection,
    required E Function(_UnknownError error) unknown,
    required E Function(_ApiError error) apiError,
    required E Function(_ApiFieldError error) apiField,
    required E Function(_MessageError error) message,
  }) =>
      timeout(this);
}

@immutable
class _DioError extends ErrorHandler {
  final DioException error;

  const _DioError({
    required this.error,
  });

  @override
  E when<E>({
    required E Function(TimeoutException error) timeout,
    required E Function(DioException error) dio,
    required E Function() connection,
    required E Function(Object error) unknown,
    required E Function(ErrorModel error) apiError,
    required E Function(List<FieldErrorModel> errors) apiFields,
    required E Function(String message) message,
  }) =>
      dio(error);

  @override
  E map<E>({
    required E Function(_TimeoutError error) timeout,
    required E Function(_DioError error) dio,
    required E Function(_ConnectionError error) connection,
    required E Function(_UnknownError error) unknown,
    required E Function(_ApiError error) apiError,
    required E Function(_ApiFieldError error) apiField,
    required E Function(_MessageError error) message,
  }) =>
      dio(this);
}

@immutable
class _ConnectionError extends ErrorHandler {
  const _ConnectionError();

  @override
  E when<E>({
    required E Function(TimeoutException error) timeout,
    required E Function(DioException error) dio,
    required E Function() connection,
    required E Function(Object error) unknown,
    required E Function(ErrorModel error) apiError,
    required E Function(List<FieldErrorModel> errors) apiFields,
    required E Function(String message) message,
  }) =>
      connection();

  @override
  E map<E>({
    required E Function(_TimeoutError error) timeout,
    required E Function(_DioError error) dio,
    required E Function(_ConnectionError error) connection,
    required E Function(_UnknownError error) unknown,
    required E Function(_ApiError error) apiError,
    required E Function(_ApiFieldError error) apiField,
    required E Function(_MessageError error) message,
  }) =>
      connection(this);
}

@immutable
class _UnknownError extends ErrorHandler {
  final Object error;

  const _UnknownError({
    required this.error,
  });

  @override
  E when<E>({
    required E Function(TimeoutException error) timeout,
    required E Function(DioException error) dio,
    required E Function() connection,
    required E Function(Object error) unknown,
    required E Function(ErrorModel error) apiError,
    required E Function(List<FieldErrorModel> errors) apiFields,
    required E Function(String message) message,
  }) =>
      unknown(error);

  @override
  E map<E>({
    required E Function(_TimeoutError error) timeout,
    required E Function(_DioError error) dio,
    required E Function(_ConnectionError error) connection,
    required E Function(_UnknownError error) unknown,
    required E Function(_ApiError error) apiError,
    required E Function(_ApiFieldError error) apiField,
    required E Function(_MessageError error) message,
  }) =>
      unknown(this);
}

@immutable
class _MessageError extends ErrorHandler {
  /// Текст
  final String message;

  const _MessageError({
    required this.message,
  });

  @override
  E when<E>({
    required E Function(TimeoutException error) timeout,
    required E Function(DioException error) dio,
    required E Function() connection,
    required E Function(Object error) unknown,
    required E Function(ErrorModel error) apiError,
    required E Function(List<FieldErrorModel> errors) apiFields,
    required E Function(String message) message,
  }) =>
      message(this.message);

  @override
  E map<E>({
    required E Function(_TimeoutError error) timeout,
    required E Function(_DioError error) dio,
    required E Function(_ConnectionError error) connection,
    required E Function(_UnknownError error) unknown,
    required E Function(_ApiError error) apiError,
    required E Function(_ApiFieldError error) apiField,
    required E Function(_MessageError error) message,
  }) =>
      message(this);
}

@immutable
class _ApiFieldError extends ErrorHandler {
  final List<FieldErrorModel> errors;

  const _ApiFieldError({
    required this.errors,
  });

  @override
  E when<E>({
    required E Function(TimeoutException error) timeout,
    required E Function(DioException error) dio,
    required E Function() connection,
    required E Function(Object error) unknown,
    required E Function(ErrorModel error) apiError,
    required E Function(List<FieldErrorModel> errors) apiFields,
    required E Function(String message) message,
  }) =>
      apiFields(errors);

  @override
  E map<E>({
    required E Function(_TimeoutError error) timeout,
    required E Function(_DioError error) dio,
    required E Function(_ConnectionError error) connection,
    required E Function(_UnknownError error) unknown,
    required E Function(_ApiError error) apiError,
    required E Function(_ApiFieldError error) apiField,
    required E Function(_MessageError error) message,
  }) =>
      apiField(this);
}

@immutable
class _ApiError extends ErrorHandler {
  final ErrorModel error;

  const _ApiError({
    required this.error,
  });

  @override
  E when<E>({
    required E Function(TimeoutException error) timeout,
    required E Function(DioException error) dio,
    required E Function() connection,
    required E Function(Object error) unknown,
    required E Function(ErrorModel error) apiError,
    required E Function(List<FieldErrorModel> errors) apiFields,
    required E Function(String message) message,
  }) =>
      apiError(error);

  @override
  E map<E>({
    required E Function(_TimeoutError error) timeout,
    required E Function(_DioError error) dio,
    required E Function(_ConnectionError error) connection,
    required E Function(_UnknownError error) unknown,
    required E Function(_ApiError error) apiError,
    required E Function(_ApiFieldError error) apiField,
    required E Function(_MessageError error) message,
  }) =>
      apiError(this);
}

extension ObjectExtension on Object {
  IErrorHandler get toHandler => ErrorHandler.fromError(this);
}

@immutable
class UnknownError extends Object {
  const UnknownError();
}
