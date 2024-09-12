import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extension/extensions.dart';
import '../../../core/resources/assets.gen.dart';
import '../../../core/ui_kit/primary_icon_button.dart';

class AddAdPage extends StatelessWidget {
  const AddAdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.theme.commonColors.green10,
      child: Material(
        color: Colors.transparent,
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 8,
                right: 16,
                child: PrimaryIconButton(
                  icon: const Icon(Icons.close),
                  onTap: context.pop,
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Assets.icons.pageInDevelopment.svg(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 48),
                      child: Text(
                        context.l10n.page_in_development,
                        style: context.theme.commonTextStyles.headline3.copyWith(
                          color: context.theme.commonColors.green100,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
