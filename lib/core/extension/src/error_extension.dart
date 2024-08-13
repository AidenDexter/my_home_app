import 'package:flutter/widgets.dart';

import '../../error/error_handler.dart';

extension ErrorExtension on BuildContext {
  String messageFromError(IErrorHandler errorHandler) => errorHandler.when(
        timeout: (_) => 'timeout',
        dio: (_) => 'unexpected_error',
        connection: () => 'no_internet',
        apiError: (error) => error.message,
        apiFields: (errors) {
          if (errors.isNotEmpty) {
            return errors.first.message;
          }
          return 'invalid_data';
        },
        unknown: (_) => 'unexpected_error',
        message: (message) => message,
      );

  // Image imageFromError(IErrorHandler errorHandler) => errorHandler.when(
  //       timeout: (_) => Assets.images.clock.image(),
  //       dio: (_) => Assets.images.fail.image(),
  //       connection: () => Assets.images.internet.image(),
  //       apiError: (_) => Assets.images.fail.image(),
  //       apiFields: (_) => Assets.images.fail.image(),
  //       unknown: (_) => Assets.images.fail.image(),
  //       message: (_) => Assets.images.fail.image(),
  //     );
}
