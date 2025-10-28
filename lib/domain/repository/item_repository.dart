import '../model/item.dart';

abstract class ItemRepository {
  Future<List<Item>> fetchRemoteItems();

  Future<List<Item>> getLocalItems();

  Future<List<Item>> getItems();

  Future<void> addLocalItem(Item item);

  Future<void> deleteLocalItem(String id);
}
