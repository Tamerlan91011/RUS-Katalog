import 'package:json_annotation/json_annotation.dart';

import 'package:rus_katalog/Models/specification.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  final int id;
  String brand;
  String model;
  String itemNumber;
  String description;
  int categoryId;
  List<SpecificationValue> specList;

  Product(
      {required this.id,
      required this.brand,
      required this.model,
      required this.itemNumber,
      required this.description,
      required this.categoryId,
      required this.specList});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
