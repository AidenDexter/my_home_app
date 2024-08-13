part of '../app_connect.dart';

@immutable
abstract class IAppConnect {
  /// Слушает изменение интернет соединения
  Stream<bool> get onConnectChanged;

  /// Проверяет подключение к сети
  ///
  /// Возвращает *true* если доступ в интернет присутствует
  /// иначе *false*
  Future<bool> hasConnect();
}

@immutable
abstract class AppConnectBase implements IAppConnect {
  @override
  Stream<bool> get onConnectChanged => Connectivity().onConnectivityChanged.map(
        (event) => !event.contains(ConnectivityResult.none),
      );

  const AppConnectBase();

  @override
  Future<bool> hasConnect() async {
    final result = await Connectivity().checkConnectivity();
    return !result.contains(ConnectivityResult.none);
  }
}

@immutable
mixin _AppConnectMixin {}

@immutable
class AppConnect = AppConnectBase with _AppConnectMixin;

@immutable
class HasNoConnect implements Exception {
  const HasNoConnect();
}
