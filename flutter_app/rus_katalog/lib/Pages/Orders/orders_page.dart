import 'package:flutter/material.dart';
import 'package:rus_katalog/responsive.dart';
import 'Screens/orders_mobile_screen.dart';
import 'Screens/orders_tablet_screen.dart';
import 'Screens/orders_desktop_screen.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
        mobile: MobileOrdersScreen(),
        tablet: TabletOrdersScreen(),
        desktop: DesktopOrdersScreen());
  }
}
