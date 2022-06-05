import 'package:flutter/material.dart';
import 'package:rus_katalog/api.dart';
import 'package:rus_katalog/constants.dart';
import 'package:rus_katalog/localdata.dart';
import 'order_item_desktop.dart';

class OrdersDesktop extends StatefulWidget {
  const OrdersDesktop({Key? key}) : super(key: key);

  @override
  State<OrdersDesktop> createState() => _OrdersDesktopState();
}

class _OrdersDesktopState extends State<OrdersDesktop> {
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
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.all(singleSpace),
              constraints: const BoxConstraints(maxWidth: desktopWidth),
              child: Column(children: [
                Text("Заказы", style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: singleSpace * 2),
                Column(children: buildOrdersItems()),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildOrdersItems() {
    List<Widget> widgets = [];

    for (var i = 0; i < data.length; i++) {
      widgets.add(OrderItemDesktop(
          order: data[i]['order'],
          products: data[i]['products'],
          shops: data[i]['shops'],
          prices: data[i]['prices'],
          amount: data[i]['amount']));
    }

    return widgets;
  }
}
