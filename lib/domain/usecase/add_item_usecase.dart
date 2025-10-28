import '../model/item.dart';
import '../repository/item_repository.dart';

class AddItemUseCase {
  final ItemRepository repository;

  AddItemUseCase(this.repository);

  Future<void> call(Item item) async {
    await repository.addLocalItem(item);
  }
}
