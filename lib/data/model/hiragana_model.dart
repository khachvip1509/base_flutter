import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class HiraganaItem extends HiveObject{

  @HiveField(0)
  final String kana;

  @HiveField(1)
  final String meaning;

  HiraganaItem({required this.kana, required this.meaning});
  factory HiraganaItem.fromJson(Map<String, dynamic> json) =>
      HiraganaItem(kana: json['kana'].toString(), meaning: json['meaning'] ?? '');
}
