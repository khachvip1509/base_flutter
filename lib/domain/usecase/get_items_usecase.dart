import '../model/item.dart';
import '../repository/item_repository.dart';

class GetItemsUseCase {
  final ItemRepository repository;

  GetItemsUseCase(this.repository);

  Future<List<Item>> call() async {
    return await repository.fetchRemoteItems();
  }
}
