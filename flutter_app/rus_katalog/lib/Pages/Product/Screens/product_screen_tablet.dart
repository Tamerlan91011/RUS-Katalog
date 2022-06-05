import 'package:flutter/material.dart';
import 'package:rus_katalog/Models/feedback_item.dart';
import 'package:rus_katalog/Models/product.dart';
import 'package:rus_katalog/Models/products_in_shops.dart';
import 'package:rus_katalog/Models/specification.dart';
import 'package:rus_katalog/Pages/Components/AppBar/appbar_mobile.dart';
import 'package:rus_katalog/Pages/Components/navigation_bar.dart';

import '../../Cart/Bodies/cart_tablet.dart';
import '../../Catalog/catalog_tablet.dart';
import '../../Favorite/Bodies/favorite_tablet.dart';
import '../Bodies/product_tablet.dart';
import '../../Account/account_mobile.dart';

class TabletProductScreen extends StatefulWidget {
  const TabletProductScreen(
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
  State<TabletProductScreen> createState() => _TabletProductScreenState();
}

class _TabletProductScreenState extends State<TabletProductScreen> {
  int currentIndex = 0;
  final screens = [];

  @override
  void initState() {
    super.initState();

    screens.addAll([
      const Center(child: CircularProgressIndicator()),
      const TabletCatalog(),
      const TabletCart(),
      const TabletFavorite(),
      const MobileAccount(),
    ]);

    Future.wait([widget.product, widget.specList]).whenComplete(() async {
      screens[0] = TabletProduct(
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
