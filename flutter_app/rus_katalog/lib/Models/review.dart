import 'package:json_annotation/json_annotation.dart';

part 'review.g.dart';

@JsonSerializable()
class Review {
  Review(
      {required this.id,
      required this.userame,
      required this.article,
      required this.content,
      required this.rating});

  final int id;
  final String userame;
  final String article;
  final String content;
  final double rating;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
