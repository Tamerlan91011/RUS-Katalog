import 'package:flutter/material.dart';
import 'package:rus_katalog/Pages/Account/account_mobile.dart';
import 'package:rus_katalog/Pages/Components/AppBar/appbar_mobile.dart';
import 'package:rus_katalog/Pages/Components/navigation_bar.dart';
import '../../Components/AppBar/appbar_mobile.dart';
import '../Bodies/home_mobile.dart';
import '../../Cart/Bodies/cart_mobile.dart';
import '../../Catalog/catalog_mobile.dart';
import '../../Favorite/Bodies/favorite_mobile.dart';

class MobileHomeScreen extends StatefulWidget {
  const MobileHomeScreen({Key? key}) : super(key: key);

  @override
  _MobileHomeScreenState createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  int currentIndex = 0;

  final screens = [
    const MobileHome(),
    const MobileCatalog(),
    const MobileCart(),
    const MobileFavorite(),
    const MobileAccount(),
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
