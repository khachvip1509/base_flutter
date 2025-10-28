// GENERATED MANUAL ADAPTER
import 'package:hive/hive.dart';

import 'item_model.dart';

class ItemModelAdapter extends TypeAdapter<ItemModel> {
  @override
  final int typeId = 0;

  @override
  ItemModel read(BinaryReader reader) {
    final id = reader.readString();
    final title = reader.readString();
    return ItemModel(id: id, title: title);
  }

  @override
  void write(BinaryWriter writer, ItemModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
  }
}
