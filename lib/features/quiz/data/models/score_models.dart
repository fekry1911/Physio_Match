import 'package:cloud_firestore/cloud_firestore.dart';

class ScoreModel {
  final int correctAnswers;
  final int totalQuestions;
  final DateTime date;

  ScoreModel({
    required this.correctAnswers,
    required this.totalQuestions,
    DateTime? date,
  }) : date = date ?? DateTime.now();


  Map<String, dynamic> toMap() {
    return {
      'correctAnswers': correctAnswers,
      'totalQuestions': totalQuestions,
      'date': date.toIso8601String(),
    };
  }

  factory ScoreModel.fromMap(Map<String, dynamic> map) {
    final rawDate = map['date'];

    DateTime parsedDate;
    if (rawDate is Timestamp) {
      parsedDate = rawDate.toDate();
    } else if (rawDate is String) {
      parsedDate = DateTime.tryParse(rawDate) ?? DateTime.now();
    } else {
      parsedDate = DateTime.now();
    }

    return ScoreModel(
      correctAnswers: map['correctAnswers'] ?? 0,
      totalQuestions: map['totalQuestions'] ?? 0,
      date: parsedDate,
    );
  }

}
