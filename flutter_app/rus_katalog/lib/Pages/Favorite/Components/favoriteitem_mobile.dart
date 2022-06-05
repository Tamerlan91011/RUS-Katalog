import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:rus_katalog/constants.dart';
import 'package:rus_katalog/localdata.dart';

class MobileFavoriteItem extends StatefulWidget {
  const MobileFavoriteItem(
      {Key? key,
      required this.productId,
      required this.imageUrl,
      required this.label,
      required this.price,
      required this.rating,
      required this.removeItem,
      required this.minWidth,
      this.showFavoriteOverlay})
      : super(key: key);

  final int productId;
  final String imageUrl;
  final String label;
  final int price;
  final double rating;
  final void Function(int id) removeItem;
  final double minWidth;
  final void Function()? showFavoriteOverlay;

  @override
  State<MobileFavoriteItem> createState() => _MobileFavoriteItemState();
}

class _MobileFavoriteItemState extends State<MobileFavoriteItem> {
  bool toCompare = false;
  var formatter = NumberFormat("#,###");

  @override
  void initState() {
    super.initState();

    getData();
  }

  void getData() async {
    toCompare = await LocalData.getComparison(widget.productId);
    setState(() {});
  }

  void saveComparison() async {
    LocalData.saveComparison(widget.productId, toCompare);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
          maxWidth: desktopWidth, maxHeight: 128 + singleSpace * 9),
      child: Card(
        elevation: standartElevation,
        child: InkWell(
          onTap: () {
            if (widget.showFavoriteOverlay != null) {
              widget.showFavoriteOverlay!();
            }
            Navigator.pushNamed(context, "/product/${widget.productId}");
          },
          child: Padding(
            padding: const EdgeInsets.all(singleSpace),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Row(children: [
                    Container(
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
                  MediaQuery.of(context).size.width > widget.minWidth
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
                  MediaQuery.of(context).size.width > widget.minWidth
                      ? TextButton.icon(
                          onPressed: () {
                            widget.removeItem(widget.productId);
                          },
                          icon: const Icon(Icons.delete),
                          label: const Text("Удалить"),
                        )
                      : IconButton(
                          onPressed: () {
                            widget.removeItem(widget.productId);
                          },
                          icon: const Icon(Icons.delete),
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
