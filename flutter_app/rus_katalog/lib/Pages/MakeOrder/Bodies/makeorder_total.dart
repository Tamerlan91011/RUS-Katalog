import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rus_katalog/constants.dart';

class MakeOrderTotal extends StatelessWidget {
  MakeOrderTotal({Key? key, required this.sum, required this.delivery}) : super(key: key);
  final formatter = NumberFormat("#,###");
  final double sum;
  final double delivery;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Итого ",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(
              height: singleSpace * 2,
            ),
            Text("Товары ", style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(
              height: singleSpace,
            ),
            Text("Доставка ", style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const Expanded(child: SizedBox()),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("${formatter.format(sum + delivery).replaceAll(',', ' ')} Р",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(
              height: singleSpace * 2,
            ),
            Text("${formatter.format(sum).replaceAll(',', ' ')} Р",
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(
              height: singleSpace,
            ),
            Text("${formatter.format(delivery).replaceAll(',', ' ')} Р",
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }
}
