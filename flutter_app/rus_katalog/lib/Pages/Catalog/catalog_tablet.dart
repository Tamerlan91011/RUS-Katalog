import 'package:flutter/material.dart';

import '../../Models/category.dart';
import 'package:rus_katalog/api.dart';
import 'package:rus_katalog/constants.dart';

class TabletCatalog extends StatefulWidget {
  const TabletCatalog({Key? key}) : super(key: key);

  @override
  State<TabletCatalog> createState() => _TabletCatalogState();
}

class _TabletCatalogState extends State<TabletCatalog>
    with SingleTickerProviderStateMixin {
  final List<Category> categories = [];
  List<Widget> overlayCategoryList = [];
  int currentId = -1;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );

  late final Animation<Offset> _animation = Tween<Offset>(
    begin: const Offset(1.0, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  ));

  late OverlayEntry categoryOverlay = OverlayEntry(
    builder: (context) => SlideTransition(
      position: _animation,
      child: Center(
          child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              constraints: const BoxConstraints(maxWidth: desktopWidth),
              margin: EdgeInsets.fromLTRB(
                  0,
                  mobileAppBarHeight + MediaQuery.of(context).viewPadding.top,
                  0,
                  mobileNavBarHeight),
              child: ListView(
                children: ListTile.divideTiles(
                  context: context,
                  tiles: overlayCategoryList,
                ).toList(),
              ))),
    ),
  );

  @override
  void initState() {
    super.initState();

    getData();

    _controller.addListener(() {
      Overlay.of(context)!.setState(() {});
    });
  }

  void getData() async {
    categories.addAll(await Api.getCategories());
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();

    if (categoryOverlay.mounted) {
      categoryOverlay.remove();
    }
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return categories.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Container(
            constraints: const BoxConstraints(maxWidth: desktopWidth),
            child: ListView(
              children: categoryListBuilder(),
            ),
          );
  }

  List<Widget> categoryListBuilder() {
    List<Widget> categoryListTile = [];

    for (var item in categories) {
      if (item.parentId == null) {
        categoryListTile.add(Container(
            margin: const EdgeInsets.symmetric(horizontal: singleSpace),
            child: ListTile(
              onTap: () {
                setState(() {
                  currentId = item.id;
                  overlayCategoryList.clear();
                  overlayCategoryList.addAll(secondaryCategoryListBuilder());
                  Overlay.of(context)!.insert(categoryOverlay);
                  _controller.forward();
                });
              },
              leading: const Icon(Icons.category),
              title: RichText(
                  text: TextSpan(
                      text: item.name,
                      style: Theme.of(context).textTheme.titleMedium)),
              trailing: const Icon(Icons.keyboard_arrow_right),
            )));
      }
    }

    return categoryListTile;
  }

  List<Widget> secondaryCategoryListBuilder() {
    List<Widget> categoryListTile = [];
    List<Category> secondaryCatigories = [];

    secondaryCatigories
        .addAll(categories.where((element) => element.parentId == currentId));

    categoryListTile.add(Material(
        child: Row(children: [
      const SizedBox(
        width: singleSpace * 2,
      ),
      BackButton(onPressed: () {
        setState(() {
          _controller.reverse();
          Future.delayed(const Duration(milliseconds: 500))
              .whenComplete(() => categoryOverlay.remove());
        });
      }),
      const Expanded(child: SizedBox())
    ])));

    for (var item in secondaryCatigories) {
      categoryListTile.add(Container(
          margin: const EdgeInsets.symmetric(horizontal: singleSpace),
          child: Material(
              child: ListTile(
            onTap: () {
              setState(() {
                _controller.reverse();
                categoryOverlay.remove();
                Navigator.pushNamed(context, "/catalog/${item.id}");
              });
            },
            leading: const Icon(Icons.category),
            title:
                Text(item.name, style: Theme.of(context).textTheme.titleMedium),
            trailing: const Icon(Icons.keyboard_arrow_right),
          ))));
    }

    return categoryListTile;
  }
}
