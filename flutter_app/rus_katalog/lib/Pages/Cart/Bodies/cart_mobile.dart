import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rus_katalog/Models/product.dart';
import 'package:rus_katalog/Models/shop.dart';
import 'package:rus_katalog/api.dart';
import 'package:rus_katalog/constants.dart';
import 'package:rus_katalog/localdata.dart';
import '../cart_item.dart';

// Виджет корзины для мобильных устройств
class MobileCart extends StatefulWidget {
  const MobileCart({Key? key}) : super(key: key);

  @override
  _MobileCartState createState() => _MobileCartState();
}

class _MobileCartState extends State<MobileCart> {
  String query = "";
  late Future<List<Product>> productsFuture;
  late Future<List<Shop>> shopsFuture;
  late Future<List<double>> pricesFuture;
  late List<Product> products;
  late List<Shop> shops;
  late List<double> prices;
  late List<int> amount;
  double sum = 0;
  final formatter = NumberFormat("#,###");
  Widget body = const Center(child: CircularProgressIndicator());
  bool isAuth = false;

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
    amount = data[2];
    isAuth = await LocalData.getUser() != null;

    Future.wait([productsFuture, shopsFuture, pricesFuture])
        .whenComplete(() async {
      products = await productsFuture;
      shops = await shopsFuture;
      prices = await pricesFuture;
      for (var i = 0; i < products.length; i++) {
        sum += prices[i] * amount[i];
      }
      setState(() {
        if (products.isNotEmpty) {
          body = buildCart(context);
        } else {
          body = Center(
              child: Text("В корзине ничего нет",
                  style: Theme.of(context).textTheme.titleLarge));
        }
      });
    });
  }

  void calculateSum() {
    sum = 0;
    for (var i = 0; i < products.length; i++) {
      sum += prices[i] * amount[i];
    }
  }

  void calculatePrice(int productId, int shopId, int num) {
    for (var i = 0; i < products.length; i++) {
      if (products[i].id == productId && shops[i].id == shopId) {
        if (num == 0) {
          products.removeAt(i);
          shops.removeAt(i);
          amount.removeAt(i);
        } else {
          amount[i] = num;
        }
      }
    }
    calculateSum();
    setState(() {
      if (products.isNotEmpty) {
        body = buildCart(context);
      } else {
        body = Center(
            child: Text("В корзине ничего нет",
                style: Theme.of(context).textTheme.titleLarge));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return body;
  }

  List<Widget> buildCartItems() {
    List<Widget> cartItems = [];

    for (var i = 0; i < products.length; i++) {
      cartItems.add(CartItem(
          product: products[i],
          shop: shops[i],
          price: prices[i],
          amount: amount[i],
          calculatePrice: calculatePrice));
    }

    return cartItems;
  }

  Widget buildCart(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: singleSpace,
          ),
          Column(children: buildCartItems()),
          Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              elevation: standartElevation,
              child: Container(
                padding: const EdgeInsets.all(singleSpace * 2),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Итого ",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                        const Expanded(child: SizedBox()),
                        Text("${formatter.format(sum).replaceAll(',', ' ')} Р",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(
                      height: singleSpace * 2,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (!isAuth) {
                          Navigator.pushNamed(context, "/login");
                        } else {
                          String? result =
                              await Navigator.pushNamed(context, "/makeorder")
                                  as String?;
                          if (result != null) {
                            setState(() {
                              body = Center(
                                  child: Text(
                                      "Ваш заказ №$result принят в обработку",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge));
                            });
                          }
                        }
                      },
                      child: const Text("Перейти к оформлению"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: singleSpace * 2,
          ),
        ],
      ),
    );
  }
}
