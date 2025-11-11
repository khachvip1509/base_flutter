// kana_data.dart

final List<Map<String, String>> hiraganaList = [
  {'kana': 'あ', 'romaji': 'a', 'meaning': 'Hiragana A'},
  {'kana': 'い', 'romaji': 'i', 'meaning': 'Hiragana I'},
  {'kana': 'う', 'romaji': 'u', 'meaning': 'Hiragana U'},
  {'kana': 'え', 'romaji': 'e', 'meaning': 'Hiragana E'},
  {'kana': 'お', 'romaji': 'o', 'meaning': 'Hiragana O'},
  {'kana': 'か', 'romaji': 'ka', 'meaning': 'Hiragana Ka'},
  {'kana': 'き', 'romaji': 'ki', 'meaning': 'Hiragana Ki'},
  {'kana': 'く', 'romaji': 'ku', 'meaning': 'Hiragana Ku'},
  {'kana': 'け', 'romaji': 'ke', 'meaning': 'Hiragana Ke'},
  {'kana': 'こ', 'romaji': 'ko', 'meaning': 'Hiragana Ko'},
];

final List<Map<String, String>> katakanaList = [
  {'kana': 'ア', 'romaji': 'a', 'meaning': 'Katakana A'},
  {'kana': 'イ', 'romaji': 'i', 'meaning': 'Katakana I'},
  {'kana': 'ウ', 'romaji': 'u', 'meaning': 'Katakana U'},
  {'kana': 'エ', 'romaji': 'e', 'meaning': 'Katakana E'},
  {'kana': 'オ', 'romaji': 'o', 'meaning': 'Katakana O'},
  {'kana': 'カ', 'romaji': 'ka', 'meaning': 'Katakana Ka'},
  {'kana': 'キ', 'romaji': 'ki', 'meaning': 'Katakana Ki'},
  {'kana': 'ク', 'romaji': 'ku', 'meaning': 'Katakana Ku'},
  {'kana': 'ケ', 'romaji': 'ke', 'meaning': 'Katakana Ke'},
  {'kana': 'コ', 'romaji': 'ko', 'meaning': 'Katakana Ko'},
];

/// Kết hợp tất cả
List<Map<String, String>> get allKana => [...hiraganaList, ...katakanaList];
