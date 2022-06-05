import 'package:flutter/material.dart';
import 'package:rus_katalog/Pages/Components/AppBar/appbar_desktop.dart';
import 'package:rus_katalog/Pages/ProductsList/Bodies/productslist_desktop.dart';

import '../../../Models/product.dart';

class DesktopProductsListScreen extends StatefulWidget {
  const DesktopProductsListScreen(
      {Key? key,
      required this.productList,
      required this.priceList,
      required this.rateList})
      : super(key: key);

  final List<Product> productList;
  final Future<List<double>> priceList;
  final Future<List<double>> rateList;

  @override
  State<DesktopProductsListScreen> createState() =>
      _DesktopProductsListScreenState();
}

class _DesktopProductsListScreenState extends State<DesktopProductsListScreen> {
  Widget body = const Center(child: CircularProgressIndicator());

  @override
  void initState() {
    super.initState();

    Future.wait([widget.priceList, widget.rateList])
        .whenComplete(() async {
      body = DesktopProductsList(
          productList: widget.productList,
          priceList: await widget.priceList,
          rateList: await widget.rateList);
          setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: const DesktopAppBar(), body: body);
  }
}
