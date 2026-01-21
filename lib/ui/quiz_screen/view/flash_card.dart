import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/utils/app_constants.dart';
import 'package:untitled/utils/styles.dart';

import '../../../data/local/dao/kana_data.dart';

class FlashCardScreen extends StatefulWidget {
  const FlashCardScreen({super.key});

  @override
  State<FlashCardScreen> createState() => _FlashCardScreenState();
}

class _FlashCardScreenState extends State<FlashCardScreen>
    with SingleTickerProviderStateMixin {
  final FlutterTts _tts = FlutterTts();
  late List<Map<String, String>> _cards;
  int _currentIndex = 0;
  double _progress = 0.0;
  bool _isFront = true;
  bool _highlight = false;

  final BorderRadius _cardRadius = BorderRadius.circular(16);

  @override
  void initState() {
    super.initState();
    _cards = allKana;
    _initTts();
    _loadProgress();
  }

  void _initTts() {
    _tts.setLanguage("ja-JP");
    _tts.setSpeechRate(0.5);
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentIndex = prefs.getInt('flashcard_index') ?? 0;
      _progress = (_currentIndex + 1) / _cards.length;
    });
  }

  Future<void> _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('flashcard_index', _currentIndex);
  }

  void _shuffleCards() {
    setState(() {
      _cards.shuffle(Random());
      _currentIndex = 0;
      _progress = 0.0;
    });
  }

  void _nextCard() {
    setState(() {
      if (_currentIndex < _cards.length - 1) {
        _currentIndex++;
        _progress = (_currentIndex + 1) / _cards.length;
        _isFront = true;
      } else {
        _showCompletionDialog();
      }
    });
    _saveProgress();
  }

  void _speak(String text) async {
    setState(() => _highlight = true);
    await _tts.speak(text);
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() => _highlight = false);
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("🎉 Hoàn thành!"),
        content: SizedBox(
          height: 120,
          width: 120,
          child: const RiveAnimation.asset(
            'assets/animations/confetti.riv',
            fit: BoxFit.contain,
            // repeat: true mặc định
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentIndex = 0;
                _progress = 0.0;
              });
              _saveProgress();
            },
            child: const Text("Học lại"),
          ),
        ],
      ),
    );
  }

  void _openQuizScreen() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 800),
        pageBuilder: (_, __, ___) => const QuizScreenFlash(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutBack,
              ),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final card = _cards[_currentIndex];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Flashcards Hiragana & Katakana"),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: _shuffleCards,
            tooltip: "Học ngẫu nhiên",
          ),
          IconButton(
            icon: const Icon(Icons.quiz),
            onPressed: _openQuizScreen,
            tooltip: "Chế độ Quiz",
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          LinearPercentIndicator(
            lineHeight: 8.0,
            percent: _progress,
            progressColor: Colors.indigoAccent,
            backgroundColor: Colors.grey.shade200,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () => setState(() => _isFront = !_isFront),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    borderRadius: _cardRadius,
                    color: _highlight
                        ? Colors.yellow.shade100
                        : Colors.indigo.shade50,
                    boxShadow: [
                      BoxShadow(
                        color: _highlight
                            ? Colors.amberAccent
                            : Colors.indigo.shade100,
                        blurRadius: _highlight ? 25 : 10,
                        spreadRadius: _highlight ? 8 : 2,
                      ),
                    ],
                  ),
                  height: 280,
                  width: 230,
                  alignment: Alignment.center,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    transitionBuilder: (child, animation) =>
                        ScaleTransition(scale: animation, child: child),
                    child: _isFront
                        ? Text(
                            card['kana']!,
                            key: const ValueKey(true),
                            style: GoogleFonts.notoSansJavanese(
                              fontSize: 100,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigoAccent,
                            ),
                          )
                        : Column(
                            key: const ValueKey(false),
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                card['romaji']!,
                                style: GoogleFonts.poppins(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrange,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                card['meaning']!,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.volume_up,
                  size: 40,
                  color: Colors.indigoAccent,
                ),
                onPressed: () => _speak(card['kana']!),
              ),
              ElevatedButton(
                onPressed: _nextCard,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.orangeFFD09D,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 14,
                  ),
                ),
                child: const Text("Tiếp theo", style: normalStyle),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// QuizMode dùng Rive
class QuizScreenFlash extends StatelessWidget {
  const QuizScreenFlash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Quiz Mode"),
        backgroundColor: Colors.indigoAccent,
      ),
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: const RiveAnimation.asset(
            'assets/animations/quiz.riv',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
