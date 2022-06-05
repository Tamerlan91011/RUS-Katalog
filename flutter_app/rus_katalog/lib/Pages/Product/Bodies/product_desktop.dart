import 'package:rus_katalog/localdata.dart';

import 'Components/product_in_shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:rus_katalog/Models/feedback_item.dart';

import 'package:rus_katalog/Models/product.dart';
import 'package:rus_katalog/Models/products_in_shops.dart';
import 'package:rus_katalog/Models/specification.dart';
import 'package:rus_katalog/constants.dart';

class DesktopProduct extends StatefulWidget {
  const DesktopProduct(
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
  State<DesktopProduct> createState() => _DesktopProductState();
}

class _DesktopProductState extends State<DesktopProduct> {
  bool specsVisible = false;
  bool feedbacksVisible = false;
  bool pricesVisible = false;
  final int shortSpecListLength = 3;
  final int shortPriceListLength = 1;
  bool toCompare = false;
  bool isFavorite = false;
  final key1 = GlobalKey();
  final key2 = GlobalKey();
  final key3 = GlobalKey();

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
    return SingleChildScrollView(
        child: Column(children: [
      Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.all(singleSpace),
          constraints: const BoxConstraints(maxWidth: desktopWidth),
          child: Column(children: [
            const SizedBox(height: singleSpace),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("${widget.product.brand} ${widget.product.model}",
                  maxLines: 3, style: Theme.of(context).textTheme.titleLarge),
            ),
            const SizedBox(height: singleSpace * 2),
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Код товара: ${widget.product.itemNumber}",
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
            const SizedBox(height: singleSpace * 2),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: singleSpace / 2),
                    constraints: const BoxConstraints(
                        maxWidth: desktopWidth / 2,
                        maxHeight: desktopWidth / 2),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(borderRadius),
                        child: Image.network(
                            "http://$apiUrl/media/?object_id=${widget.product.id}&object_type=product",
                            fit: BoxFit.cover))),
                const SizedBox(width: singleSpace * 2),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              setState(() {
                                toCompare = !toCompare;
                                saveComparison();
                              });
                            },
                            icon: Icon(
                              toCompare
                                  ? Icons.playlist_add_check
                                  : Icons.playlist_add,
                            ),
                            label: const Text("Сравнить"),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                              saveFavorite();
                            },
                            icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                            ),
                            label: const Text("В избранное"),
                          ),
                        ],
                      ),
                      const SizedBox(height: singleSpace),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(singleSpace * 2),
                          child: Column(
                            children: [
                              Text("Цены в магазинах",
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              const SizedBox(height: singleSpace),
                              Column(
                                  children: pricesVisible
                                      ? buildPricesInShops()
                                      : (widget.priceList.isNotEmpty
                                          ? buildPricesInShops().sublist(1, 2)
                                          : [
                                              Text("Товара нет в наличии",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleMedium)
                                            ])),
                              const SizedBox(height: singleSpace),
                              Visibility(
                                visible: widget.priceList.length >
                                    shortPriceListLength,
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
                                        ? const Text("Свернуть")
                                        : const Text("Развернуть")),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: singleSpace * 2),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Card(
                      child: Padding(
                    padding: const EdgeInsets.all(singleSpace),
                    child: Column(
                        children: ListTile.divideTiles(
                                context: context, tiles: buildSectionsList())
                            .toList()),
                  )),
                ),
                const SizedBox(width: singleSpace / 2),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Card(
                        key: key1,
                        child: Padding(
                          padding: const EdgeInsets.all(singleSpace * 2),
                          child: Column(
                            children: [
                              Text("Описание",
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              const SizedBox(height: singleSpace * 2, width: desktopWidth),
                              Text(
                                widget.product.description,
                                maxLines: 20,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: singleSpace),
                      Card(
                        key: key2,
                        child: Padding(
                          padding: const EdgeInsets.all(singleSpace * 2),
                          child: Column(
                            children: [
                              Text("Характеристики",
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
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
                                        shortSpecListLength <
                                                widget.product.specList.length
                                            ? shortSpecListLength
                                            : widget.product.specList.length)),
                              ),
                              const SizedBox(width: singleSpace * 2),
                              Visibility(
                                visible: widget.product.specList.length >
                                    shortSpecListLength,
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
                                        ? const Text("Свернуть")
                                        : const Text("Развернуть")),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: singleSpace),
                      Card(
                        key: key3,
                        child: Padding(
                            padding: const EdgeInsets.all(singleSpace * 2),
                            child: Column(
                              children: [
                                Text("Отзывы",
                                    style:
                                        Theme.of(context).textTheme.titleLarge),
                                const SizedBox(height: singleSpace * 2, width: desktopWidth),
                                Column(
                                    children: feedbacksVisible
                                        ? buildFeedbacks()
                                        : (widget.feedbackList.isNotEmpty
                                            ? buildFeedbacks().sublist(1, 2)
                                            : [
                                                Text("Отзывов пока нет",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium)
                                              ])),
                                const SizedBox(height: singleSpace * 2),
                                Visibility(
                                  visible: widget.feedbackList.length >
                                      shortSpecListLength,
                                  child: TextButton.icon(
                                      onPressed: () {
                                        setState(() {
                                          feedbacksVisible = !feedbacksVisible;
                                        });
                                      },
                                      icon: feedbacksVisible
                                          ? const Icon(Icons.keyboard_arrow_up)
                                          : const Icon(
                                              Icons.keyboard_arrow_down),
                                      label: feedbacksVisible
                                          ? const Text("Свернуть")
                                          : const Text("Развернуть")),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    ]));
  }

  List<TableRow> buildSpecifications() {
    List<TableRow> rows = [];

    for (var item in widget.product.specList) {
      Specification currentSpec =
          widget.specList.firstWhere((element) => element.id == item.specId);
      rows.add(TableRow(children: [
        Text(currentSpec.name,
            maxLines: 2, style: Theme.of(context).textTheme.bodyLarge),
        Text(
            item.valueFloat != null
                ? "${item.valueFloat} ${currentSpec.units}"
                : item.valueInt != null
                    ? "${item.valueInt} ${currentSpec.units}"
                    : item.valueString != null
                        ? "${item.valueString} ${currentSpec.units}"
                        : "",
            maxLines: 2,
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
              Text(element.clientName,
                  maxLines: 3, style: Theme.of(context).textTheme.titleMedium),
              const Expanded(child: SizedBox()),
              Text("Магазин: ${element.shop.name}",
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: singleSpace * 2),
          Row(
            children: [
              Text("Оценка:", style: Theme.of(context).textTheme.titleMedium),
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
          Text("Достоинства:", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: singleSpace),
          Text(element.feedback.advantages,
              style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: singleSpace * 2),
          Text("Недостатки:", style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: singleSpace),
          Text(element.feedback.disadvantages,
              style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: singleSpace * 2),
          Text("Комментарий:", style: Theme.of(context).textTheme.titleMedium),
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

  List<ListTile> buildSectionsList() {
    List<ListTile> sectionsList = [];

    sectionsList.addAll([
      ListTile(
          onTap: () => Scrollable.ensureVisible(key1.currentContext!),
          leading: const Icon(Icons.description),
          title:
              Text("Описание", style: Theme.of(context).textTheme.titleMedium)),
      ListTile(
          onTap: () => Scrollable.ensureVisible(key2.currentContext!),
          leading: const Icon(Icons.settings_input_component),
          title: Text("Характеристики",
              style: Theme.of(context).textTheme.titleMedium)),
      ListTile(
          onTap: () => Scrollable.ensureVisible(key3.currentContext!),
          leading: const Icon(Icons.feedback),
          title: Text("Отзывы", style: Theme.of(context).textTheme.titleMedium))
    ]);

    return sectionsList;
  }
}
