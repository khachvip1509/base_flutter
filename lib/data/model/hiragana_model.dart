import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class HiraganaItem extends HiveObject{

  @HiveField(0)
  final String kana;

  @HiveField(1)
  final String romaji;

  @HiveField(2)
  final String meaning;

  HiraganaItem({required this.kana, required this.romaji, required this.meaning});
  factory HiraganaItem.fromJson(Map<String, dynamic> json) =>
      HiraganaItem(kana: json['kana'].toString(), romaji: json['romaji'].toString(), meaning: json['meaning'] ?? '');
}
