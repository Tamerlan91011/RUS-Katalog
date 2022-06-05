import 'package:flutter/material.dart';
import 'package:rus_katalog/Models/feedback_item.dart';
import 'package:rus_katalog/Models/product.dart';
import 'package:rus_katalog/Models/products_in_shops.dart';
import 'package:rus_katalog/Models/specification.dart';
import 'package:rus_katalog/Pages/Components/AppBar/appbar_mobile.dart';
import 'package:rus_katalog/Pages/Components/navigation_bar.dart';

import '../Bodies/product_mobile.dart';
import '../../Account/account_mobile.dart';
import '../../Cart/Bodies/cart_mobile.dart';
import '../../Catalog/catalog_mobile.dart';
import '../../Favorite/Bodies/favorite_mobile.dart';

class MobileProductScreen extends StatefulWidget {
  const MobileProductScreen(
      {Key? key,
      required this.product,
      required this.specList,
      required this.feedbackList,
      required this.priceList})
      : super(key: key);

  final Future<Product> product;
  final Future<List<Specification>> specList;
  final Future<List<FeedbackItem>> feedbackList;
  final Future<List<ProductsInShops>> priceList;

  @override
  State<MobileProductScreen> createState() => _MobileProductScreenState();
}

class _MobileProductScreenState extends State<MobileProductScreen> {
  int currentIndex = 0;
  final screens = [];

  @override
  void initState() {
    super.initState();

    screens.addAll([
      const Center(child: CircularProgressIndicator()),
      const MobileCatalog(),
      const MobileCart(),
      const MobileFavorite(),
      const MobileAccount(),
    ]);

    Future.wait([widget.product, widget.specList]).whenComplete(() async {
      screens[0] = MobileProduct(
          product: await widget.product,
          specList: await widget.specList,
          feedbackList: await widget.feedbackList,
          priceList: await widget.priceList);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MobileAppBar(),
      body: screens[currentIndex],
      bottomNavigationBar: CustomNavigationBar(
        items: const [
          Icon(Icons.home),
          Icon(Icons.widgets),
          Icon(Icons.shopping_cart),
          Icon(Icons.favorite),
          Icon(Icons.person),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
