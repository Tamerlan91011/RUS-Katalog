import 'package:flutter/material.dart';

import 'package:rus_katalog/constants.dart';
import 'package:rus_katalog/Pages/ProductsList/Bodies/Components/filter_mobile.dart';
import 'package:rus_katalog/Pages/ProductsList/Bodies/Components/productitem.dart';
import 'package:rus_katalog/Models/product.dart';

class MobileProductsList extends StatefulWidget {
  const MobileProductsList({Key? key,
      required this.productList,
      required this.priceList,
      required this.rateList})
      : super(key: key);

  final List<Product> productList;
  final List<double> priceList;
  final List<double> rateList;

  @override
  State<MobileProductsList> createState() => _MobileProductsListState();
}

class _MobileProductsListState extends State<MobileProductsList>
    with SingleTickerProviderStateMixin {
  final List<String> sortList = [
    "Популярное",
    "Сначала дешевые",
    "Сначала дорогие"
  ];
  String dropDownValue = "";
  final animationDuration = 800;

  late final AnimationController _controller = AnimationController(
    duration: Duration(milliseconds: animationDuration),
    vsync: this,
  );

  late final Animation<Offset> _animation = Tween<Offset>(
    begin: const Offset(1.0, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  ));

  late OverlayEntry filterOverlay = OverlayEntry(
    builder: (context) => SlideTransition(
      position: _animation,
      child: MobileFilterOverlay(filterProducts: filterProducts, closeOverlay: closeOverlay),
    ),
  );

  @override
  void initState() {
    super.initState();

    dropDownValue = sortList[0];

    _controller.addListener(() {
      Overlay.of(context)!.setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();

    if (filterOverlay.mounted) {
      filterOverlay.remove();
    }
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: 
      Column(
        children: [
          Row(
            children: [
              const SizedBox(width: singleSpace*2),
              DropdownButton<String>(
                  style: Theme.of(context).textTheme.bodyMedium,
                  value: dropDownValue,
                  icon: const Icon(Icons.sort),
                  items: sortList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value));
                  }).toList(),
                  onChanged: (String? string) {
                    setState(() {
                      dropDownValue = string!;
                    });
                  }),
              const Expanded(child: SizedBox()),
              IconButton(
                  onPressed: () {
                    setState(() {
                      Overlay.of(context)!.insert(filterOverlay);
                      _controller.forward();
                    });
                  },
                  icon: const Icon(Icons.filter_list_alt)),
              const SizedBox(width: singleSpace),
            ],
          ),
          Column(children: buildProducts())
        ],
      ),
    );
  }

  void filterProducts() {
    
  }

    void closeOverlay() {
    _controller.reverse();
    Future.delayed(Duration(milliseconds: animationDuration)).whenComplete(() => filterOverlay.remove());
  }

  List<Widget> buildProducts() {
    List<Widget> products = [];

    for (var i = 0; i < widget.productList.length; i++) {
      products.add(ProductItem(
        productId: widget.productList[i].id,
        imageUrl: "",
        label: "${widget.productList[i].brand} ${widget.productList[i].model}",
        price: widget.priceList[i].toInt(),
        rating: widget.rateList[i],
      ));
    }

    return products;
  }
}
