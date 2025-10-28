import 'package:hive/hive.dart';

import '../../model/item_model.dart';

class ItemLocalDataSource {
  static const String boxName = 'itemsBox';

  Future<void> addItem(ItemModel item) async {
    final box = await Hive.openBox<ItemModel>(boxName);
    await box.put(item.id, item);
  }

  Future<List<ItemModel>> getAllItems() async {
    final box = await Hive.openBox<ItemModel>(boxName);
    return box.values.toList();
  }

  Future<void> deleteItem(String id) async {
    final box = await Hive.openBox<ItemModel>(boxName);
    await box.delete(id);
  }
}
