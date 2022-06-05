import 'package:flutter/material.dart';

import 'package:rus_katalog/Pages/Components/AppBar/appbar_mobile.dart';
import 'package:rus_katalog/Pages/Components/navigation_bar.dart';
import 'package:rus_katalog/Pages/ProductsList/Bodies/productslist_mobile.dart';
import 'package:rus_katalog/Models/product.dart';

import '../../Account/account_mobile.dart';
import '../../Cart/Bodies/cart_mobile.dart';
import '../../Catalog/catalog_mobile.dart';
import '../../Favorite/Bodies/favorite_mobile.dart';

class MobileProductsListScreen extends StatefulWidget {
  const MobileProductsListScreen(
      {Key? key,
      required this.productList,
      required this.priceList,
      required this.rateList})
      : super(key: key);

  final List<Product> productList;
  final Future<List<double>> priceList;
  final Future<List<double>> rateList;

  @override
  State<MobileProductsListScreen> createState() =>
      _MobileProductsListScreenState();
}

class _MobileProductsListScreenState extends State<MobileProductsListScreen> {
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

    Future.wait([widget.priceList, widget.rateList]).whenComplete(() async {
      screens[0] = MobileProductsList(
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
