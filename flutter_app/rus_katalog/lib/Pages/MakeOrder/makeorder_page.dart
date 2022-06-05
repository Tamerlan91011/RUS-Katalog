import 'package:flutter/material.dart';
import 'package:rus_katalog/responsive.dart';
import 'Screens/makeorder_mobile_screen.dart';
import 'Screens/makeorder_tablet_screen.dart';
import 'Screens/makeorder_desktop_screen.dart';

class MakeOrderPage extends StatefulWidget {
  const MakeOrderPage({Key? key}) : super(key: key);

  @override
  _MakeOrderPageState createState() => _MakeOrderPageState();
}

class _MakeOrderPageState extends State<MakeOrderPage> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
        mobile: MobileMakeOrderScreen(),
        tablet: TabletMakeOrderScreen(),
        desktop: DesktopMakeOrderScreen());
  }
}
