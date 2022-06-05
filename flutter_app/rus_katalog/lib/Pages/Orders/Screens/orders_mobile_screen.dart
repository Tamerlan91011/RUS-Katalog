import 'package:flutter/material.dart';
import 'package:rus_katalog/Pages/Components/AppBar/appbar_mobile.dart';
import '../../Account/account_mobile.dart';
import '../../Cart/Bodies/cart_mobile.dart';
import '../../Catalog/catalog_mobile.dart';
import '../../Components/AppBar/appbar_mobile.dart';
import '../../Components/navigation_bar.dart';
import '../../Favorite/Bodies/favorite_mobile.dart';
import '../Bodies/orders_mobile.dart';

class MobileOrdersScreen extends StatefulWidget {
  const MobileOrdersScreen({Key? key}) : super(key: key);

  @override
  _MobileOrdersScreenState createState() => _MobileOrdersScreenState();
}

class _MobileOrdersScreenState extends State<MobileOrdersScreen> {
  int currentIndex = 0;

  final screens = [
    const OrdersMobile(),
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
