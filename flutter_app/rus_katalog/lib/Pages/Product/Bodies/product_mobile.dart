import 'package:rus_katalog/localdata.dart';

import 'Components/product_in_shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rus_katalog/Models/feedback_item.dart';

import 'package:rus_katalog/Models/product.dart';
import 'package:rus_katalog/Models/products_in_shops.dart';
import 'package:rus_katalog/Models/specification.dart';
import 'package:rus_katalog/constants.dart';

class MobileProduct extends StatefulWidget {
  const MobileProduct(
      {Key? key,
      required this.product,
      required this.specList,
      required this.feedbackList,
      required this.priceList})
      : super(key: key);

  final Product product;
  final List<Specification> specList;
  final List<FeedbackItem> feedbackList;
  final List<ProductsInShops> priceList;

  @override
  State<MobileProduct> createState() => _MobileProductState();
}

class _MobileProductState extends State<MobileProduct> {
  bool specsVisible = false;
  bool feedbacksVisible = false;
  bool pricesVisible = false;
  final int shortSpecListLength = 3;
  final int shortPriceListLength = 1;
  bool toCompare = false;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    toCompare = await LocalData.getComparison(widget.product.id);
    isFavorite = await LocalData.getFavorite(widget.product.id);
    setState(() {});
  }

  void saveComparison() async {
    LocalData.saveComparison(widget.product.id, toCompare);
  }

  void saveFavorite() async {
    LocalData.saveFavorite(widget.product.id, isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(singleSpace),
        child: SingleChildScrollView(
            child: Column(children: [
          const SizedBox(height: singleSpace),
          Text("${widget.product.brand} ${widget.product.model}",
              maxLines: 3, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: singleSpace * 2),
          Text("?????? ????????????: ${widget.product.itemNumber}",
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: singleSpace * 2),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: singleSpace / 2),
            constraints: BoxConstraints(
                maxWidth: desktopWidth,
                maxHeight: (MediaQuery.of(context).size.width) / 1.2),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Image.network(
                    "http://$apiUrl/media/?object_id=${widget.product.id}&object_type=product",
                    fit: BoxFit.cover)),
          ),
          const SizedBox(height: singleSpace),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    toCompare = !toCompare;
                    saveComparison();
                  });
                },
                icon: Icon(
                  toCompare ? Icons.playlist_add_check : Icons.playlist_add,
                ),
                label: const Text("????????????????"),
              ),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                  saveFavorite();
                },
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_outline,
                ),
                label: const Text("?? ??????????????????"),
              ),
            ],
          ),
          const SizedBox(height: singleSpace * 2),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(singleSpace * 2),
              child: Column(
                children: [
                  Text("???????? ?? ??????????????????",
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: singleSpace * 2),
                  Column(
                      children: pricesVisible
                          ? buildPricesInShops()
                          : (widget.priceList.isNotEmpty
                              ? buildPricesInShops().sublist(1, 2)
                              : [
                                  Text("???????????? ?????? ?? ??????????????",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium)
                                ])),
                  const SizedBox(height: singleSpace * 2),
                  Visibility(
                    visible: widget.priceList.length > shortPriceListLength,
                    child: TextButton.icon(
                        onPressed: () {
                          setState(() {
                            pricesVisible = !pricesVisible;
                          });
                        },
                        icon: pricesVisible
                            ? const Icon(Icons.keyboard_arrow_up)
                            : const Icon(Icons.keyboard_arrow_down),
                        label: pricesVisible
                            ? const Text("????????????????")
                            : const Text("????????????????????")),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: singleSpace * 2),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(singleSpace * 2),
              child: Column(
                children: [
                  Text("????????????????",
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: singleSpace * 2, width: desktopWidth),
                  Text(
                    widget.product.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: singleSpace),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(singleSpace * 2),
              child: Column(
                children: [
                  Text("????????????????????????????",
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: singleSpace * 2, width: desktopWidth),
                  Visibility(
                    visible: specsVisible,
                    child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: buildSpecifications()),
                  ),
                  Visibility(
                    visible: !specsVisible,
                    child: Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: buildSpecifications().sublist(
                            0,
                            shortSpecListLength < widget.product.specList.length
                                ? shortSpecListLength
                                : widget.product.specList.length)),
                  ),
                  const SizedBox(height: singleSpace * 2),
                  Visibility(
                    visible:
                        widget.product.specList.length > shortSpecListLength,
                    child: TextButton.icon(
                        onPressed: () {
                          setState(() {
                            specsVisible = !specsVisible;
                          });
                        },
                        icon: specsVisible
                            ? const Icon(Icons.keyboard_arrow_up)
                            : const Icon(Icons.keyboard_arrow_down),
                        label: specsVisible
                            ? const Text("????????????????")
                            : const Text("????????????????????")),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: singleSpace),
          Card(
            child: Padding(
                padding: const EdgeInsets.all(singleSpace * 2),
                child: Column(
                  children: [
                    Text("????????????",
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: singleSpace * 2, width: desktopWidth),
                    Column(
                        children: feedbacksVisible
                            ? buildFeedbacks()
                            : (widget.feedbackList.isNotEmpty
                                ? buildFeedbacks().sublist(1, 2)
                                : [
                                    Text("?????????????? ???????? ??????",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium)
                                  ])),
                    const SizedBox(height: singleSpace * 2),
                    Visibility(
                      visible: widget.feedbackList.length > shortSpecListLength,
                      child: TextButton.icon(
                          onPressed: () {
                            setState(() {
                              feedbacksVisible = !feedbacksVisible;
                            });
                          },
                          icon: feedbacksVisible
                              ? const Icon(Icons.keyboard_arrow_up)
                              : const Icon(Icons.keyboard_arrow_down),
                          label: feedbacksVisible
                              ? const Text("????????????????")
                              : const Text("????????????????????")),
                    )
                  ],
                )),
          ),
        ])));
  }

  List<TableRow> buildSpecifications() {
    List<TableRow> rows = [];

    for (var item in widget.product.specList) {
      Specification currentSpec =
          widget.specList.firstWhere((element) => element.id == item.specId);
      rows.add(TableRow(children: [
        Text(currentSpec.name,
            style: Theme.of(context).textTheme.bodyLarge),
        Text(
            item.valueFloat != null
                ? "${item.valueFloat} ${currentSpec.units}"
                : item.valueInt != null
                    ? "${item.valueInt} ${currentSpec.units}"
                    : item.valueString != null
                        ? "${item.valueString} ${currentSpec.units}"
                        : "",
            style: Theme.of(context).textTheme.bodyLarge)
      ]));
    }

    return rows;
  }

  List<Widget> buildFeedbacks() {
    List<Widget> feedbacks = [];

    feedbacks.add(const Divider());
    for (var element in widget.feedbackList) {
      feedbacks.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: singleSpace * 2),
          Row(
            children: [
              Visibility(
                visible: MediaQuery.of(context).size.width > 400,
                child: Text(element.clientName,
                    maxLines: 3,
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              Visibility(
                visible: MediaQuery.of(context).size.width <= 400,
                child: Text(
                    "${element.clientName.split(' ')[0]} ${element.clientName.split(' ')[1][0]}.",
                    maxLines: 3,
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              const Expanded(child: SizedBox()),
              Text("??????????????: ${element.shop.name}",
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: singleSpace * 2),
          Row(
            children: [
              Text("????????????:", style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(width: singleSpace),
              RatingBarIndicator(
                  rating: element.feedback.rating,
                  itemSize: 25,
                  itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      )),
            ],
          ),
          const SizedBox(height: singleSpace * 2),
          Text("??????????????????????:", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: singleSpace),
          Text(element.feedback.advantages,
              style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: singleSpace * 2),
          Text("????????????????????:", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: singleSpace),
          Text(element.feedback.disadvantages,
              style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: singleSpace * 2),
          Text("??????????????????????:", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: singleSpace),
          Text(element.feedback.comment,
              style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: singleSpace),
        ],
      ));
      feedbacks.add(const Divider());
    }

    return feedbacks;
  }

  List<Widget> buildPricesInShops() {
    List<Widget> prices = [];

    prices.add(const Divider());
    for (var element in widget.priceList) {
      prices.add(ProductItem(
          productId: element.productId,
          imageUrl: "",
          shop: element.shop,
          price: element.price,
          availableAmount: element.availableAmount));
      prices.add(const Divider());
    }

    return prices;
  }
}
