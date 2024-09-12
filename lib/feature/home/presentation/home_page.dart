import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extension/extensions.dart';
import '../../../core/resources/assets.gen.dart';
import '../../../core/ui_kit/decorated_container.dart';
import '../../../core/ui_kit/error_page.dart';
import '../../../core/ui_kit/primary_app_bar.dart';
import '../../../core/ui_kit/primary_icon_button.dart';
import '../../components/search_unit_card/search_unit_card.dart';
import '../../currency_control/presentation/currency_switcher.dart';
import '../../localization_control/bloc/localization_control_bloc.dart';
import '../../localization_control/presentation/language_bottom_sheet.dart';
import '../../root/presentation/bottom_navigation_scope.dart';
import '../../search/domain/entity/search_response.dart';
import '../bloc/home_bloc.dart';
import '../domain/entity/home_response.dart';
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
        body: BlocListener<LocalizationControlBloc, LocalizationControlState>(
          listener: (context, state) => HomeScope.readOf(context),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) => state.map(
              progress: (_) => const Center(child: CircularProgressIndicator()),
              success: (state) => _DataLayout(state.sections),
              error: (state) => ErrorBody(
                error: state.errorHandler,
                actions: [ElevatedButton(onPressed: () => HomeScope.readOf(context), child: const Text('Try again'))],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DataLayout extends StatelessWidget {
  final List<Sections> sections;
  const _DataLayout(this.sections);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => HomeScope.readOf(context),
      child: ListView(
        children: [
          _SectionTitle(
            icon: Assets.icons.services,
            title: context.l10n.services,
          ),
          const ServicesRow(),
          const SizedBox(height: 8),
          ...sections.map(
            (section) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionTitle(
                  icon: _sectionIconFromType(section.type),
                  title: _sectionNameFromType(section.type),
                ),
                _HorizontalAds(children: section.children),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _sectionNameFromType(String type) {
    if (type == 'super_vip_products') return 'SUPER-VIP';
    if (type == 'vip_plus_products') return 'VIP+';
    return '';
  }

  SvgGenImage _sectionIconFromType(String type) {
    if (type == 'super_vip_products') return Assets.icons.superVipIcon;
    if (type == 'vip_plus_products') return Assets.icons.vipPlusIcon;
    return Assets.icons.filters;
  }
}

class _SectionTitle extends StatelessWidget {
  final SvgGenImage icon;
  final String title;
  const _SectionTitle({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
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
