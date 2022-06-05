import 'package:json_annotation/json_annotation.dart';
import 'package:rus_katalog/Models/shop.dart';

part 'products_in_shops.g.dart';

@JsonSerializable()
class ProductsInShops {
  final int productId;
  Shop shop;
  double price;
  int availableAmount;

  ProductsInShops(
      {required this.productId,
      required this.shop,
      required this.price,
      required this.availableAmount});

  factory ProductsInShops.fromJson(Map<String, dynamic> json) =>
      _$ProductsInShopsFromJson(json);
  Map<String, dynamic> toJson() => _$ProductsInShopsToJson(this);
}
