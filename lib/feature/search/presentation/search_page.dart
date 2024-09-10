import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extension/extensions.dart';
import '../../../core/resources/assets.gen.dart';
import '../../../core/ui_kit/error_page.dart';
import '../../../core/ui_kit/primary_app_bar.dart';
import '../../components/search_unit_card/search_unit_card.dart';
import '../../localization_control/bloc/localization_control_bloc.dart';
import '../bloc/search_bloc.dart';
import '../domain/entity/deal_type.dart';
import '../domain/entity/real_estate_type.dart';
import '../domain/entity/rooms.dart';
import 'components/search_form.dart';
import 'search_scope.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) => const SearchScope(child: _Body());
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  // Filters
  late final ValueNotifier<DealType?> _dealType;
  late final ValueNotifier<List<RealEstateType>> _realEstateTypes;
  late final ValueNotifier<int?> _selectedCity;
  late final ValueNotifier<List<int>> _selectedDistricts;
  late final ValueNotifier<List<int>> _selectedUrbans;
  late final TextEditingController _searchController;
  late final TextEditingController _priceFromController;
  late final TextEditingController _priceToController;
  late final TextEditingController _areaFromController;
  late final TextEditingController _areaToController;
  late final TextEditingController _floorFromController;
  late final TextEditingController _floorToController;
  late final ValueNotifier<bool> _notFirstFloorController;
  late final ValueNotifier<bool> _notLastFloorController;
  late final ValueNotifier<bool> _isLastFloorController;
  late final ValueNotifier<List<Rooms>> _roomsController;

  // Page controllers
  late final ScrollController _scrollController;
  late final ValueNotifier<bool> _isShowsUpButton;

  @override
  void initState() {
    _dealType = ValueNotifier(null);
    _realEstateTypes = ValueNotifier([]);
    _selectedCity = ValueNotifier(null);
    _selectedDistricts = ValueNotifier([]);
    _selectedUrbans = ValueNotifier([]);
    _searchController = TextEditingController();
    _priceFromController = TextEditingController();
    _priceToController = TextEditingController();
    _areaFromController = TextEditingController();
    _areaToController = TextEditingController();
    _floorFromController = TextEditingController();
    _floorToController = TextEditingController();
    _notFirstFloorController = ValueNotifier(false);
    _notLastFloorController = ValueNotifier(false);
    _isLastFloorController = ValueNotifier(false);
    _roomsController = ValueNotifier([]);

    _isShowsUpButton = ValueNotifier(false);
    _scrollController = ScrollController()
      ..addListener(() {
        _isShowsUpButton.value = _scrollController.offset > 900;
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      appBar: PrimaryAppBar(
        title: Text(context.l10n.search_ads),
        ignoreLeading: true,
      ),
      floatingActionButton: AnimatedBuilder(
        animation: _isShowsUpButton,
        builder: (context, child) {
          if (!_isShowsUpButton.value) return const SizedBox.shrink();
          return SafeArea(child: child!);
        },
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomPadding - 32),
          child: FloatingActionButton.small(
            onPressed: () => _scrollController.animateTo(
              0,
              duration: context.theme.durations.pageElements,
              curve: Curves.easeInOut,
            ),
            child: const Icon(Icons.keyboard_double_arrow_up_rounded),
          ),
        ).animate().scale(curve: Curves.bounceOut),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Builder(builder: (context) {
          return RefreshIndicator(
            onRefresh: () async => _search(),
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: SearchForm(
                    dealType: _dealType,
                    realEstateTypes: _realEstateTypes,
                    selectedCity: _selectedCity,
                    selectedDistricts: _selectedDistricts,
                    selectedUrbans: _selectedUrbans,
                    search: _search,
                    searchController: _searchController,
                    priceFromController: _priceFromController,
                    priceToController: _priceToController,
                    areaFromController: _areaFromController,
                    areaToController: _areaToController,
                    floorFromController: _floorFromController,
                    floorToController: _floorToController,
                    notFirstFloorController: _notFirstFloorController,
                    notLastFloorController: _notLastFloorController,
                    isLastFloorController: _isLastFloorController,
                    roomsController: _roomsController,
                  ),
                ),
                BlocListener<LocalizationControlBloc, LocalizationControlState>(
                  listener: (context, state) => _search(),
                  child: BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) => state.maybeMap(
                      initProgress: (value) => const SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      error: (value) => SliverToBoxAdapter(
                        child: SizedBox(
                          height: 400,
                          width: double.infinity,
                          child: ErrorBody(
                            error: value.errorHandler,
                            actions: [
                              ElevatedButton(
                                onPressed: _search,
                                child: const Text('try_again'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      orElse: () {
                        if (state.items.isEmpty) return const SliverToBoxAdapter(child: _EmptySearchResult());
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final child = SearchUnitCard(state.items[index]);

                              if (index == state.items.length - 1) {
                                SearchScope.loadMore(context);
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    child,
                                    if (SearchScope.isLoadingMore(context)) ...[
                                      const SizedBox(height: 8),
                                      const Center(child: CircularProgressIndicator()),
                                    ],
                                    const SizedBox(height: 80),
                                  ],
                                );
                              }

                              return child;
                            },
                            childCount: state.items.length,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  void _search() => SearchScope.search(
        context,
        cityId: _selectedCity.value,
        dealType: _dealType.value?.id,
        urbans: _selectedUrbans.value,
        districts: _selectedDistricts.value,
        realEstateTypes: _realEstateTypes.value.map((e) => e.id).toList(),
        searchText: _searchController.text.trim(),
        priceFrom: _priceFromController.text,
        priceTo: _priceToController.text,
        areaFrom: _areaFromController.text,
        areaTo: _areaToController.text,
        floorFrom: _floorFromController.text,
        floorTo: _floorToController.text,
        notFirstFloor: _notFirstFloorController.value,
        notLastFloor: _notLastFloorController.value,
        isLastFloor: _isLastFloorController.value,
        rooms: _roomsController.value.map((e) => e.id).toList(),
      );

  @override
  void dispose() {
    _dealType.dispose();
    _realEstateTypes.dispose();
    _selectedCity.dispose();
    _selectedDistricts.dispose();
    _selectedUrbans.dispose();
    _searchController.dispose();
    _priceFromController.dispose();
    _priceToController.dispose();
    _areaFromController.dispose();
    _areaToController.dispose();
    _floorFromController.dispose();
    _floorToController.dispose();
    _notFirstFloorController.dispose();
    _notLastFloorController.dispose();
    _isLastFloorController.dispose();

    _scrollController.dispose();
    super.dispose();
  }
}

class _EmptySearchResult extends StatelessWidget {
  const _EmptySearchResult();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        Assets.icons.emptySearch.svg(),
        const SizedBox(height: 32),
        const Text('Свойства не найдены'),
        const SizedBox(height: 12),
        const Text('Не найдено свойств по указанным критериям'),
      ],
    );
  }
}
