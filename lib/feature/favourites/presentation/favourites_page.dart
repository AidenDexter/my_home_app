// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extension/extensions.dart';
import '../../../core/resources/assets.gen.dart';
import '../../../core/ui_kit/primary_app_bar.dart';
import '../bloc/favourites_bloc.dart';
import '../domain/entity/favourite_entity.dart';
import 'components/favourite_Info_card.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  // Page controllers
  late final ScrollController _scrollController;
  late final ValueNotifier<bool> _isShowsUpButton;

  @override
  void initState() {
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
        ignoreLeading: true,
        title: Text(context.l10n.favourites),
      ),
      body: BlocBuilder<FavouritesBloc, FavouritesState>(builder: (context, state) {
        if (state.favourites.isEmpty) {
          return const _EmptyLayout();
        }
        return _DataLayout(
          favourites: state.favourites,
          bottomPadding: bottomPadding,
          controller: _scrollController,
        );
      }),
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
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class _DataLayout extends StatelessWidget {
  final ScrollController? controller;
  final double bottomPadding;
  final List<FavouriteEntity> favourites;
  const _DataLayout({
    required this.controller,
    required this.bottomPadding,
    required this.favourites,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: controller,
      padding: EdgeInsets.only(right: 16, left: 16, bottom: bottomPadding),
      itemBuilder: (_, index) => FavouriteInfoCard(
        key: ValueKey(favourites[index]),
        item: favourites[index],
      ),
      separatorBuilder: (_, __) => const SizedBox(height: 4),
      itemCount: favourites.length,
    );
  }
}

class _EmptyLayout extends StatelessWidget {
  const _EmptyLayout();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Assets.icons.emptyFavourites.svg(),
          ),
          Padding(
            padding: const EdgeInsets.all(50),
            child: Text(
              context.l10n.save_to_favorites,
              textAlign: TextAlign.center,
              style: context.theme.commonTextStyles.headline3.copyWith(
                color: context.theme.commonColors.green100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
