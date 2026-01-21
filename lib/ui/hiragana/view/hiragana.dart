import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/model/hiragana_model.dart';
import '../../../data/model/quiz_stats_model.dart';

class HiraganaPage extends StatefulWidget {
  const HiraganaPage({Key? key}) : super(key: key);

  @override
  State<HiraganaPage> createState() => _HiraganaPageState();
}

class _HiraganaPageState extends State<HiraganaPage>
    with SingleTickerProviderStateMixin {
  final FlutterTts _tts = FlutterTts();
  final TextEditingController _searchController = TextEditingController();
  final Random _random = Random();
  List<Map<String, String>> _list = [];
  List<String> _learnedList = [];
  QuizStats _stats = QuizStats();
  String _searchQuery = "";
  late AnimationController _animController;
  late Animation<Color?> _colorAnimation;
  final List<List<HiraganaItem>> hiraganaGroups = [
    [
      HiraganaItem(kana: 'あ', romaji: 'a', meaning: 'a'),
      HiraganaItem(kana: 'い', romaji: 'i', meaning: 'i'),
      HiraganaItem(kana: 'う', romaji: 'u', meaning: 'u'),
      HiraganaItem(kana: 'え', romaji: 'e', meaning: 'e'),
      HiraganaItem(kana: 'お', romaji: 'o', meaning: 'o'),
    ],
    [
      HiraganaItem(kana: 'か', romaji: 'ka', meaning: 'ka'),
      HiraganaItem(kana: 'き', romaji: 'ki', meaning: 'ki'),
      HiraganaItem(kana: 'く', romaji: 'ku', meaning: 'ku'),
      HiraganaItem(kana: 'け', romaji: 'ke', meaning: 'ke'),
      HiraganaItem(kana: 'こ', romaji: 'ko', meaning: 'ko'),
    ],
    [
      HiraganaItem(kana: 'が', romaji: 'ga', meaning: 'ga'),
      HiraganaItem(kana: 'ぎ', romaji: 'gi', meaning: 'gi'),
      HiraganaItem(kana: 'ぐ', romaji: 'gu', meaning: 'gu'),
      HiraganaItem(kana: 'げ', romaji: 'ge', meaning: 'ge'),
      HiraganaItem(kana: 'ご', romaji: 'go', meaning: 'go'),
    ],
    [
      HiraganaItem(kana: 'きゃ', romaji: 'kya', meaning: 'kya'),
      HiraganaItem(kana: 'きゅ', romaji: 'kyu', meaning: 'kyu'),
      HiraganaItem(kana: 'きょ', romaji: 'kyo', meaning: 'kyo'),
    ],
    [
      HiraganaItem(kana: 'しゃ', romaji: 'sha', meaning: 'sha'),
      HiraganaItem(kana: 'しゅ', romaji: 'shu', meaning: 'shu'),
      HiraganaItem(kana: 'しょ', romaji: 'sho', meaning: 'sho'),
    ],
  ];
  final List<List<HiraganaItem>> katakanaGroups = [
    [
      HiraganaItem(kana: 'ア', romaji: 'a', meaning: 'a'),
      HiraganaItem(kana: 'イ', romaji: 'i', meaning: 'i'),
      HiraganaItem(kana: 'ウ', romaji: 'u', meaning: 'u'),
      HiraganaItem(kana: 'エ', romaji: 'e', meaning: 'e'),
      HiraganaItem(kana: 'オ', romaji: 'o', meaning: 'o'),
    ],
    [
      HiraganaItem(kana: 'カ', romaji: 'ka', meaning: 'ka'),
      HiraganaItem(kana: 'キ', romaji: 'ki', meaning: 'ki'),
      HiraganaItem(kana: 'ク', romaji: 'ku', meaning: 'ku'),
      HiraganaItem(kana: 'ケ', romaji: 'ke', meaning: 'ke'),
      HiraganaItem(kana: 'コ', romaji: 'ko', meaning: 'ko'),
    ],
  ];

  @override
  void initState() {
    super.initState();
    _list = hiraganaGroups
        .expand((g) => g)
        .map(
          (item) => {
            "kana": item.kana,
            "romaji": item.romaji,
            "meaning": item.meaning,
          },
        )
        .toList();
    _loadPrefs();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _colorAnimation = ColorTween(
      begin: Colors.indigo.shade50,
      end: Colors.yellow.shade200,
    ).animate(_animController);
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _learnedList = prefs.getStringList('learned_hiragana') ?? [];
      final savedStats = prefs.getString('quiz_stats');
      if (savedStats != null) {
        _stats = QuizStats.fromJson(jsonDecode(savedStats));
      }
    });
  }

  Future<void> _saveStats() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('quiz_stats', jsonEncode(_stats.toJson()));
  }

  Future<void> _toggleLearned(String kana) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_learnedList.contains(kana)) {
        _learnedList.remove(kana);
      } else {
        _learnedList.add(kana);
      }
    });
    await prefs.setStringList('learned_hiragana', _learnedList);
  }

  Future<void> _speak(String text) async {
    await _tts.setLanguage("ja-JP");
    await _tts.setPitch(1.1);
    _animController.forward(from: 0);
    await _tts.speak(text);
  }

  Future<void> _speakAll() async {
    await _tts.setLanguage("ja-JP");
    for (final item in _list) {
      await _tts.speak(item["kana"]!);
      await Future.delayed(const Duration(milliseconds: 700));
    }
  }

  void _showQuiz() {
    final item = _list[_random.nextInt(_list.length)];
    final options = List.generate(4, (_) {
      return _list[_random.nextInt(_list.length)]["romaji"]!;
    });
    if (!options.contains(item["romaji"])) options[0] = item["romaji"]!;
    options.shuffle();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("🧩 Quiz luyện tập"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(item["kana"]!, style: const TextStyle(fontSize: 60)),
            const SizedBox(height: 20),
            ...options.map(
              (opt) => ElevatedButton(
                onPressed: () async {
                  final correct = opt == item["romaji"];
                  setState(() {
                    _stats.total++;
                    if (correct) _stats.correct++;
                  });
                  await _saveStats();
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        correct
                            ? "✅ Chính xác!"
                            : "❌ Sai rồi (${item['romaji']})",
                      ),
                    ),
                  );
                },
                child: Text(opt),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shuffleList() {
    setState(() {
      _list.shuffle();
    });
  }

  @override
  void dispose() {
    _tts.stop();
    _searchController.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = _list
        .where(
          (item) =>
              item["kana"]!.contains(_searchQuery) ||
              item["romaji"]!.contains(_searchQuery.toLowerCase()),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hiragana Chart"),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _shuffleList),
          IconButton(icon: const Icon(Icons.volume_up), onPressed: _speakAll),
          IconButton(icon: const Icon(Icons.quiz), onPressed: _showQuiz),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              "Đã học: ${_learnedList.length}/${_list.length} | Quiz đúng: ${_stats.correct}/${_stats.total} (${_stats.accuracy.toStringAsFixed(1)}%)",
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Tìm chữ hoặc romaji...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (v) => setState(() => _searchQuery = v),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                final item = filteredList[index];
                final learned = _learnedList.contains(item["kana"]);
                return GestureDetector(
                  onTap: () => _speak(item["kana"]!),
                  onLongPress: () => _toggleLearned(item["kana"]!),
                  child: AnimatedBuilder(
                    animation: _colorAnimation,
                    builder: (_, __) => Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: learned
                            ? Colors.green.shade100
                            : _colorAnimation.value,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: learned
                              ? Colors.green.shade400
                              : Colors.indigo.shade200,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item["kana"]!,
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: learned
                                  ? Colors.green
                                  : Colors.indigo[800],
                            ),
                          ),
                          Text(
                            item["romaji"]!,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
