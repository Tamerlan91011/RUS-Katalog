// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) => Review(
      id: json['id'] as int,
      userame: json['userame'] as String,
      article: json['article'] as String,
      content: json['content'] as String,
      rating: (json['rating'] as num).toDouble(),
    );

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'id': instance.id,
      'userame': instance.userame,
      'article': instance.article,
      'content': instance.content,
      'rating': instance.rating,
    };
