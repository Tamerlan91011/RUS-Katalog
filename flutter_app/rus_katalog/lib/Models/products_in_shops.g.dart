// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_in_shops.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductsInShops _$ProductsInShopsFromJson(Map<String, dynamic> json) =>
    ProductsInShops(
      productId: json['product_id'] as int,
      shop: Shop.fromJson(json['shop'] as Map<String, dynamic>),
      price: (json['price'] as num).toDouble(),
      availableAmount: json['available_amount'] as int,
    );

Map<String, dynamic> _$ProductsInShopsToJson(ProductsInShops instance) =>
    <String, dynamic>{
      'product_id': instance.productId,
      'shop': instance.shop,
      'price': instance.price,
      'available_amount': instance.availableAmount,
    };
