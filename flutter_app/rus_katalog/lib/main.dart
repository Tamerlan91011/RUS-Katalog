import 'package:flutter/material.dart';
import 'package:rus_katalog/Pages/ProductsList/productslist_page.dart';
import 'package:rus_katalog/localdata.dart';
import 'package:rus_katalog/theme.dart';
import 'Pages/Home/home_page.dart';
import 'Pages/Product/product_page.dart';
import 'Pages/Login/login_page.dart';
import 'Pages/MakeOrder/makeorder_page.dart';
import 'Pages/Orders/orders_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  bool? darkModeEnabled;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    darkModeEnabled = await LocalData.getTheme();
    if (darkModeEnabled != null) {
      setState(() {
        darkModeEnabled!
            ? _themeMode = ThemeMode.dark
            : _themeMode = ThemeMode.light;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: _themeMode,
      routes: {
        '/': ((context) => const HomePage()),
        '/catalog': (context) => const ProductsListPage(),
        '/product': (context) => const ProductPage(),
        '/login': (context) => const LoginPage(),
        '/makeorder': (context) => const MakeOrderPage(),
        '/orders': (context) => const OrdersPage(),
      },
      onGenerateRoute: (RouteSettings settings) {
        var path = settings.name!.split('/');

        if (path[1] == "catalog") {
          return MaterialPageRoute(
              builder: (context) =>
                  ProductsListPage(categoryId: int.parse(path[2])),
              settings: settings);
        } else if (path[1] == "product") {
          return MaterialPageRoute(
              builder: (context) => ProductPage(productId: int.parse(path[2])),
              settings: settings);
        } else if (path[1] == "login") {
          return MaterialPageRoute(
              builder: (context) => const LoginPage(), settings: settings);
        } else if (path[1] == "makeorder") {
          return MaterialPageRoute(
              builder: (context) => const MakeOrderPage(), settings: settings);
        } else if (path[1] == "orders") {
          return MaterialPageRoute(
              builder: (context) => const OrdersPage(), settings: settings);
        } else {
          return MaterialPageRoute(
              builder: (context) => const HomePage(), settings: settings);
        }
      },
    );
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
      LocalData.saveTheme(themeMode == ThemeMode.dark);
    });
  }
}
