import 'package:json_annotation/json_annotation.dart';

part 'feedback.g.dart';

@JsonSerializable()
class Feedback {
  final int id;
  String advantages;
  String disadvantages;
  String comment;
  double rating;

  Feedback(
      {required this.id,
      required this.advantages,
      required this.disadvantages,
      required this.comment,
      required this.rating});

  factory Feedback.fromJson(Map<String, dynamic> json) =>
      _$FeedbackFromJson(json);
  Map<String, dynamic> toJson() => _$FeedbackToJson(this);
}
