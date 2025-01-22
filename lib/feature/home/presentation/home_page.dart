import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/error/error_handler.dart';
import '../../../core/extension/extensions.dart';
import '../../../core/resources/assets.gen.dart';
import '../../../core/ui_kit/decorated_container.dart';
import '../../../core/ui_kit/error_page.dart';
import '../../../core/ui_kit/primary_app_bar.dart';
import '../../../core/ui_kit/primary_icon_button.dart';
import '../../../core/ui_kit/primary_refresh_indicator.dart';
import '../../../core/ui_kit/skeleton.dart';
import '../../components/search_unit_card/search_unit_card.dart';
import '../../currency_control/presentation/currency_switcher.dart';
import '../../localization_control/presentation/language_bottom_sheet.dart';
import '../../root/presentation/bottom_navigation_scope.dart';
import '../../search/domain/entity/search_response.dart';
import '../bloc/home_super_vip.dart';
import '../bloc/home_vip_plus.dart';
import 'components/flag_card.dart';
import 'components/services_row.dart';
import 'home_scope.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeScope(
      child: Scaffold(
        appBar: PrimaryAppBar(
          ignoreLeading: true,
          title: Row(
            children: [
              Assets.icons.logo.svg(),
              const Spacer(),
              const CurrencySwitcher(),
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
              const SizedBox(width: 6),
              PrimaryIconButton(
                icon: Assets.icons.search.svg(height: 22),
                onTap: () => BottomNavigationScope.change(context, 1),
              ),
              const SizedBox(width: 6),
              PrimaryIconButton(
                icon: Assets.icons.notifications.svg(height: 22),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: const _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return PrimaryRefreshIndicator(
      onRefresh: () async => HomeScope.readOf(context),
      child: ListView(
        children: [
          _SectionTitle(
            icon: Assets.icons.services,
            title: context.l10n.services,
          ),
          const ServicesRow(),
          const SizedBox(height: 8),
          _SectionTitle(
            icon: Assets.icons.superVipIcon,
            title: 'SUPER-VIP',
          ),
          BlocBuilder<HomeSuperVipBloc, HomeSuperVipState>(
            builder: (context, state) => state.map(
              progress: (_) => const _ProgressLayout(),
              success: (state) => _HorizontalAds(children: state.items),
              error: (state) => _ErrorLayout(state.errorHandler, () => HomeScope.readSuperVipOf(context)),
            ),
          ),
          _SectionTitle(
            icon: Assets.icons.vipPlusIcon,
            title: 'VIP+',
          ),
          BlocBuilder<HomeVipPlusBloc, HomeVipPlusState>(
            builder: (context, state) => state.map(
              progress: (_) => const _ProgressLayout(),
              success: (state) => _HorizontalAds(children: state.items),
              error: (state) => _ErrorLayout(state.errorHandler, () => HomeScope.readVipPlusOf(context)),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final SvgGenImage icon;
  final String title;
  const _SectionTitle({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text.rich(
          TextSpan(
            children: [
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: icon.svg(height: 24),
                ),
                alignment: PlaceholderAlignment.middle,
              ),
              TextSpan(
                text: title,
                style: context.theme.commonTextStyles.headline2,
              ),
            ],
          ),
        ),
      );
}

class _HorizontalAds extends StatelessWidget {
  const _HorizontalAds({
    required this.children,
  });

  final List<SearchItem> children;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: 435,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => SizedBox(
          width: width * .75,
          child: SearchUnitCard(children[index], maxTextLines: 1),
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemCount: children.length,
      ),
    );
  }
}

class _ProgressLayout extends StatelessWidget {
  const _ProgressLayout();

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 400,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Skeleton.rect(
            width: 290,
            height: 400,
            borderRadius: BorderRadius.circular(16),
          ),
          itemCount: 4,
          separatorBuilder: (context, index) => const SizedBox(width: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
      );
}

class _ErrorLayout extends StatelessWidget {
  final IErrorHandler error;
  final VoidCallback tryAgain;
  const _ErrorLayout(
    this.error,
    this.tryAgain,
  );

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DecoratedContainer(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          child: SizedBox(
            height: 400,
            child: ErrorBody(
              error: error,
              actions: [
                ElevatedButton(
                  onPressed: tryAgain,
                  child: Text(context.l10n.try_again),
                ),
              ],
            ),
          ),
        ),
      );
}
