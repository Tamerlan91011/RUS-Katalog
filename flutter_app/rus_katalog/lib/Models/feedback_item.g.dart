// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedbackItem _$FeedbackItemFromJson(Map<String, dynamic> json) => FeedbackItem(
      feedback: Feedback.fromJson(json),
      clientName: json['pio']['order']['client']['fullname'] as String,
      shop: Shop.fromJson(json['pio']['shop']['shop'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeedbackItemToJson(FeedbackItem instance) =>
    <String, dynamic>{
      'feedback': instance.feedback,
      'clientName': instance.clientName,
      'shop': instance.shop,
    };
