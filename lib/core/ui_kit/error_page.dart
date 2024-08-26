import 'package:flutter/material.dart';

import '../error/error_handler.dart';
import '../extension/extensions.dart';

@immutable
class ErrorBody extends StatelessWidget {
  final IErrorHandler error;
  final EdgeInsets padding;
  final List<Widget> actions;

  const ErrorBody({
    required this.error,
    required this.actions,
    this.padding = const EdgeInsets.fromLTRB(16, 0, 16, 16),
    super.key,
  });

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Material(
          color: context.themeOf.scaffoldBackgroundColor,
          child: Padding(
            padding: padding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: _Error(error: error)),
                ...actions.map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: e,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

@immutable
class _Error extends StatelessWidget {
  final IErrorHandler error;

  const _Error({required this.error});

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            context.imageFromError(error),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                /* TODO: Заменить на локализацию */
                'error',
                style: context.theme.commonTextStyles.title1,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 18),
            Flexible(
              child: SingleChildScrollView(
                child: Text(
                  context.messageFromError(error),
                  style:
                      context.theme.commonTextStyles.title3.copyWith(color: context.theme.commonColors.neutralgrey10),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      );
}
