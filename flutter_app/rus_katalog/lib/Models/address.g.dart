// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      id: json['id'] as int,
      city: json['city'] as String,
      street: json['street'] as String,
      house: json['house'] as String,
      flat: json['flat'] as int?,
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'id': instance.id,
      'city': instance.city,
      'street': instance.street,
      'house': instance.house,
      'flat': instance.flat,
    };
