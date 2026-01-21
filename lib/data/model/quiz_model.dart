import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class QuizModel {
  final String category;
  final String question;
  final List<String> options;
  final int answerIndex;
  final String meaning;

  QuizModel({
    required this.category,
    required this.question,
    required this.options,
    required this.answerIndex,
    required this.meaning,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) => QuizModel(
    category: json['category'],
    question: json['question'],
    options: List<String>.from(json['options']),
    answerIndex: json['answerIndex'],
    meaning: json['meaning'] ?? "",
  );

  static Future<List<QuizModel>> loadFromAssets() async {
    final data = await rootBundle.loadString('assets/data/hiragana_quiz.json');
    final List<dynamic> jsonList = jsonDecode(data);
    return jsonList.map((e) => QuizModel.fromJson(e)).toList();
  }
}
