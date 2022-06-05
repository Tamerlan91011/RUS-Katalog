import 'package:flutter/material.dart';

import 'package:rus_katalog/Models/product.dart';
import 'package:rus_katalog/api.dart';
import 'package:rus_katalog/localdata.dart';
import '../Components/favoriteitem.dart';
import 'package:rus_katalog/constants.dart';

class DesktopFavorite extends StatefulWidget {
  const DesktopFavorite({Key? key, required this.showFavoriteOverlay})
      : super(key: key);

  final void Function() showFavoriteOverlay;

  @override
  State<DesktopFavorite> createState() => _DesktopFavoriteState();
}

class _DesktopFavoriteState extends State<DesktopFavorite> {
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
      favoriteList.add(Container(
          constraints:
              const BoxConstraints(maxWidth: desktopWidth / 3 - singleSpace),
          child: FavoriteItem(
            productId: productList[i].id,
            imageUrl: "",
            label: "${productList[i].brand} ${productList[i].model}",
            price: priceList[i].toInt(),
            rating: rateList[i],
            removeItem: removeItem,
            showFavoriteOverlay: widget.showFavoriteOverlay,
          )));
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
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
          padding: const EdgeInsets.all(singleSpace),
          constraints: const BoxConstraints(maxWidth: desktopWidth),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: Theme.of(context).primaryColor.withOpacity(opacity)),
          child: !isLoading
              ? favoriteList.isNotEmpty
                  ? SingleChildScrollView(
                      child: Column(children: [
                      Text("Избранное",
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: singleSpace),
                      Wrap(
                        children: favoriteList,
                      ),
                    ]))
                  : Center(
                      child: Text("В избранном ничего нет!",
                          style: Theme.of(context).textTheme.titleLarge))
              : const Center(child: CircularProgressIndicator()),
        ));
  }
}
