import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';

import '../../../data/model/quiz_model.dart';

class QuizScreen extends StatefulWidget {
  final String level;
  const QuizScreen({super.key, required this.level});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<QuizQuestion> questions = [];
  int currentIndex = 0;
  int? selectedOption;
  bool showResult = false;
  int score = 0;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    loadQuiz();
  }

  Future<void> loadQuiz() async {
    final data = await rootBundle.loadString('assets/data/quiz_${widget.level}.json');
    final List<dynamic> jsonList = json.decode(data);
    setState(() {
      questions = jsonList.map((e) => QuizQuestion.fromJson(e)).toList();
    });
  }

  void confirmAnswer() async {
    if (selectedOption == null || showResult) return;
    setState(() {
      showResult = true;
      if (selectedOption == questions[currentIndex].answer) {
        score++;
        player.play(AssetSource('sound/correct.mp3'));
      } else {
        player.play(AssetSource('sound/wrong.mp3'));
      }
    });
  }

  void nextQuestion() {
    if (currentIndex < questions.length - 1) {
      setState(() {
        currentIndex++;
        selectedOption = null;
        showResult = false;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(score: score, total: questions.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    final question = questions[currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text('JLPT ${widget.level.toUpperCase()} Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (currentIndex + 1) / questions.length,
              backgroundColor: Colors.grey[300],
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 20),
            Text(question.question, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ...List.generate(question.options.length, (i) {
              final isCorrect = i == question.answer;
              final isSelected = selectedOption == i;
              Color? bgColor;
              if (showResult && isSelected) {
                bgColor = isCorrect ? Colors.green[100] : Colors.red[100];
              } else if (isSelected) {
                bgColor = Colors.blue[100];
              }

              return GestureDetector(
                onTap: () {
                  if (!showResult) {
                    setState(() {
                      selectedOption = i;
                    });
                  }
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: bgColor ?? Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Text(question.options[i], style: const TextStyle(fontSize: 16)),
                ),
              );
            }),
            const Spacer(),
            if (!showResult)
              ElevatedButton(
                onPressed: selectedOption != null ? confirmAnswer : null,
                child: const Text('Xác nhận'),
              ),
            if (showResult)
              ElevatedButton(
                onPressed: nextQuestion,
                child: Text(currentIndex < questions.length - 1 ? 'Câu tiếp theo' : 'Xem kết quả'),
              ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final int score;
  final int total;

  const ResultScreen({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kết quả')),
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0, end: score.toDouble()),
          duration: const Duration(seconds: 2),
          builder: (context, value, child) => Text(
            'Điểm của bạn: ${value.toInt()} / $total',
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}