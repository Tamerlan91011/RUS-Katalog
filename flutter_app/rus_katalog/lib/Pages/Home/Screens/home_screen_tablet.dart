import 'package:flutter/material.dart';
import 'package:rus_katalog/Pages/Components/AppBar/appbar_mobile.dart';
import '../../Components/AppBar/appbar_mobile.dart';
import '../../Components/navigation_bar.dart';
import '../Bodies/home_tablet.dart';
import '../../Cart/Bodies/cart_tablet.dart';
import '../../Catalog/catalog_tablet.dart';
import '../../Favorite/Bodies/favorite_tablet.dart';
import '../../Account/account_mobile.dart';

class TabletHomeScreen extends StatefulWidget {
  const TabletHomeScreen({Key? key}) : super(key: key);

  @override
  _TabletHomeScreenState createState() => _TabletHomeScreenState();
}

class _TabletHomeScreenState extends State<TabletHomeScreen> {
  int currentIndex = 0;
  final screens = [
    const TabletHome(),
    const TabletCatalog(),
    const TabletCart(),
    const TabletFavorite(),
    const MobileAccount()
  ];

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
