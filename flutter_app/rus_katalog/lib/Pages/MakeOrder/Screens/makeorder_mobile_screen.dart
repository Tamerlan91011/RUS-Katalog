import 'package:flutter/material.dart';
import 'package:rus_katalog/Pages/Components/AppBar/appbar_mobile.dart';
import '../../Components/AppBar/appbar_mobile.dart';
import '../Bodies/makeorder_mobile.dart';


class MobileMakeOrderScreen extends StatefulWidget {
  const MobileMakeOrderScreen({Key? key}) : super(key: key);

  @override
  _MobileMakeOrderScreenState createState() => _MobileMakeOrderScreenState();
}

class _MobileMakeOrderScreenState extends State<MobileMakeOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MobileAppBar(),
      body: MakeOrderMobile(),
    );
  }
}
