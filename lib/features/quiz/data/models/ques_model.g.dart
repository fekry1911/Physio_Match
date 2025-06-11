// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ques_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
  questionText: json['questionText'] as String,
  options: (json['options'] as List<dynamic>).map((e) => e as String).toList(),
  correctAnswerIndex: (json['correctAnswerIndex'] as num).toInt(),
);

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
  'questionText': instance.questionText,
  'options': instance.options,
  'correctAnswerIndex': instance.correctAnswerIndex,
};
