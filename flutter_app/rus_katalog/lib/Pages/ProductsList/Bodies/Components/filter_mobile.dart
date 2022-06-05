import 'package:flutter/material.dart';
import 'package:rus_katalog/constants.dart';

class MobileFilterOverlay extends StatefulWidget {
  const MobileFilterOverlay({Key? key, required this.filterProducts, required this.closeOverlay}) : super(key: key);
  final void Function() filterProducts;
  final void Function() closeOverlay;

  @override
  State<MobileFilterOverlay> createState() => _MobileFilterOverlayState();
}

class _MobileFilterOverlayState extends State<MobileFilterOverlay> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          margin: const EdgeInsets.fromLTRB(
              0, mobileAppBarHeight, 0, mobileNavBarHeight),
          constraints: const BoxConstraints(maxWidth: desktopWidth),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: singleSpace, vertical: singleSpace / 2),
                height: singleSpace * 4,
                constraints: const BoxConstraints(maxWidth: desktopWidth),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  color: kGrayColor,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: singleSpace, vertical: singleSpace / 2),
                height: 200,
                constraints: const BoxConstraints(maxWidth: desktopWidth),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  color: kGrayColor,
                ),
              ),
              const Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: () { widget.closeOverlay(); },
                      child: const Padding(
                          padding: EdgeInsets.all(singleSpace),
                          child: Text(
                            "Отмена",
                          ))),
                  const SizedBox(width: singleSpace * 2),
                  ElevatedButton(
                      onPressed: (){ widget.closeOverlay(); },
                      child: const Padding(
                          padding: EdgeInsets.all(singleSpace),
                          child: Text(
                            "Применить",
                          )))
                ],
              ),
              const SizedBox(height: singleSpace * 2),
            ],
          )),
    );
  }
}
