import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  final int id;
  String status;
  String date;
  String deliveryAddress;

  Order(
      {required this.id,
      required this.status,
      required this.date,
      required this.deliveryAddress});

  factory Order.fromJson(Map<String, dynamic> json) =>
      _$OrderFromJson(json);
  Map<String, dynamic> toJson() => _$OrderToJson(this);
}
