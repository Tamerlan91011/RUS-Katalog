import 'package:flutter/material.dart';
import 'productitem_desktop.dart';
import 'productitem_mobile.dart';
import 'package:rus_katalog/constants.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {Key? key,
      required this.productId,
      required this.imageUrl,
      required this.label,
      required this.price,
      required this.rating})
      : super(key: key);

  final int productId;
  final String imageUrl;
  final String label;
  final int price;
  final double rating;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileProductWidth;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileProductWidth;

  @override
  Widget build(BuildContext context) {
    final Widget mobile = MobileProductItem(
        productId: productId,
        imageUrl: imageUrl,
        label: label,
        price: price,
        rating: rating);
    final Widget desktop = DesktopProductItem(
        productId: productId,
        imageUrl: imageUrl,
        label: label,
        price: price,
        rating: rating);

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
