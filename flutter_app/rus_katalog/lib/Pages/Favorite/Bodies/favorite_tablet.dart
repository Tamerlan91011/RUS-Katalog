import 'package:flutter/material.dart';

import 'package:rus_katalog/Models/product.dart';
import 'package:rus_katalog/api.dart';
import 'package:rus_katalog/constants.dart';
import '../Components/favoriteitem.dart';
import 'package:rus_katalog/localdata.dart';

class TabletFavorite extends StatefulWidget {
  const TabletFavorite({Key? key}) : super(key: key);

  @override
  State<TabletFavorite> createState() => _TabletFavoriteState();
}

class _TabletFavoriteState extends State<TabletFavorite> {
  List<Product> productList = [];
  List<double> priceList = [];
  List<double> rateList = [];
  List<Widget> favoriteList = [];
  bool isLoading = true;
  late double width = MediaQuery.of(context).size.width;

  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    List<int> idList = await LocalData.getFavoriteList();
    for (var id in idList) {
      productList.add(await Api.getProductById(id));
    }
    priceList.addAll(await Api.getMinPricesOfProducts(idList));
    rateList.addAll(await Api.getRatingOfProducts(idList));

    buildFavorites();
  }

  void buildFavorites() {
    for (var i = 0; i < productList.length; i++) {
      if (i + 1 < productList.length) {
        favoriteList.add(Container(
            constraints: const BoxConstraints(maxWidth: desktopWidth),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Expanded(
                  child: FavoriteItem(
                productId: productList[i].id,
                imageUrl: "",
                label: "${productList[i].brand} ${productList[i].model}",
                price: priceList[i].toInt(),
                rating: rateList[i],
                removeItem: removeItem,
                minWidth: 704,
              )),
              Expanded(
                  child: FavoriteItem(
                productId: productList[i + 1].id,
                imageUrl: "",
                label:
                    "${productList[i + 1].brand} ${productList[i + 1].model}",
                price: priceList[i + 1].toInt(),
                rating: rateList[i + 1],
                removeItem: removeItem,
                minWidth: 704,
              )),
            ])));

        i++;
      } else {
        favoriteList.add(Row(children: [
          Expanded(
              child: FavoriteItem(
            productId: productList[i].id,
            imageUrl: "",
            label: "${productList[i].brand} ${productList[i].model}",
            price: priceList[i].toInt(),
            rating: rateList[i],
            removeItem: removeItem,
            minWidth: 704,
          )),
          const Expanded(child: SizedBox()),
        ]));
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  void removeItem(int id) {
    LocalData.saveFavorite(id, false);
    int index = productList.indexWhere((element) => element.id == id);
    productList.removeAt(index);
    priceList.removeAt(index);
    rateList.removeAt(index);
    setState(() {
      favoriteList.clear();
      buildFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return !isLoading
        ? favoriteList.isNotEmpty
            ? Container(
                margin: const EdgeInsets.all(singleSpace),
                child: SingleChildScrollView(
                  child: Column(children: favoriteList),
                ))
            : Center(
                child: Text("В избранном ничего нет!",
                    style: Theme.of(context).textTheme.titleLarge))
        : const Center(child: CircularProgressIndicator());
  }
}
