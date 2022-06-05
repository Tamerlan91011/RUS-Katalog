import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:rus_katalog/constants.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar(
      {Key? key,
      required this.items,
      this.onTap,
      this.height = mobileNavBarHeight,
      this.backgroundColor})
      : super(key: key);

  final List<Widget> items;
  final void Function(int)? onTap;
  final double height;
  final Color? backgroundColor;

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryColor,
      constraints: const BoxConstraints(maxWidth: desktopWidth),
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: CurvedNavigationBar(
        items: widget.items,
        onTap: widget.onTap,
        height: widget.height - 20,
        color: Theme.of(context).bottomAppBarColor,
        backgroundColor: Theme.of(context).primaryColor,
        animationDuration: const Duration(milliseconds: mobileNavBarDuration),
      ),
    );
  }
}
