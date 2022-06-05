import 'package:flutter/material.dart';

import 'package:rus_katalog/Models/category.dart';
import 'package:rus_katalog/api.dart';
import 'package:rus_katalog/constants.dart';

// Виджет каталога товаров для ПК
class DesktopCatalog extends StatefulWidget {
  const DesktopCatalog({Key? key, required this.closeOverlay})
      : super(key: key);
  final void Function() closeOverlay;

  @override
  State<DesktopCatalog> createState() => _DesktopCatalogState();
}

class _DesktopCatalogState extends State<DesktopCatalog>
    with TickerProviderStateMixin {
  List<Category> categories = [];
  bool mouseEnter = false;
  int currentId = -1;
  int duration = 500;

  late final AnimationController _controller = AnimationController(
      vsync: this, duration: Duration(milliseconds: duration));
  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    categories.addAll(await Api.getCategories());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return categories.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.all(singleSpace),
              constraints: const BoxConstraints(maxWidth: desktopWidth),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  color: Theme.of(context).primaryColor.withOpacity(opacity)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Каталог",
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: singleSpace),
                    MouseRegion(
                      onExit: (event) => setState(() {
                        mouseEnter = false;
                        currentId = -1;
                        _controller.reverse();
                      }),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              flex: 1,
                              child: Card(
                                  elevation: standartElevation,
                                  child: Column(
                                      children: ListTile.divideTiles(
                                    context: context,
                                    tiles: mainCategoryListBuilder(),
                                  ).toList()))),
                          Expanded(
                            flex: 1,
                            child: mouseEnter
                                ? FadeTransition(
                                    opacity: _animation,
                                    child: Card(
                                        elevation: standartElevation,
                                        child: Column(
                                            children: ListTile.divideTiles(
                                          context: context,
                                          tiles: secondaryCategoryListBuilder(),
                                        ).toList())))
                                : const SizedBox(),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  List<Widget> mainCategoryListBuilder() {
    List<Widget> categoryListTile = [];

    for (var item in categories) {
      if (item.parentId == null) {
        categoryListTile.add(MouseRegion(
            onEnter: (event) => (setState(() {
                  currentId = item.id;
                  mouseEnter = true;
                  _controller.forward();
                })),
            child: ListTile(
              selected: currentId == item.id,
              selectedColor: kPrimaryColor,
              leading: const Icon(Icons.category),
              title: Text(item.name,
                  style: Theme.of(context).textTheme.titleMedium),
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

    for (var item in secondaryCatigories) {
      categoryListTile.add(Container(
          margin: const EdgeInsets.symmetric(horizontal: singleSpace),
          child: ListTile(
            onTap: () => setState(() {
              widget.closeOverlay();
              Navigator.pushNamed(context, "/catalog/${item.id}");
            }),
            leading: const Icon(Icons.category),
            title:
                Text(item.name, style: Theme.of(context).textTheme.titleMedium),
            trailing: const Icon(Icons.keyboard_arrow_right),
          )));
    }

    return categoryListTile;
  }
}
