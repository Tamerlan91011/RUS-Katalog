// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as int,
      brand: json['brand'] as String,
      model: json['model'] as String,
      itemNumber: json['item_number'] as String,
      description: json['description'] as String,
      categoryId: json['category'] as int,
      specList: [],
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'brand': instance.brand,
      'model': instance.model,
      'item_number': instance.itemNumber, 
      'description': instance.description,
      'category': instance.categoryId,
    };
