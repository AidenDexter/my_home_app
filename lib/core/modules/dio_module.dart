import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../app_connect/app_connect.dart';
import '../environment/app_environment.dart';

@module
abstract class DioModule {
  @lazySingleton
  @Named('BaseDio')
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppEnvironment<AppConfig>.instance().config.url,
        receiveTimeout: const Duration(seconds: 35),
      ),
    )..interceptors.addAll([LogInterceptor(requestBody: true, responseBody: true)]);

    // Init app connect
    const appConnect = AppConnect();
    final connectInterceptor = ConnectInterceptor(appConnect: appConnect);
    dio.interceptors.add(connectInterceptor);
    return dio;
  }

  @lazySingleton
  @Named('BaseDioHome')
  Dio get dioHome {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppEnvironment<AppConfig>.instance().config.urlHome,
        receiveTimeout: const Duration(seconds: 35),
      ),
    )..interceptors.addAll([LogInterceptor(requestBody: true, responseBody: true)]);

    // Init app connect
    const appConnect = AppConnect();
    final connectInterceptor = ConnectInterceptor(appConnect: appConnect);
    dio.interceptors.add(connectInterceptor);
    return dio;
  }

  @lazySingleton
  @Named('BaseDioTnet')
  Dio get dioTnet {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppEnvironment<AppConfig>.instance().config.urlTnet,
        receiveTimeout: const Duration(seconds: 35),
      ),
    )..interceptors.addAll([LogInterceptor(requestBody: true, responseBody: true)]);

    // Init app connect
    const appConnect = AppConnect();
    final connectInterceptor = ConnectInterceptor(appConnect: appConnect);
    dio.interceptors.add(connectInterceptor);
    return dio;
  }
}
