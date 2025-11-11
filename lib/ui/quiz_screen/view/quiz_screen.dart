import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/utils/app_constants.dart';

import '../../../data/model/quiz_history.dart';
import '../../../data/model/quiz_model.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<QuizModel> allQuizzes = [];
  List<QuizModel> filtered = [];
  int current = 0;
  int? selectedIndex;
  bool showAnswer = false;
  final player = AudioPlayer();
  late ConfettiController confettiController;

  final List<String> selectedCategories = [];
  int quizCount = 10;

  int correctAnswers = 0;

  List<QuizHistory> historyList = [];

  // --- Pagination variables
  final ScrollController _scrollController = ScrollController();
  final int _pageSize = 20;
  bool _isLoadingMore = false;
  List<QuizHistory> _displayedHistory = [];

  @override
  void initState() {
    super.initState();
    confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
    loadData();
    loadHistory();
  }

  @override
  void dispose() {
    player.dispose();
    confettiController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> loadData() async {
    allQuizzes = await QuizModel.loadFromAssets();
    if (!mounted) return;
    setState(() {});
  }

  Future<void> loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonStr = prefs.getString('quiz_history');
    if (jsonStr != null) {
      final List<dynamic> jsonList = json.decode(jsonStr);
      historyList = jsonList.map((e) => QuizHistory.fromJson(e)).toList();
    }
    _initPagination();
  }

  Future<void> saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String jsonStr = json.encode(
      historyList.map((e) => e.toJson()).toList(),
    );
    await prefs.setString('quiz_history', jsonStr);
  }

  void startQuiz() {
    final filteredData = allQuizzes
        .where((q) => selectedCategories.contains(q.category))
        .toList();
    filteredData.shuffle();
    filtered = filteredData.take(quizCount).toList();
    current = 0;
    selectedIndex = null;
    showAnswer = false;
    correctAnswers = 0;
    if (!mounted) return;
    setState(() {});
  }

  void checkAnswer() async {
    if (selectedIndex == null) return;
    final isCorrect = selectedIndex == filtered[current].answerIndex;

    if (isCorrect) correctAnswers++;

    await player.play(
      AssetSource(isCorrect ? 'sounds/correct.mp3' : 'sounds/wrong.mp3'),
    );

    if (!mounted) return;
    setState(() {
      showAnswer = true;
    });

    if (isCorrect) confettiController.play();

    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      nextQuestion();
    });
  }

  void nextQuestion() {
    if (current < filtered.length - 1) {
      if (!mounted) return;
      setState(() {
        current++;
        selectedIndex = null;
        showAnswer = false;
      });
    } else {
      showCompletionDialog();
    }
  }

  void showCompletionDialog() async {
    if (!mounted) return;

    final total = filtered.length;
    final correct = correctAnswers;

    // --- Lưu lịch sử trước khi reset
    final newHistory = QuizHistory(
      date: DateTime.now(),
      total: total,
      correct: correct,
    );
    historyList.insert(0, newHistory);
    _displayedHistory.insert(0, newHistory);
    await saveHistory();

    // Reset trạng thái quiz
    setState(() {
      filtered = [];
      current = 0;
      selectedIndex = null;
      showAnswer = false;
    });

    // Mở dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Hoàn thành!"),
        content: Text("Bạn trả lời đúng $correct/$total câu!"),
        actions: [
          TextButton(
            onPressed: () {
              if (!mounted) return;
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  // --- Pagination methods
  void _initPagination() {
    _displayedHistory = historyList.length > _pageSize
        ? historyList.sublist(0, _pageSize)
        : List.from(historyList);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          !_isLoadingMore &&
          _displayedHistory.length < historyList.length) {
        _loadMore();
      }
    });
    setState(() {});
  }

  void _loadMore() async {
    _isLoadingMore = true;
    setState(() {});

    await Future.delayed(const Duration(seconds: 1)); // giả lập load

    final nextCount =
        (_displayedHistory.length + _pageSize) > historyList.length
        ? historyList.length - _displayedHistory.length
        : _pageSize;

    _displayedHistory.addAll(
      historyList.sublist(
        _displayedHistory.length,
        _displayedHistory.length + nextCount,
      ),
    );

    _isLoadingMore = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (allQuizzes.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Màn hình chọn category + số câu
    if (filtered.isEmpty) {
      final categories = allQuizzes.map((e) => e.category).toSet().toList();
      return Scaffold(
        appBar: AppBar(title: const Text("Chọn chế độ quiz")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  left: 0,
                  top: 16,
                  right: 0,
                  bottom: 16,
                ),
                // padding quanh Wrap
                decoration: BoxDecoration(
                  color: AppColors.green009438, // màu nền bạn muốn
                  borderRadius: BorderRadius.circular(12), // bo góc
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Wrap(
                  spacing: 10,
                  alignment: WrapAlignment.spaceEvenly,
                  // quan trọng: cách đều 2 bên
                  children: categories.map((c) {
                    final isSel = selectedCategories.contains(c);
                    return FilterChip(
                      label: Text(c),
                      selected: isSel,
                      onSelected: (v) {
                        if (!mounted) return;
                        setState(() {
                          v
                              ? selectedCategories.add(c)
                              : selectedCategories.remove(c);
                        });
                      },
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 20),
              Row(
                children: [
                  const Text("Số câu hỏi:"),
                  const SizedBox(width: 10),
                  Text(
                    quizCount.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Expanded(
                    child: Slider(
                      min: 5,
                      max: 50,
                      divisions: 9,
                      value: quizCount.toDouble(),
                      label: quizCount.toString(),
                      onChanged: (v) {
                        if (!mounted) return;
                        setState(() => quizCount = v.toInt());
                      },
                    ),
                  ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: selectedCategories.isEmpty ? null : startQuiz,
                icon: const Icon(Icons.play_arrow),
                label: const Text("Bắt đầu"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ).animate().scale(duration: 500.ms).fadeIn(),
              const SizedBox(height: 20),
              if (_displayedHistory.isNotEmpty)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.remove('quiz_history');
                          historyList.clear();
                          _displayedHistory.clear();
                          if (!mounted) return;
                          setState(() {}); // <-- gọi setState luôn khi mounted
                        },
                        icon: const Icon(
                          Icons.delete_forever,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Xóa lịch sử",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.green00B6C0,
                        ),
                      ),

                      const SizedBox(height: 10),
                      Expanded(
                        child: Scrollbar(
                          thumbVisibility: true,
                          controller: _scrollController,
                          child: ListView.separated(
                            controller: _scrollController,
                            itemCount: _displayedHistory.length + 1,
                            separatorBuilder: (context, index) => Center(
                              child: Container(
                                width: 80,
                                height: 1,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.grey,
                                      width: 1,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            itemBuilder: (context, index) {
                              if (index == _displayedHistory.length) {
                                return _isLoadingMore
                                    ? const Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      )
                                    : const SizedBox.shrink();
                              }

                              final h = _displayedHistory[index];
                              final formattedDate = DateFormat(
                                'dd/MM/yyyy HH:mm',
                              ).format(h.date);

                              return Container(
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 24,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${index + 1}.",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Đúng ${h.correct}/${h.total} câu",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text("Thời gian: $formattedDate"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      );
    }

    // Màn hình quiz
    final quiz = filtered[current];
    return Scaffold(
      appBar: AppBar(
        title: Text("Câu ${current + 1}/${filtered.length} - ${quiz.category}"),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  quiz.question,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ).animate().fadeIn(duration: 400.ms).slide(),
                const SizedBox(height: 20),
                ...List.generate(quiz.options.length, (i) {
                  final opt = quiz.options[i];
                  Color color = Colors.white;
                  if (showAnswer) {
                    if (i == quiz.answerIndex)
                      color = Colors.green.shade200;
                    else if (i == selectedIndex)
                      color = Colors.red.shade200;
                  } else if (i == selectedIndex) {
                    color = Colors.grey.shade300;
                  }
                  return GestureDetector(
                    onTap: () {
                      if (!mounted) return;
                      setState(() => selectedIndex = i);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black12),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                            color: Colors.black.withOpacity(0.1),
                          ),
                        ],
                      ),
                      child: Text(opt, style: const TextStyle(fontSize: 18)),
                    ),
                  ).animate().fadeIn(duration: 400.ms, delay: (i * 100).ms);
                }),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: checkAnswer,
                  child: const Text("Kiểm tra"),
                ).animate().scale(duration: 300.ms).fadeIn(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple,
              ],
              numberOfParticles: 20,
            ),
          ),
        ],
      ),
    );
  }
}
