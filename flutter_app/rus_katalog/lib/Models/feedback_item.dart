import 'package:json_annotation/json_annotation.dart';
import 'feedback.dart';
import 'shop.dart';

part 'feedback_item.g.dart';

@JsonSerializable()
class FeedbackItem {
  Feedback feedback;
  String clientName;
  Shop shop;

  FeedbackItem(
      {required this.feedback, required this.clientName, required this.shop});

  factory FeedbackItem.fromJson(Map<String, dynamic> json) =>
      _$FeedbackItemFromJson(json);
  Map<String, dynamic> toJson() => _$FeedbackItemToJson(this);
}
