import 'package:flutter/material.dart';

import '../../../core/extension/extensions.dart';
import '../../../core/resources/assets.gen.dart';
import '../../../core/services/package_info/i_package_info_service.dart';
import '../../../core/services/service_locator/service_locator.dart';
import '../../../core/ui_kit/primary_app_bar.dart';
import '../../../core/ui_kit/primary_elevated_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        title: Text(context.l10n.profile),
        ignoreLeading: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          DefaultTextStyle(
            style: context.theme.commonTextStyles.label.copyWith(
              color: context.theme.commonColors.darkGrey30,
              fontSize: 12,
            ),
            child: Container(
              color: context.theme.commonColors.neutralgrey5,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: context.theme.commonColors.white,
                        child: Icon(
                          Icons.person_outline_rounded,
                          color: context.theme.commonColors.darkGrey30,
                          size: 40,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10n.authorization,
                            style: context.theme.commonTextStyles.headline2,
                          ),
                          Text(context.l10n.dont_have_account),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(context.l10n.access_all_functions),
                  const SizedBox(height: 16),
                  PrimaryElevatedButton.secondary(
                    backgroundColor: context.theme.commonColors.white,
                    child: Text(context.l10n.log_in),
                    onPressed: () {},
                  ),
                  const SizedBox(height: 8),
                  PrimaryElevatedButton(
                    child: Text(context.l10n.create_account),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          DefaultTextStyle(
            style: context.theme.commonTextStyles.body1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Ink(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.theme.commonColors.white,
                  boxShadow: [BoxShadow(blurRadius: 10, color: context.theme.commonColors.neutralgrey10)],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {},
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      title: Text(
                        context.l10n.contacts,
                        style: context.theme.commonTextStyles.title3.copyWith(
                          color: context.theme.commonColors.darkGrey30,
                        ),
                      ),
                      leading: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Assets.icons.contacts.svg(),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                          color: context.theme.commonColors.darkGrey30,
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    Divider(color: context.theme.commonColors.neutralgrey10, height: 8),
                    ListTile(
                      onTap: () {},
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      title: Text(
                        context.l10n.help,
                        style: context.theme.commonTextStyles.title3.copyWith(
                          color: context.theme.commonColors.darkGrey30,
                        ),
                      ),
                      leading: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Assets.icons.help.svg(),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                          color: context.theme.commonColors.darkGrey30,
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    Divider(color: context.theme.commonColors.neutralgrey10, height: 8),
                    ListTile(
                      onTap: () {},
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      title: Text(
                        context.l10n.settings,
                        style: context.theme.commonTextStyles.title3.copyWith(
                          color: context.theme.commonColors.darkGrey30,
                        ),
                      ),
                      leading: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Assets.icons.settings.svg(),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                          color: context.theme.commonColors.darkGrey30,
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                    Divider(color: context.theme.commonColors.neutralgrey10, height: 8),
                    ListTile(
                      onTap: () {},
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      title: Text(
                        context.l10n.about_app,
                        style: context.theme.commonTextStyles.title3.copyWith(
                          color: context.theme.commonColors.darkGrey30,
                        ),
                      ),
                      leading: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Assets.icons.about.svg(),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                          color: context.theme.commonColors.darkGrey30,
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Text(
            context.l10n.app_version(getIt<IPackageInfoService>().version),
            textAlign: TextAlign.center,
            style: context.theme.commonTextStyles.label.copyWith(
              color: context.theme.commonColors.darkGrey30,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
