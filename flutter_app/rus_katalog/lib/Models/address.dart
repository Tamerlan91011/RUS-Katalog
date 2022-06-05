import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  final int id;
  String city;
  String street;
  String house;
  int? flat;

  Address(
      {required this.id,
      required this.city,
      required this.street,
      required this.house,
      this.flat});

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);

  @override
  String toString() {
    return flat != null
        ? "$city, $street, $house, $flat"
        : "$city, $street, $house";
  }
}
