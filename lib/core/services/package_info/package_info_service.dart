import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'i_package_info_service.dart';

@Singleton(as: IPackageInfoService)
class PackageInfoService implements IPackageInfoService {
  static late final PackageInfo _packageInfo;
  const PackageInfoService();

  @override
  @PostConstruct(preResolve: true)
  Future<void> init() async => _packageInfo = await PackageInfo.fromPlatform();

  @override
  String get version => _packageInfo.version;
}
