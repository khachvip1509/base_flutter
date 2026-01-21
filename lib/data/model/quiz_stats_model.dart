class QuizStats {
  int total;
  int correct;

  QuizStats({this.total = 0, this.correct = 0});

  double get accuracy => total == 0 ? 0 : (correct / total) * 100;

  Map<String, dynamic> toJson() => {"total": total, "correct": correct};

  factory QuizStats.fromJson(Map<String, dynamic> json) =>
      QuizStats(total: json["total"] ?? 0, correct: json["correct"] ?? 0);
}
