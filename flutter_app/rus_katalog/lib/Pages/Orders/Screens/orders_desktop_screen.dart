import 'package:flutter/material.dart';
import '../Bodies/orders_desktop.dart';
import '../../Components/AppBar/appbar_desktop.dart';

class DesktopOrdersScreen extends StatefulWidget {
  const DesktopOrdersScreen({Key? key}) : super(key: key);

  @override
  _DesktopOrdersScreenState createState() => _DesktopOrdersScreenState();
}

class _DesktopOrdersScreenState extends State<DesktopOrdersScreen>
    with TickerProviderStateMixin {
  String query = "";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DesktopAppBar(),
      body: OrdersDesktop(),
    );
  }
}
