import 'package:flutter/material.dart';
import 'package:rus_katalog/constants.dart';

class TabletFilter extends StatefulWidget {
  const TabletFilter({Key? key, required this.filterProducts})
      : super(key: key);
  final void Function() filterProducts;

  @override
  State<TabletFilter> createState() => _TabletFilterState();
}

class _TabletFilterState extends State<TabletFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(singleSpace, 0, 0, 0),
        constraints:
            const BoxConstraints(maxWidth: desktopWidth),
        child: Card(
            elevation: standartElevation,
            child: SingleChildScrollView(
                child: Column(
              children: [
                const SizedBox(height: singleSpace/2),
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
                const SizedBox(height: singleSpace),
                Row(
                  children: [
                    const SizedBox(width: singleSpace),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {},
                            child: const Padding(
                                padding: EdgeInsets.all(singleSpace),
                                child: Text(
                                  "Применить",
                                )))),
                    const SizedBox(width: singleSpace)
                  ],
                ),
                const SizedBox(height: singleSpace),
              ], 
            ))));
  }
}
