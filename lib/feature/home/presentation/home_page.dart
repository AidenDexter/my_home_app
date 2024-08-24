import 'package:flutter/material.dart';

import '../../../core/extension/src/app_localizations_x.dart';
import '../../../core/resources/assets.gen.dart';
import '../../../core/ui_kit/currency_switcher.dart';
import '../../../core/ui_kit/decorated_container.dart';
import '../../../core/ui_kit/primary_app_bar.dart';
import '../../localization_control/presentation/language_bottom_sheet.dart';
import '../components/flag_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        ignoreLeading: true,
        title: Row(
          children: [
            Assets.icons.logo.svg(),
            const Spacer(),
            CurrencySwitcher(onChange: (_isLariEnabled) {}),
            const SizedBox(width: 12),
            InkWell(
              borderRadius: BorderRadius.circular(6),
              onTap: () {
                LanguageBottomSheet.show(context);
              },
              child: DecoratedContainer(
                borderRadius: BorderRadius.circular(6),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: const FlagCard(),
              ),
            ),
          ],
        ),
      ),
      body: Center(child: Text(context.l10n.search)),
    );
  }
}
