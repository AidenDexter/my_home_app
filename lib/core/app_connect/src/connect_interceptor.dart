part of '../app_connect.dart';

class ConnectInterceptor extends Interceptor {
  final IAppConnect _appConnect;

  ConnectInterceptor({
    required IAppConnect appConnect,
  }) : _appConnect = appConnect;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final hasConnect = await _appConnect.hasConnect().timeout(const Duration(seconds: 5));
      return hasConnect ? handler.next(options) : handler.reject(ConnectDioError(requestOptions: options));
    } on Object catch (error, stackTrace) {
      l.e(
        '[ConnectInterceptor] - Не удалось определить интернет подключение: $error',
        stackTrace,
      );
      return handler.next(options);
    }
  }
}

class ConnectDioError extends DioException {
  ConnectDioError({
    required super.requestOptions,
  }) : super(
          error: 'No internet connection, try again',
        );
}
