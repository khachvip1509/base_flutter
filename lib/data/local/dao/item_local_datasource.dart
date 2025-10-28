import 'package:hive/hive.dart';

import '../../../domain/model/item.dart';
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

  // xóa theo id, nhưng Hive lại lưu item theo index key, Do đó cần có bước convert
  Future<void> deleteItem(String id) async {
    final box = await Hive.openBox<ItemModel>(boxName);
    final key = box.keys.firstWhere(
          (k) => box.get(k)?.id == id,
      orElse: () => null,
    );
    if (key != null) {
      await box.delete(key);
    }
  }

  Future<void> saveItems(List<ItemModel> items) async {
    final box = await Hive.openBox<ItemModel>(boxName);
    await box.clear();
    await box.addAll(items);
  }
}
