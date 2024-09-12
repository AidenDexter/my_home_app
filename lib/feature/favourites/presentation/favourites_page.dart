import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extension/src/theme_extension.dart';
import '../../../core/resources/assets.gen.dart';
import '../../../core/ui_kit/primary_app_bar.dart';
import '../bloc/favourites_bloc.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(
        title: Text('Избранное'),
      ),
      body: BlocBuilder<FavouritesBloc, FavouritesState>(builder: (context, state) {
        if (state.favourites.isEmpty) {
          return const _EmptyLayout();
        }
        return _DataLayout(state.favourites);
      }),
    );
  }
}

class _DataLayout extends StatelessWidget {
  final List<int> favourites;
  const _DataLayout(this.favourites);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, index) => Text('${favourites[index]}'),
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
              'Сохраняйте понравившиеся объявления',
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
