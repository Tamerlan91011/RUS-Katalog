import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rus_katalog/Models/product.dart';
import 'package:rus_katalog/Models/shop.dart';
import 'package:rus_katalog/constants.dart';
import 'package:rus_katalog/localdata.dart';

// Карточка товара корзины
class CartItem extends StatefulWidget {
  final Product product;
  final Shop shop;
  final double price;
  final int amount;
  final void Function(int productId, int shopId, int amount) calculatePrice;
  final void Function()? showCartOverlay;

  const CartItem(
      {Key? key,
      required this.product,
      required this.shop,
      required this.price,
      required this.amount,
      required this.calculatePrice,
      this.showCartOverlay})
      : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  bool toCompare = false;
  bool isFavorite = false;
  int amount = 0;

  @override
  void initState() {
    super.initState();

    amount = widget.amount;
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
    final formatter = NumberFormat("#,###");
    return Card(
        elevation: standartElevation,
        child: InkWell(
          onTap: () {
            if (widget.showCartOverlay != null) {
              widget.showCartOverlay!();
            }
            Navigator.pushNamed(context, "/product/${widget.product.id}");
          },
          child: Container(
              margin: const EdgeInsets.all(singleSpace),
              child: Column(children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Изображение
                    Container(
                      width: 128,
                      height: 128,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(borderRadius),
                          color: kGrayColor),
                      child: ClipRRect(
                      borderRadius: BorderRadius.circular(borderRadius),
                      child: Image.network(
                          "http://$apiUrl/media/?object_id=${widget.product.id}&object_type=product",
                          fit: BoxFit.cover)),
                    ),

                    const SizedBox(
                      width: singleSpace,
                    ),

                    // Основная информация
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          // Название товара
                          Text(
                              "${widget.product.brand} ${widget.product.model}",
                              style: Theme.of(context).textTheme.titleMedium,
                              maxLines: 2),

                          const SizedBox(height: singleSpace * 2),

                          // Название магазина
                          Text("Магазин: ${widget.shop.name}",
                              style: Theme.of(context).textTheme.titleMedium,
                              maxLines: 2),

                          const SizedBox(height: singleSpace * 2),

                          // Цена товара и количество
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  "${formatter.format(widget.price).replaceAll(',', ' ')} Р",
                                  style: Theme.of(context).textTheme.bodyLarge),
                              const SizedBox(width: singleSpace * 2),
                              Text("x",
                                  style: Theme.of(context).textTheme.bodyLarge),
                              const SizedBox(width: singleSpace),
                              IconButton(
                                  splashRadius: 24.0,
                                  onPressed: () {
                                    LocalData.saveProductToCart(
                                        widget.product.id,
                                        widget.shop.id,
                                        false);
                                    setState(() {
                                      amount--;
                                      widget.calculatePrice(widget.product.id,
                                          widget.shop.id, amount);
                                    });
                                  },
                                  icon: const Icon(Icons.remove_circle)),
                              Text("$amount",
                                  style: Theme.of(context).textTheme.bodyLarge),
                              IconButton(
                                  splashRadius: 24.0,
                                  onPressed: () {
                                    LocalData.saveProductToCart(
                                        widget.product.id,
                                        widget.shop.id,
                                        true);
                                    setState(() {
                                      amount++;
                                      widget.calculatePrice(widget.product.id,
                                          widget.shop.id, amount);
                                    });
                                  },
                                  icon: const Icon(Icons.add_circle))
                            ],
                          ),
                          const SizedBox(height: singleSpace),
                        ],
                      ),
                    ),
                  ],
                )
              ])),
        ));
  }
}
