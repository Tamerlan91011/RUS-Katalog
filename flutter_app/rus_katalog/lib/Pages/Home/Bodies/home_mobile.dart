import 'package:flutter/material.dart';
import 'package:rus_katalog/constants.dart';
import '../../Components/carousel.dart';

class MobileHome extends StatefulWidget {
  const MobileHome({Key? key}) : super(key: key);

  @override
  _MobileHomeState createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileHome> {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).brightness == Brightness.light
        ? kGrayColor
        : Colors.white;

    return SingleChildScrollView(
      child: Column(children: [
        const SizedBox(height: singleSpace),
        const CarouselWithIndicator(
            imgList: ["images/Img1.png", "images/Img2.png", "images/Img3.png"],
            height: -1),
        const SizedBox(height: singleSpace),
        Text("Популярные категории",
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: singleSpace),
        Container(
          margin: const EdgeInsets.all(singleSpace),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(64),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: color))),
                  const SizedBox(width: singleSpace),
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(64),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: color))),
                  const SizedBox(width: singleSpace),
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(64),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: color)))
                ],
              ),
              const SizedBox(height: singleSpace),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(64),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: color))),
                  const SizedBox(width: singleSpace),
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(64),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: color))),
                  const SizedBox(width: singleSpace),
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(64),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: color)))
                ],
              ),
              const SizedBox(height: singleSpace),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(64),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: color))),
                  const SizedBox(width: singleSpace),
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(64),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: color))),
                  const SizedBox(width: singleSpace),
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(64),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: color)))
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }
}
