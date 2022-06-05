import 'package:flutter/material.dart';

import '../../../Models/product.dart';
import '../../../constants.dart';
import 'Components/productitem.dart';
import 'Components/filter_tablet.dart';

class DesktopProductsList extends StatefulWidget {
  const DesktopProductsList(
      {Key? key,
      required this.productList,
      required this.priceList,
      required this.rateList})
      : super(key: key);

  final List<Product> productList;
  final List<double> priceList;
  final List<double> rateList;

  @override
  State<DesktopProductsList> createState() => _DesktopProductsListState();
}

class _DesktopProductsListState extends State<DesktopProductsList> {
  final List<String> sortList = [
    "Популярное",
    "Сначала дешевые",
    "Сначала дорогие"
  ];
  String dropDownValue = "";
  final animationDuration = 800;

  @override
  void initState() {
    super.initState();

    dropDownValue = sortList[0];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      Align(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(maxWidth: desktopWidth),
          child: Column(children: [
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
                Expanded(flex: 2, child: Column(children: buildProducts())),
              ],
            ),
          ]),
        ),
      ),
    ]));
  }

  void filterProducts() {}

  List<Widget> buildProducts() {
    List<Widget> products = [];

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
