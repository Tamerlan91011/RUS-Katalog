// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Feedback _$FeedbackFromJson(Map<String, dynamic> json) => Feedback(
      id: json['pio']['id'] as int,
      advantages: json['advantages'] as String,
      disadvantages: json['disadvantages'] as String,
      comment: json['comment'] as String,
      rating: (json['rating'] as num).toDouble(),
    );

Map<String, dynamic> _$FeedbackToJson(Feedback instance) => <String, dynamic>{
      'id': instance.id,
      'advantages': instance.advantages,
      'disadvantages': instance.disadvantages,
      'comment': instance.comment,
      'rating': instance.rating,
    };
