import '../model/item.dart';
import '../repository/item_repository.dart';

class UpdateListItemUseCase  {
  final ItemRepository repository;

  UpdateListItemUseCase(this.repository);

  Future<List<Item>> call() async {
    return await repository.getLocalItems();
  }
}
