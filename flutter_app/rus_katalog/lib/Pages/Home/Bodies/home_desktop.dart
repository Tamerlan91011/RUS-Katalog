import 'package:flutter/material.dart';
import 'package:rus_katalog/constants.dart';
import '../../Components/carousel.dart';

class DesktopHome extends StatefulWidget {
  const DesktopHome({Key? key}) : super(key: key);

  @override
  _DesktopHomeState createState() => _DesktopHomeState();
}

class _DesktopHomeState extends State<DesktopHome> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: desktopWidth),
        child: Column(children: [
          const SizedBox(height: singleSpace),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Card(
                  elevation: standartElevation,
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    constraints:
                        const BoxConstraints(maxWidth: 400, maxHeight: 450),
                    child: ListView.builder(
                      itemCount: 7,
                      itemBuilder: listBuilder,
                    ),
                  ),
                ),
              ),
              const Expanded(
                child: CarouselWithIndicator(
                  imgList: [
                    "images/Img1.png",
                    "images/Img2.png",
                    "images/Img3.png"
                  ],
                  height: -1,
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}

Widget listBuilder(BuildContext context, int index) {
  List<String> categoryList = [
    "Бытовая техника",
    "Смартфоны и гаджеты",
    "ТВ и мультимедиа",
    "Компьютеры",
    "Офис и сеть",
    "Инструменты",
    "Автотовары"
  ];
  return Dismissible(
    key: Key(categoryList[index]),
    child: ListTile(
      title: Text(categoryList[index],
          style: Theme.of(context).textTheme.titleMedium),
      leading: Container(
        margin: const EdgeInsets.all(singleSpace),
        padding: const EdgeInsets.all(singleSpace * 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Theme.of(context).brightness == Brightness.light
                ? kGrayColor
                : Colors.white),
        constraints: const BoxConstraints(maxWidth: 48, maxHeight: 48),
      ),
      subtitle: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: singleSpace * 6, vertical: singleSpace * 2),
        margin: const EdgeInsets.all(singleSpace),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: kGrayColor),
        constraints:
            const BoxConstraints(maxWidth: 100, maxHeight: singleSpace * 2),
      ),
    ),
  );
}
