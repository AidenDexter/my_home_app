import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extension/extensions.dart';
import '../../../core/resources/assets.gen.dart';
import '../../../core/ui_kit/currency_switcher.dart';
import '../../../core/ui_kit/error_page.dart';
import '../../../core/ui_kit/primary_app_bar.dart';
import '../../components/search_unit_card/search_unit_card.dart';
import '../bloc/search_bloc.dart';
import '../domain/entity/deal_type.dart';
import '../domain/entity/real_estate_type.dart';
import '../domain/entity/search_response.dart';
import 'components/search_form.dart';
import 'search_scope.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final ValueNotifier<DealType?> _dealType;
  late final ValueNotifier<List<RealEstateType>> _realEstateTypes;
  late final ValueNotifier<int?> _selectedCity;
  late final ValueNotifier<List<int>> _selectedDisctricts;
  late final ValueNotifier<List<int>> _selectedUrbans;

  @override
  void initState() {
    _dealType = ValueNotifier(null);
    _realEstateTypes = ValueNotifier([]);
    _selectedCity = ValueNotifier(null);
    _selectedDisctricts = ValueNotifier([]);
    _selectedUrbans = ValueNotifier([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SearchScope(
      child: Scaffold(
        appBar: const PrimaryAppBar(
          title: Text('Поиск объявлений'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Builder(builder: (context) {
            return RefreshIndicator(
              onRefresh: () async => SearchScope.search(context),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: SearchForm(
                      dealType: _dealType,
                      realEstateTypes: _realEstateTypes,
                      selectedCity: _selectedCity,
                      selectedDisctricts: _selectedDisctricts,
                      selectedUrbans: _selectedUrbans,
                    ),
                  ),
                  BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) => state.maybeMap(
                      initProgress: (value) => const SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      error: (value) => SliverToBoxAdapter(
                        child: ErrorBody(
                          error: value.errorHandler,
                          actions: [
                            ElevatedButton(
                              onPressed: () => SearchScope.search(context),
                              child: const Text('try_again'),
                            ),
                          ],
                        ),
                      ),
                      orElse: () => SliverList(
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
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _dealType.dispose();
    _realEstateTypes.dispose();
    _selectedCity.dispose();
    _selectedDisctricts.dispose();
    _selectedUrbans.dispose();
    super.dispose();
  }
}
