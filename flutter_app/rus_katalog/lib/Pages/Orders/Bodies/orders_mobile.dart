import 'package:flutter/material.dart';
import 'package:rus_katalog/api.dart';
import 'package:rus_katalog/constants.dart';
import 'package:rus_katalog/localdata.dart';
import 'order_item_mobile.dart';

class OrdersMobile extends StatefulWidget {
  const OrdersMobile({Key? key}) : super(key: key);

  @override
  State<OrdersMobile> createState() => _OrdersMobileState();
}

class _OrdersMobileState extends State<OrdersMobile> {
  late List data;
  Widget body = const Center(child: CircularProgressIndicator());
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    String? token = await LocalData.getUser();
    data = await Api.getOrdersOfClient(token!);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      body = buildOrders(context);
    }
    return body;
  }

  Widget buildOrders(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        const SizedBox(height: singleSpace),
        Text("Заказы", style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: singleSpace * 2),
        Column(children: buildOrdersItems()),
      ]),
    );
  }

  List<Widget> buildOrdersItems() {
    List<Widget> widgets = [];

    for (var i = 0; i < data.length; i++) {
      widgets.add(OrderItemMobile(
          order: data[i]['order'],
          products: data[i]['products'],
          shops: data[i]['shops'],
          prices: data[i]['prices'],
          amount: data[i]['amount']));
    }

    return widgets;
  }
}
