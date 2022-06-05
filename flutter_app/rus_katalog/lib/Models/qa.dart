import 'package:json_annotation/json_annotation.dart';

part 'qa.g.dart';

@JsonSerializable()
class Question {
  Question(
      {required this.id,
      required this.username,
      required this.article,
      required this.content});

  final int id;
  final String username;
  final String article;
  final String content;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

@JsonSerializable()
class Answer {
  Answer({required this.id, required this.username, required this.content});

  final int id;
  final String username;
  final String content;

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);
  Map<String, dynamic> toJson() => _$AnswerToJson(this);
}
