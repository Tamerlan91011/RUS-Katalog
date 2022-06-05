import 'package:flutter/material.dart';
import 'package:rus_katalog/responsive.dart';
import 'Screens/home_screen_mobile.dart';
import 'Screens/home_screen_tablet.dart';
import 'Screens/home_screen_desktop.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
        mobile: MobileHomeScreen(),
        tablet: TabletHomeScreen(),
        desktop: DesktopHomeScreen());
  }
}
