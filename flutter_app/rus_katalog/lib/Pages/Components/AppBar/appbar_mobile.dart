import 'package:flutter/material.dart';
import 'package:rus_katalog/Models/product.dart';
import 'package:rus_katalog/constants.dart';

class MobileAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MobileAppBar({Key? key}) : super(key: key);

  @override
  State<MobileAppBar> createState() => _MobileAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(mobileAppBarHeight);
}

class _MobileAppBarState extends State<MobileAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: Center(
          child: Text(companyName,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold, shadows: [
                const Shadow(color: Colors.white, blurRadius: singleSpace * 2)
              ]))),
      bottom: PreferredSize(
        preferredSize: const Size.fromRadius(20),
        child: GestureDetector(
          onTap: () {
            showSearch(context: context, delegate: CustomSearchDelegate());
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(
                singleSpace * 2, singleSpace, singleSpace * 2, singleSpace),
            decoration: BoxDecoration(
              color: Theme.of(context).bottomAppBarColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(children: [
              const Padding(padding: EdgeInsets.all(singleSpace)),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.all(singleSpace),
                  child: Text("Найти товары",
                      style: Theme.of(context).textTheme.titleMedium),
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(singleSpace),
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.search)),
            ]),
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = "";
              }
            })
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) => Center(
        child: Text(query),
      );

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Product> products = [];

    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return ListTile(
            title: Text("${product.brand} ${product.model}"),
            onTap: () {
              query = "${product.brand} ${product.model}";

              showResults(context);
            },
          );
        });
  }
}
