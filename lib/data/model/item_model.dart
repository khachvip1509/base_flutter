import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class ItemModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  ItemModel({required this.id, required this.title});

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      ItemModel(id: json['id'].toString(), title: json['title'] ?? '');
}
