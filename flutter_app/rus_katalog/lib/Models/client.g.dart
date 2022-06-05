// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Client _$ClientFromJson(Map<String, dynamic> json) => Client(
      id: json['id'] as int,
      email: json['email'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
      fullname: json['fullname'] as String,
      isAdmin: json['isadmin'] as bool,
    );

Map<String, dynamic> _$ClientToJson(Client instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'fullname': instance.fullname,
      'isadmin': instance.isAdmin,
    };
