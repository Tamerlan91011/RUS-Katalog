import 'package:flutter/material.dart';
import 'package:rus_katalog/constants.dart';
import 'favoriteitem_desktop.dart';
import 'favoriteitem_mobile.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem(
      {Key? key,
      required this.productId,
      required this.imageUrl,
      required this.label,
      required this.price,
      required this.rating,
      required this.removeItem,
      this.showFavoriteOverlay,
      this.minWidth = 360})
      : super(key: key);

  final int productId;
  final String imageUrl;
  final String label;
  final int price;
  final double rating;
  final void Function(int id) removeItem;
  final double minWidth;
  final void Function()? showFavoriteOverlay;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileProductWidth;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= mobileProductWidth;

  @override
  Widget build(BuildContext context) {
    final Widget mobile = MobileFavoriteItem(
        productId: productId,
        imageUrl: imageUrl,
        label: label,
        price: price,
        rating: rating,
        removeItem: removeItem,
        minWidth: minWidth,
        showFavoriteOverlay: showFavoriteOverlay);
    final Widget desktop = DesktopFavoriteItem(
        productId: productId,
        imageUrl: imageUrl,
        label: label,
        price: price,
        rating: rating,
        removeItem: removeItem,
        showFavoriteOverlay: showFavoriteOverlay);

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
