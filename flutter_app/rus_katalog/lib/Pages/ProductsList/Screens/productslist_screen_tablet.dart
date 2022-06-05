import 'package:flutter/material.dart';

import 'package:rus_katalog/Pages/Components/AppBar/appbar_mobile.dart';
import 'package:rus_katalog/Pages/Components/navigation_bar.dart';
import '../../Account/account_mobile.dart';
import '../../Cart/Bodies/cart_tablet.dart';
import '../../Catalog/catalog_tablet.dart';
import '../../Favorite/Bodies/favorite_tablet.dart';
import '../Bodies/productslist_tablet.dart';
import 'package:rus_katalog/Models/product.dart';

class TabletProductsListScreen extends StatefulWidget {
  const TabletProductsListScreen(
      {Key? key,
      required this.productList,
      required this.priceList,
      required this.rateList})
      : super(key: key);

  final List<Product> productList;
  final Future<List<double>> priceList;
  final Future<List<double>> rateList;

  @override
  State<TabletProductsListScreen> createState() =>
      _TabletProductsListScreenState();
}

class _TabletProductsListScreenState extends State<TabletProductsListScreen> {
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
      const MobileAccount()
    ]);

    Future.wait([widget.priceList, widget.rateList]).whenComplete(() async {
      screens[0] = TabletProductsList(
          productList: widget.productList,
          priceList: await widget.priceList,
          rateList: await widget.rateList);
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
