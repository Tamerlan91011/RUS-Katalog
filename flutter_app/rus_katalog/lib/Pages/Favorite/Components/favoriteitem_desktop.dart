import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:rus_katalog/constants.dart';
import 'package:rus_katalog/localdata.dart';

class DesktopFavoriteItem extends StatefulWidget {
  const DesktopFavoriteItem(
      {Key? key,
      required this.productId,
      required this.imageUrl,
      required this.label,
      required this.price,
      required this.rating,
      required this.removeItem,
      this.showFavoriteOverlay})
      : super(key: key);

  final int productId;
  final String imageUrl;
  final String label;
  final int price;
  final double rating;
  final void Function(int id) removeItem;
  final void Function()? showFavoriteOverlay;

  @override
  State<DesktopFavoriteItem> createState() => _DesktopFavoriteItemState();
}

class _DesktopFavoriteItemState extends State<DesktopFavoriteItem> {
  final formatter = NumberFormat("#,###");
  bool toCompare = false;

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
      constraints:
          const BoxConstraints(maxWidth: desktopWidth, maxHeight: 128 + 8 * 2),
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
            child: Row(
              children: [
                Container(
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
                      // Container(
                      //   child: Row(
                      //     children: [
                      //       Checkbox(
                      //           value: widget.toCompare,
                      //           onChanged: (isChecked) {
                      //             setState(() {
                      //               widget.toCompare = isChecked!;
                      //             });
                      //           }),
                      //       Text("Сравнить",
                      //         style: TextStyle(
                      //             fontSize: 16, color: kTitleTextColor)),
                      //     ],
                      //   ),
                      // ),

                      Wrap(
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
                              widget.removeItem(widget.productId);
                            },
                            icon: const Icon(Icons.delete),
                            label: const Text("Удалить"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: singleSpace),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          "от ${formatter.format(widget.price).replaceAll(',', ' ')} Р",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
