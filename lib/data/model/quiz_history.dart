class QuizHistory {
  final DateTime date;
  final int total;
  final int correct;

  QuizHistory({required this.date, required this.total, required this.correct});

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'total': total,
    'correct': correct,
  };

  factory QuizHistory.fromJson(Map<String, dynamic> json) => QuizHistory(
    date: DateTime.parse(json['date']),
    total: json['total'],
    correct: json['correct'],
  );
}
