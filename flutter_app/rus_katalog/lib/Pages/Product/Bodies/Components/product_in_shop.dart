import 'package:flutter/material.dart';
import 'package:rus_katalog/Models/shop.dart';
import 'product_in_shop_desktop.dart';
import 'product_in_shop_mobile.dart';
import 'package:rus_katalog/constants.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {Key? key,
      required this.productId,
      required this.imageUrl,
      required this.shop,
      required this.price,
      required this.availableAmount})
      : super(key: key);

  final int productId;
  final String imageUrl;
  final Shop shop;
  final double price;
  final int availableAmount;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileWidth;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileWidth;

  @override
  Widget build(BuildContext context) {
    final Widget mobile = MobileProductItem(
        productId: productId,
        imageUrl: imageUrl,
        shop: shop,
        price: price,
        availableAmount: availableAmount);
    final Widget desktop = DesktopProductItem(
        productId: productId,
        imageUrl: imageUrl,
        shop: shop,
        price: price,
        availableAmount: availableAmount);

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= mobileProductWidth) {
          return desktop;
        } else {
          return mobile;
        }
      },
    );
  }
}
