import 'package:flutter/material.dart';
import 'package:rus_katalog/responsive.dart';
import 'Screens/login_mobile_screen.dart';
import 'Screens/login_desktop_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
        mobile: MobileLoginScreen(),
        tablet: MobileLoginScreen(),
        desktop: DesktopLoginScreen());
  }
}
