// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecificationValue _$SpecificationValueFromJson(Map<String, dynamic> json) =>
    SpecificationValue(
      id: json['id'] as int,
      specId: json['specification'] as int,
      valueInt: json['value_int_field'] as int?,
      valueFloat: (json['value_float_field'] as num?)?.toDouble(),
      valueString: json['value_string_field'] as String?,
    );

Map<String, dynamic> _$SpecificationValueToJson(SpecificationValue instance) =>
    <String, dynamic>{
      'id': instance.id,
      'specification': instance.specId,
      'value_int_field': instance.valueInt,
      'value_float_field': instance.valueFloat,
      'value_string_field': instance.valueString,
    };

Specification _$SpecificationFromJson(Map<String, dynamic> json) =>
    Specification(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      units: json['unit'] as String?,
    );

Map<String, dynamic> _$SpecificationToJson(Specification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'unit': instance.units,
    };
