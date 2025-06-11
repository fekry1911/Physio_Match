
import 'package:json_annotation/json_annotation.dart';
part 'ques_model.g.dart';
@JsonSerializable()
class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);
}
