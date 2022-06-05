import 'package:flutter/material.dart';
import 'package:rus_katalog/Pages/Components/AppBar/appbar_mobile.dart';
import '../../Components/AppBar/appbar_mobile.dart';
import '../Bodies/login_mobile.dart';


class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({Key? key}) : super(key: key);

  @override
  _MobileLoginScreenState createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MobileAppBar(),
      body: LoginMobile(),
    );
  }
}
