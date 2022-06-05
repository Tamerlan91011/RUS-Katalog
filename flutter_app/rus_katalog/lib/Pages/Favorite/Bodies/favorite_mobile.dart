import 'package:flutter/material.dart';

import 'package:rus_katalog/Models/product.dart';
import 'package:rus_katalog/api.dart';
import 'package:rus_katalog/constants.dart';
import '../Components/favoriteitem.dart';
import 'package:rus_katalog/localdata.dart';

class MobileFavorite extends StatefulWidget {
  const MobileFavorite({Key? key}) : super(key: key);

  @override
  State<MobileFavorite> createState() => _MobileFavoriteState();
}

class _MobileFavoriteState extends State<MobileFavorite> {
  List<Product> productList = [];
  List<double> priceList = [];
  List<double> rateList = [];
  List<Widget> favoriteList = [];
  bool isLoading = true;

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
      favoriteList.add(FavoriteItem(
        productId: productList[i].id,
        imageUrl: "",
        label: "${productList[i].brand} ${productList[i].model}",
        price: priceList[i].toInt(),
        rating: rateList[i],
        removeItem: removeItem,
      ));
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
      favoriteList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? favoriteList.isNotEmpty
            ? Container(
                margin: const EdgeInsets.all(singleSpace),
                child: SingleChildScrollView(
                  child: Column(
                    children: favoriteList,
                  ),
                ))
            : Center(
                child: Text("В избранном ничего нет!",
                    style: Theme.of(context).textTheme.titleLarge))
        : const Center(child: CircularProgressIndicator());
  }
}
