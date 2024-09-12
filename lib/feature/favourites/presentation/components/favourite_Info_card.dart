import 'package:flutter/material.dart';
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
    if (widget.item.item == null) {
      return Skeleton.rect(
        width: double.infinity,
        height: 400,
        borderRadius: BorderRadius.circular(16),
      );
    }
    return SearchUnitCard(widget.item.item!);
  }
}
