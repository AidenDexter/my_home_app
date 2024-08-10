import 'core/environment/app_environment.dart';

import 'runner/runner.dart' as runner;

void main() {
  AppEnvironment.init(
    config: const AppConfig(
      flavor: Flavor.dev,
      debugOptions: DebugOptions(),
    ),
  );
  runner.run();
}
