import 'package:flutter/material.dart';
import '../../../../core/extension/extensions.dart';
import '../../../../core/ui_kit/primary_elevated_button.dart';
import '../../../../core/ui_kit/skeleton.dart';
import '../../../components/search_unit_card/search_unit_card.dart';
import '../../domain/entity/favourite_entity.dart';
import '../favourites_scope.dart';

class FavouriteInfoCard extends StatefulWidget {
  final FavouriteEntity item;
  const FavouriteInfoCard({
    required this.item,
    super.key,
  });

  @override
  State<FavouriteInfoCard> createState() => _FavouriteInfoCardState();
}

class _FavouriteInfoCardState extends State<FavouriteInfoCard> {
  @override
  void initState() {
    FavouritesScope.fetchItem(context, id: widget.item.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.commonColors;
    switch (widget.item.status) {
      case LoadingStatus.success:
        return SearchUnitCard(widget.item.item!);
      case LoadingStatus.loading:
        return Skeleton.rect(
          width: double.infinity,
          height: 400,
          borderRadius: BorderRadius.circular(16),
        );
      case LoadingStatus.error:
        return DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: colors.neutralgrey10),
            color: colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 214,
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(color: colors.neutralgrey10),
                      color: colors.neutralgrey10,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: colors.white,
                        size: 80,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text('Ошибка', style: context.theme.commonTextStyles.headline2),
                      const SizedBox(height: 2),
                      Text(
                        'Что-то пошло не так,\nпожалуйста повторите запрос',
                        textAlign: TextAlign.center,
                        style: context.theme.commonTextStyles.label.copyWith(
                          color: colors.darkGrey30,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => FavouritesScope.fetchItem(context, id: widget.item.id),
                        child: const Text('Попробовать еще раз'),
                      ),
                      const SizedBox(height: 8),
                      PrimaryElevatedButton.secondary(
                        onPressed: () => FavouritesScope.remove(context, id: widget.item.id),
                        child: const Text('Удалить из избранного'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
    }
  }
}
