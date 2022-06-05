import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rus_katalog/Models/address.dart';
import 'package:rus_katalog/Models/product.dart';
import 'package:rus_katalog/Models/shop.dart';
import 'package:rus_katalog/api.dart';
import 'package:rus_katalog/constants.dart';
import 'package:rus_katalog/localdata.dart';
import './makeorder_item.dart';
import './makeorder_total.dart';

class MakeOrderDesktop extends StatefulWidget {
  const MakeOrderDesktop({Key? key, required this.isDesktop}) : super(key: key);

  final bool isDesktop;

  @override
  State<MakeOrderDesktop> createState() => _MakeOrderDesktopState();
}

class _MakeOrderDesktopState extends State<MakeOrderDesktop> {
  late Future<List<Product>> productsFuture;
  late Future<List<Shop>> shopsFuture;
  late Future<List<double>> pricesFuture;
  late Future<List<Address>> addressesFuture;
  late List<Product> products;
  late List<Shop> shops;
  late List<double> prices;
  late List<Address> addresses;
  late List<int> amount;
  bool addAddress = false;
  String currentAddress = "Добавить";
  double sum = 0;
  double delivery = Random().nextDouble() * 500.0;
  final formatter = NumberFormat("#,###");
  Widget body = const Center(child: CircularProgressIndicator());
  final cityController = TextEditingController();
  final streetController = TextEditingController();
  final houseController = TextEditingController();
  final flatController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    List data = await LocalData.getProductsInCart();
    productsFuture = Api.getProductsByIds(data[0]);
    shopsFuture = Api.getShopsByIds(data[1]);
    pricesFuture = Api.getPricesOfProducts(data[0], data[1]);
    String? token = await LocalData.getUser();
    addressesFuture = Api.getClientAdresses(token!);
    amount = data[2];

    Future.wait([productsFuture, shopsFuture, pricesFuture])
        .whenComplete(() async {
      products = await productsFuture;
      shops = await shopsFuture;
      prices = await pricesFuture;
      addresses = await addressesFuture;
      if (addresses.isNotEmpty) {
        currentAddress = addresses[0].toString();
      } else {
        addAddress = true;
      }

      for (var i = 0; i < products.length; i++) {
        sum += prices[i] * amount[i];
      }
      setState(() {
        isLoading = false;
        body = buildOrder(context);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      body = buildOrder(context);
    }
    return body;
  }

  List<DropdownMenuItem<String>> buildAddressItems() {
    List<DropdownMenuItem<String>> list =
        addresses.map<DropdownMenuItem<String>>((Address value) {
      return DropdownMenuItem<String>(
          value: value.toString(), child: Text(value.toString()));
    }).toList();
    list.add(
        const DropdownMenuItem(value: "Добавить", child: Text("Добавить")));
    return list;
  }

  Widget buildOrder(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.all(singleSpace),
              constraints: const BoxConstraints(maxWidth: desktopWidth),
              child: Column(
                children: [
                  Text("Оформление заказа",
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: singleSpace * 2),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(singleSpace * 2),
                            child: Column(children: [
                              Text("Состав заказа: ",
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: singleSpace),
                              Column(
                                children: buildCartItems(),
                              ),
                              const SizedBox(height: singleSpace),
                              Text("Адрес доставки: ",
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                              const SizedBox(height: singleSpace),
                              DropdownButton(
                                  isExpanded: true,
                                  value: currentAddress,
                                  items: buildAddressItems(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      currentAddress = newValue!;
                                      if (currentAddress == "Добавить") {
                                        addAddress = true;
                                      } else {
                                        addAddress = false;
                                      }
                                      build(context);
                                    });
                                  }),
                              Visibility(
                                visible: addAddress,
                                child: Column(children: buildAddressForm()),
                              ),
                            ]),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Card(
                          elevation: singleSpace,
                          child: Padding(
                            padding: const EdgeInsets.all(singleSpace * 2),
                            child: Column(
                              children: [
                                MakeOrderTotal(sum: sum, delivery: delivery),
                                const SizedBox(height: singleSpace * 2),
                                ElevatedButton(
                                    onPressed: () async {
                                      if (addAddress) {
                                        if (cityController.text
                                                .toString()
                                                .isNotEmpty &&
                                            streetController.text
                                                .toString()
                                                .isNotEmpty &&
                                            houseController.text
                                                .toString()
                                                .isNotEmpty &&
                                            flatController.text
                                                .toString()
                                                .isNotEmpty) {
                                          addresses.add(Address(
                                              id: 0,
                                              city: cityController.text
                                                  .toString(),
                                              street: streetController.text
                                                  .toString(),
                                              house: houseController.text
                                                  .toString(),
                                              flat: int.parse(flatController
                                                  .text
                                                  .toString())));
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                    "Заполнены не все поля адреса!",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium,
                                                  ),
                                                  backgroundColor:
                                                      kBadgeColor));
                                          return;
                                        }
                                      }
                                      String? token = await LocalData.getUser();
                                      Address address = currentAddress !=
                                              "Добавить"
                                          ? addresses.firstWhere((element) =>
                                              element.toString() ==
                                              currentAddress)
                                          : addresses.last;
                                      String result = await Api.newOrder(
                                          products.map((e) => e.id).toList(),
                                          shops.map((e) => e.id).toList(),
                                          amount,
                                          address,
                                          currentAddress == "Добавить",
                                          token!);
                                      await LocalData.clearCart();
                                      if (widget.isDesktop) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Ваш заказ №$result принят в обработку")));
                                      }
                                      Navigator.pop(context, result);
                                    },
                                    child: const Text("Оформить заказ")),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildAddressForm() {
    List<Widget> widgets = [];

    widgets.addAll([
      const SizedBox(height: singleSpace),
      TextField(
        controller: cityController,
        decoration: const InputDecoration(
            border: OutlineInputBorder(), hintText: "Город"),
      ),
      const SizedBox(height: singleSpace),
      TextField(
        controller: streetController,
        decoration: const InputDecoration(
            border: OutlineInputBorder(), hintText: "Улица"),
      ),
      const SizedBox(height: singleSpace),
      Row(
        children: [
          Flexible(
            child: TextField(
              controller: houseController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Дом"),
            ),
          ),
          const SizedBox(width: singleSpace),
          Flexible(
            child: TextField(
              controller: flatController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Квартира"),
            ),
          )
        ],
      )
    ]);

    return widgets;
  }

  List<Widget> buildCartItems() {
    List<Widget> cartItems = [];

    for (var i = 0; i < products.length; i++) {
      if (i != 0) {
        cartItems.add(const Divider());
      }
      cartItems.add(MakeOrderItem(
          product: products[i],
          shop: shops[i],
          price: prices[i],
          amount: amount[i]));
    }

    return cartItems;
  }
}
