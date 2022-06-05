import 'package:json_annotation/json_annotation.dart';

part 'specification.g.dart';

@JsonSerializable()
class SpecificationValue {
  final int id;
  final int specId;
  int? valueInt;
  double? valueFloat;
  String? valueString;

  SpecificationValue({
    required this.id,
    required this.specId,
    this.valueInt,
    this.valueFloat,
    this.valueString
  });

  factory SpecificationValue.fromJson(Map<String, dynamic> json) => _$SpecificationValueFromJson(json);
  Map<String, dynamic> toJson() => _$SpecificationValueToJson(this);
}

@JsonSerializable()
class Specification {
  final int id;
  String name;
  String description;
  String? units;

  Specification({
    required this.id,
    required this.name,
    required this.description,
    required this.units
  });

  factory Specification.fromJson(Map<String, dynamic> json) => _$SpecificationFromJson(json);
  Map<String, dynamic> toJson() => _$SpecificationToJson(this);
}