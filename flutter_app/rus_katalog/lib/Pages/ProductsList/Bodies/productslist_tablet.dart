import 'package:flutter/material.dart';

import 'package:rus_katalog/constants.dart';
import 'package:rus_katalog/Pages/ProductsList/Bodies/Components/filter_tablet.dart';
import 'package:rus_katalog/Pages/ProductsList/Bodies/Components/productitem.dart';
import 'package:rus_katalog/Models/product.dart';

class TabletProductsList extends StatefulWidget {
  const TabletProductsList(
      {Key? key,
      required this.productList,
      required this.priceList,
      required this.rateList})
      : super(key: key);

  final List<Product> productList;
  final List<double> priceList;
  final List<double> rateList;

  @override
  State<TabletProductsList> createState() => _TabletProductsListState();
}

class _TabletProductsListState extends State<TabletProductsList> {
  final List<String> sortList = [
    "Популярное",
    "Сначала дешевые",
    "Сначала дорогие"
  ];
  String dropDownValue = "";
  final animationDuration = 800;
  final List<ProductItem> productList = [];

  @override
  void initState() {
    super.initState();

    dropDownValue = sortList[0];
    productList.addAll(buildProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: desktopWidth),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: singleSpace * 2),
                const Icon(Icons.filter_list_alt),
                Text("Фильтры", style: Theme.of(context).textTheme.titleMedium),
                const Expanded(child: SizedBox()),
                DropdownButton<String>(
                    style: Theme.of(context).textTheme.bodyMedium,
                    value: dropDownValue,
                    icon: const Icon(Icons.sort),
                    items:
                        sortList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                    onChanged: (String? string) {
                      setState(() {
                        dropDownValue = string!;
                        sortProducts();
                      });
                    }),
                const SizedBox(width: singleSpace * 2),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: TabletFilter(filterProducts: filterProducts)),
                Expanded(flex: 2, child: Column(children: productList)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void sortProducts() {
    if (dropDownValue == sortList[0]) {
      productList.sort(((a, b) => a.rating.compareTo(b.rating)));
    } else if (dropDownValue == sortList[1]) {
      productList.sort(((a, b) => a.price.compareTo(b.price)));
    } else {
      productList.sort(((a, b) => b.price.compareTo(a.price)));
    }
  }

  void filterProducts() {}

  List<ProductItem> buildProducts() {
    List<ProductItem> products = [];

    for (var i = 0; i < widget.productList.length; i++) {
      products.add(ProductItem(
        productId: widget.productList[i].id,
        imageUrl: "",
        label: "${widget.productList[i].brand} ${widget.productList[i].model}",
        price: widget.priceList[i].toInt(),
        rating: widget.rateList[i],
      ));
    }

    return products;
  }
}
