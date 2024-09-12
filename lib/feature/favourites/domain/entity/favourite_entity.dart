import '../../../search/domain/entity/search_response.dart';

class FavouriteEntity {
  final int id;
  final SearchItem? item;

  const FavouriteEntity({required this.id, required this.item});

  factory FavouriteEntity.fromString(String id) {
    final itemId = int.parse(id);
    return FavouriteEntity(id: itemId, item: null);
  }
}
