import 'package:flutter/material.dart';
import 'package:rus_katalog/Pages/Components/AppBar/appbar_mobile.dart';
import '../../Components/AppBar/appbar_mobile.dart';
import '../Bodies/makeorder_desktop.dart';


class TabletMakeOrderScreen extends StatefulWidget {
  const TabletMakeOrderScreen({Key? key}) : super(key: key);

  @override
  _TabletMakeOrderScreenState createState() => _TabletMakeOrderScreenState();
}

class _TabletMakeOrderScreenState extends State<TabletMakeOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MobileAppBar(),
      body: MakeOrderDesktop(isDesktop: false),
    );
  }
}
