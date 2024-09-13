import '../../../search/domain/entity/search_response.dart';

class FavouriteEntity {
  final int id;
  final SearchItem? item;
  final LoadingStatus status;

  const FavouriteEntity({required this.id, required this.item, this.status = LoadingStatus.loading});

  factory FavouriteEntity.fromString(String id) {
    final itemId = int.parse(id);
    return FavouriteEntity(id: itemId, item: null);
  }
}

enum LoadingStatus { loading, success, error }
