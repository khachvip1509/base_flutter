import '../model/item.dart';
import '../repository/item_repository.dart';

class DeleteItemUseCase {
  final ItemRepository repository;

  DeleteItemUseCase(this.repository);

  Future<void> call(Item item) async {
    await repository.deleteLocalItem(item.id);
  }
}
