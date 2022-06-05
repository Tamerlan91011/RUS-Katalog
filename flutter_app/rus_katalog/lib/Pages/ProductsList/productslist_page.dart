import 'package:flutter/material.dart';

import 'package:rus_katalog/responsive.dart';
import './Screens/productslist_screen_mobile.dart';
import './Screens/productslist_screen_tablet.dart';
import './Screens/productslist_screen_desktop.dart';
import 'package:rus_katalog/api.dart';
import '../../Models/product.dart';

class ProductsListPage extends StatefulWidget {
  const ProductsListPage({Key? key, this.categoryId}) : super(key: key);

  final int? categoryId;

  @override
  State<ProductsListPage> createState() => _ProductsListPageState();
}

class _ProductsListPageState extends State<ProductsListPage> {
  List<Product>? productList;
  Future<List<double>>? priceList;
  Future<List<double>>? rateList;

  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    productList = await Api.getProductsByCategoryId(widget.categoryId!);

    List<int>? productId = productList?.map((e) => e.id).toList();
    priceList = Api.getMinPricesOfProducts(productId!);
    rateList = Api.getRatingOfProducts(productId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (productList != null && priceList != null && rateList != null)
        ? ResponsiveLayout(
            mobile: MobileProductsListScreen(
                productList: productList!,
                priceList: priceList!,
                rateList: rateList!),
            tablet: TabletProductsListScreen(
                productList: productList!,
                priceList: priceList!,
                rateList: rateList!),
            desktop: DesktopProductsListScreen(
                productList: productList!,
                priceList: priceList!,
                rateList: rateList!))
        : const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
