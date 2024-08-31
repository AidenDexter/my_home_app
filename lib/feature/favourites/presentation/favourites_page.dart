import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extension/src/theme_extension.dart';
import '../../../core/resources/assets.gen.dart';
import '../bloc/favourites_bloc.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      body: BlocBuilder<FavouritesBloc, FavouritesState>(builder: (context, state) {
        if (state.favourites.isEmpty) {
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
        return ListView.separated(
            itemBuilder: (context, index) => Text('${state.favourites[index]}'),
            separatorBuilder: (context, _) => const SizedBox(
                  height: 4,
                ),
            itemCount: state.favourites.length);
      }),
    );
  }
}
