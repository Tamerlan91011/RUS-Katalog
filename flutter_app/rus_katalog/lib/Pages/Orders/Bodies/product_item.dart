import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rus_katalog/Models/product.dart';
import 'package:rus_katalog/Models/shop.dart';
import 'package:rus_katalog/constants.dart';
import 'package:rus_katalog/localdata.dart';

// Карточка товара корзины
class ProductInShopItem extends StatefulWidget {
  final Product product;
  final Shop shop;
  final double price;
  final int amount;

  const ProductInShopItem(
      {Key? key,
      required this.product,
      required this.shop,
      required this.price,
      required this.amount})
      : super(key: key);

  @override
  State<ProductInShopItem> createState() => _ProductInShopItemState();
}

class _ProductInShopItemState extends State<ProductInShopItem> {
  int amount = 0;

  @override
  void initState() {
    super.initState();

    amount = widget.amount;
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,###");
    return Container(
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
                    Text("${widget.product.brand} ${widget.product.model}",
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
                        const SizedBox(width: singleSpace),
                        Text("x", style: Theme.of(context).textTheme.bodyLarge),
                        const SizedBox(width: singleSpace),
                        Text("$amount",
                            style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                    const SizedBox(height: singleSpace),
                  ],
                ),
              ),
            ],
          )
        ]));
  }
}
