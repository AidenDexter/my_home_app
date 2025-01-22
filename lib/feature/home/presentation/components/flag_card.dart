import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/extension/extensions.dart';
import '../../../../core/resources/assets.gen.dart';

class FlagCard extends StatelessWidget {
  const FlagCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: context.theme.commonColors.darkGrey30.withValues(alpha: .2),
          blurRadius: 1,
        ),
      ]),
      child: SizedBox(
        height: 20,
        width: 28,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: switch (context.l10n.localeName) {
            'ka' => Assets.icons.flags.ge4x3.svg(),
            'ru' => Assets.icons.flags.ru4x3.svg(),
            'en' => Assets.icons.flags.us4x3.svg(),
            String() => Assets.icons.flags.ge4x3.svg(),
          },
        ).animate(key: UniqueKey()).fadeIn(curve: Curves.easeInOut, duration: const Duration(milliseconds: 400)),
      ),
    );
  }
}
