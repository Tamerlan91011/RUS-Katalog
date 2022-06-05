import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:rus_katalog/constants.dart';
import 'package:rus_katalog/localdata.dart';

class MobileProductItem extends StatefulWidget {
  const MobileProductItem(
      {Key? key,
      required this.productId,
      required this.imageUrl,
      required this.label,
      required this.price,
      required this.rating})
      : super(key: key);

  final int productId;
  final String imageUrl;
  final String label;
  final int price;
  final double rating;

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
    return Container(
      margin: const EdgeInsets.fromLTRB(singleSpace / 2, 0, singleSpace, 0),
      constraints: const BoxConstraints(
          maxWidth: desktopWidth, maxHeight: 128 + singleSpace * 9),
      child: Card(
        elevation: standartElevation,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, "/product/${widget.productId}");
          },
          child: Padding(
            padding: const EdgeInsets.all(singleSpace),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Row(children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 128,
                        width: 128,
                        constraints:
                            const BoxConstraints(maxHeight: 128, maxWidth: 128),
                        decoration: BoxDecoration(
                            color: kGrayColor,
                            borderRadius: BorderRadius.circular(borderRadius)),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(borderRadius),
                            child: Image.network(
                                "http://$apiUrl/media/?object_id=${widget.productId}&object_type=product",
                                fit: BoxFit.cover)),
                      ),
                    ),
                    const SizedBox(width: singleSpace * 2),
                    Expanded(
                        flex: 2,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.label,
                                style: Theme.of(context).textTheme.titleMedium,
                                maxLines: 3,
                              ),
                              const SizedBox(height: singleSpace),
                              RatingBarIndicator(
                                  rating: widget.rating,
                                  itemSize: 25,
                                  itemBuilder: (context, index) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      )),
                              const Expanded(child: SizedBox()),
                              Text(
                                  "от ${formatter.format(widget.price).replaceAll(',', ' ')} Р",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontWeight: FontWeight.bold)),
                              const Expanded(child: SizedBox()),
                            ])),
                  ]),
                ),
                const SizedBox(height: singleSpace),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  MediaQuery.of(context).size.width > minWidth
                      ? TextButton.icon(
                          onPressed: () {
                            setState(() {
                              toCompare = !toCompare;
                            });
                            saveComparison();
                          },
                          icon: Icon(
                            toCompare
                                ? Icons.playlist_add_check
                                : Icons.playlist_add,
                          ),
                          label: const Text("Сравнить"),
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              toCompare = !toCompare;
                            });
                            saveComparison();
                          },
                          icon: Icon(
                            toCompare
                                ? Icons.playlist_add_check
                                : Icons.playlist_add,
                          ),
                        ),
                  MediaQuery.of(context).size.width > minWidth
                      ? TextButton.icon(
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
                        )
                      : IconButton(
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
                        ),
                ]),
                const SizedBox(height: singleSpace / 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
