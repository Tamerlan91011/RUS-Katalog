// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => Order(
      id: json['id'] as int,
      status: json['status'] as String,
      date: json['date'] as String,
      deliveryAddress: json['delivery_address'] as String
    );

Map<String, dynamic> _$OrderToJson(Order instance) => <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'date': instance.date,
      'delivery_address': instance.deliveryAddress, 
    };
