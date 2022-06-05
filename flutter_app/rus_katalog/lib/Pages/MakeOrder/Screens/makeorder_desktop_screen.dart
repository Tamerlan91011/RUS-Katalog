import 'package:flutter/material.dart';
import 'package:rus_katalog/Pages/MakeOrder/Bodies/makeorder_desktop.dart';
import '../../Components/AppBar/appbar_desktop.dart';

class DesktopMakeOrderScreen extends StatefulWidget {
  const DesktopMakeOrderScreen({Key? key}) : super(key: key);

  @override
  _DesktopMakeOrderScreenState createState() => _DesktopMakeOrderScreenState();
}

class _DesktopMakeOrderScreenState extends State<DesktopMakeOrderScreen>
    with TickerProviderStateMixin {
  String query = "";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DesktopAppBar(),
      body: MakeOrderDesktop(isDesktop: true),
    );
  }
}
