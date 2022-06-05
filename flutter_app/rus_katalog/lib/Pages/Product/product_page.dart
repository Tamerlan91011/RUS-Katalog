import 'package:flutter/material.dart';
import 'package:rus_katalog/Models/feedback_item.dart';
import 'package:rus_katalog/Models/products_in_shops.dart';
import 'package:rus_katalog/Models/specification.dart';

import 'package:rus_katalog/responsive.dart';
import 'Screens/product_screen_mobile.dart';
import 'Screens/product_screen_tablet.dart';
import 'Screens/product_screen_desktop.dart';
import 'package:rus_katalog/api.dart';
import 'package:rus_katalog/Models/product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, this.productId}) : super(key: key);

  final int? productId;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Future<Product>? product;
  Future<List<Specification>>? speclist;
  Future<List<FeedbackItem>>? feedbackList;
  Future<List<ProductsInShops>>? priceList;

  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    product = Api.getProductById(widget.productId!);
    speclist = Api.getSpecifications();
    feedbackList = Api.getFeedbacksByProductId(widget.productId!);
    priceList = Api.getPricesOfProduct(widget.productId!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (product != null && speclist != null && feedbackList != null)
        ? ResponsiveLayout(
            mobile: MobileProductScreen(
                product: product!,
                specList: speclist!,
                feedbackList: feedbackList!,
                priceList: priceList!),
            tablet: TabletProductScreen(
                product: product!,
                specList: speclist!,
                feedbackList: feedbackList!,
                priceList: priceList!),
            desktop: DesktopProductScreen(
                product: product!,
                specList: speclist!,
                feedbackList: feedbackList!,
                priceList: priceList!))
        : const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
