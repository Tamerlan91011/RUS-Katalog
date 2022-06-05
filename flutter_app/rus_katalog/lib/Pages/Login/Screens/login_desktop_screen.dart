import 'package:flutter/material.dart';
import '../Bodies/login_mobile.dart';
import '../../Components/AppBar/appbar_desktop.dart';

class DesktopLoginScreen extends StatefulWidget {
  const DesktopLoginScreen({Key? key}) : super(key: key);

  @override
  _DesktopLoginScreenState createState() => _DesktopLoginScreenState();
}

class _DesktopLoginScreenState extends State<DesktopLoginScreen>
    with TickerProviderStateMixin {
  String query = "";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DesktopAppBar(),
      body: LoginMobile(),
    );
  }
}
