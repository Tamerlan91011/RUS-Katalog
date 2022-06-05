import 'package:flutter/material.dart';
import 'package:rus_katalog/Models/order.dart';
import 'package:rus_katalog/Models/shop.dart';
import 'package:rus_katalog/constants.dart';

import '../../../Models/product.dart';
import './product_item.dart';

class OrderItemDesktop extends StatelessWidget {
  const OrderItemDesktop(
      {Key? key,
      required this.order,
      required this.products,
      required this.shops,
      required this.prices,
      required this.amount})
      : super(key: key);

  final Order order;
  final List<Product> products;
  final List<Shop> shops;
  final List<double> prices;
  final List<int> amount;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(singleSpace * 2),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Информация о заказе:",
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: singleSpace * 2),
                  Text("Заказ №${order.id} - от ${order.date}",
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: singleSpace),
                  Text("Статус: ${order.status}",
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: singleSpace),
                  Text("Адрес доставки: ${order.deliveryAddress}",
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              )),
          const SizedBox(width: singleSpace),
          Expanded(
              flex: 2,
              child: Column(
                children: [
                  Text("Состав заказа:",
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: singleSpace * 2),
                  Column(
                    children: buildProductsInShops(),
                  )
                ],
              )),
        ]),
      ),
    );
  }

  List<Widget> buildProductsInShops() {
    List<Widget> widgets = [];

    for (var i = 0; i < products.length; i++) {
      if (i != 0) {
        widgets.add(const Divider());
      }
      widgets.add(ProductInShopItem(
          product: products[i],
          shop: shops[i],
          price: prices[i],
          amount: amount[i]));
    }

    return widgets;
  }
}
