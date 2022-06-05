import 'package:flutter/material.dart';
import 'package:rus_katalog/Models/feedback_item.dart';
import 'package:rus_katalog/Models/product.dart';
import 'package:rus_katalog/Models/products_in_shops.dart';
import 'package:rus_katalog/Models/specification.dart';
import 'package:rus_katalog/Pages/Components/AppBar/appbar_desktop.dart';

import '../Bodies/product_desktop.dart';

class DesktopProductScreen extends StatefulWidget {
  const DesktopProductScreen(
      {Key? key,
      required this.product,
      required this.specList,
      required this.feedbackList,
      required this.priceList})
      : super(key: key);

  final Future<Product> product;
  final Future<List<Specification>> specList;
  final Future<List<FeedbackItem>> feedbackList;
  final Future<List<ProductsInShops>> priceList;

  @override
  State<DesktopProductScreen> createState() => _DesktopProductScreenState();
}

class _DesktopProductScreenState extends State<DesktopProductScreen> {
  Widget body = const Center(child: CircularProgressIndicator());

  @override
  void initState() {
    super.initState();

    Future.wait([widget.product, widget.specList]).whenComplete(() async {
      body = DesktopProduct(
          product: await widget.product,
          specList: await widget.specList,
          feedbackList: await widget.feedbackList,
          priceList: await widget.priceList);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DesktopAppBar(),
      body: body,
    );
  }
}
