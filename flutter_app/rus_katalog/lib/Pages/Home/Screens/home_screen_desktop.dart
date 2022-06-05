import 'package:flutter/material.dart';
import '../Bodies/home_desktop.dart';
import '../../Components/AppBar/appbar_desktop.dart';

class DesktopHomeScreen extends StatefulWidget {
  const DesktopHomeScreen({ Key? key }) : super(key: key);

  @override
  _DesktopHomeScreenState createState() => _DesktopHomeScreenState();
}

class _DesktopHomeScreenState extends State<DesktopHomeScreen> with TickerProviderStateMixin {
  String query = "";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DesktopAppBar(),
      body: DesktopHome(),
    );
  }
}