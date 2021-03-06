import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:rus_katalog/Models/shop.dart';
import 'package:rus_katalog/constants.dart';
import 'package:rus_katalog/localdata.dart';

class MobileProductItem extends StatefulWidget {
  const MobileProductItem(
      {Key? key,
      required this.productId,
      required this.imageUrl,
      required this.shop,
      required this.price,
      required this.availableAmount})
      : super(key: key);

  final int productId;
  final String imageUrl;
  final Shop shop;
  final double price;
  final int availableAmount;

  @override
  State<MobileProductItem> createState() => _MobileProductItemState();
}

class _MobileProductItemState extends State<MobileProductItem> {
  final minWidth = 381;
  final formatter = NumberFormat("#,###");
  bool toCompare = false;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    toCompare = await LocalData.getComparison(widget.productId);
    isFavorite = await LocalData.getFavorite(widget.productId);
    setState(() {});
  }

  void saveComparison() async {
    LocalData.saveComparison(widget.productId, toCompare);
  }

  void saveFavorite() async {
    LocalData.saveFavorite(widget.productId, isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: singleSpace),
        Row(
          children: [
            const SizedBox(width: singleSpace),
            Text(widget.shop.name,
                style: Theme.of(context).textTheme.titleMedium),
            const Expanded(child: SizedBox()),
            RatingBarIndicator(
                rating: widget.shop.rating,
                itemSize: 25,
                itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    )),
            const SizedBox(width: singleSpace),
          ],
        ),
        const SizedBox(height: singleSpace),
        Row(
          children: [
            const SizedBox(width: singleSpace),
            Text("${formatter.format(widget.price).replaceAll(',', ' ')} ??",
                style: Theme.of(context).textTheme.titleMedium),
            const Expanded(child: SizedBox()),
            ElevatedButton.icon(
                onPressed: () {
                  LocalData.saveProductToCart(
                      widget.productId, widget.shop.id, true);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("?????????? ?????????????? ???????????????? ?? ??????????????!")));
                },
                label: const Text("?? ??????????????"),
                icon: const Icon(Icons.shopping_cart)),
            const SizedBox(width: singleSpace),
          ],
        ),
        const SizedBox(height: singleSpace),
      ],
    );
  }
}
