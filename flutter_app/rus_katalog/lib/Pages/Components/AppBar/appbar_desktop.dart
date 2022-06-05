import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rus_katalog/Pages/Account/account_desktop.dart';
import 'package:rus_katalog/constants.dart';
import 'package:rus_katalog/Pages/Components/search_widget.dart';
import '../../Cart/Bodies/cart_desktop.dart';
import '../../Catalog/catalog_desktop.dart';
import '../../Favorite/Bodies/favorite_desktop.dart';

class DesktopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const DesktopAppBar({Key? key}) : super(key: key);

  @override
  State<DesktopAppBar> createState() => _DesktopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(desktopAppBarHeight);
}

class _DesktopAppBarState extends State<DesktopAppBar>
    with TickerProviderStateMixin {
  String query = "";
  final _duration = 500;
  bool _catalogFlag = false;
  bool _cartFlag = false;
  bool _favoriteFlag = false;
  bool _accountFlag = false;

  late final AnimationController _controller = AnimationController(
      vsync: this, duration: Duration(milliseconds: _duration));
  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

  late OverlayEntry catalogOverlay = OverlayEntry(
      builder: (context) => Container(
          height: double.infinity,
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(0, desktopAppBarHeight, 0, 0),
          child: ClipRRect(
              child: BackdropFilter(
                  filter:
                      ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
                  child: ScaleTransition(
                      scale: _animation,
                      child: Padding(
                          padding: const EdgeInsets.all(singleSpace),
                          child: DesktopCatalog(closeOverlay: () {
                            setState(() {
                              _catalogFlag = false;
                              catalogOverlay.remove();
                            });
                          })))))));

  late OverlayEntry cartOverlay = OverlayEntry(
      builder: (context) => Container(
          height: double.infinity,
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(0, desktopAppBarHeight, 0, 0),
          child: ClipRRect(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
            child: ScaleTransition(
              scale: _animation,
              child: Padding(
                  padding: const EdgeInsets.all(singleSpace),
                  child: DesktopCart(showCartOverlay: showCartOverlay)),
            ),
          ))));

  late OverlayEntry favoriteOverlay = OverlayEntry(
      builder: (context) => Container(
          height: double.infinity,
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(0, desktopAppBarHeight, 0, 0),
          child: ClipRRect(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
            child: ScaleTransition(
              scale: _animation,
              child: Padding(
                  padding: const EdgeInsets.all(singleSpace),
                  child: DesktopFavorite(
                      showFavoriteOverlay: showFavoriteOverlay)),
            ),
          ))));

  late OverlayEntry accountOverlay = OverlayEntry(
      builder: (context) => Container(
          height: double.infinity,
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(0, desktopAppBarHeight, 0, 0),
          child: ClipRRect(
              child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
            child: ScaleTransition(
              scale: _animation,
              child: Padding(
                  padding: const EdgeInsets.all(singleSpace),
                  child:
                      DesktopAccount(showAccountOverlay: showAccountOverlay)),
            ),
          ))));

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      Overlay.of(context)!.setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_catalogFlag) {
      catalogOverlay.remove();
    }

    if (_cartFlag) {
      cartOverlay.remove();
    }

    if (_favoriteFlag) {
      favoriteOverlay.remove();
    }

    if (_accountFlag) {
      accountOverlay.remove();
    }

    _controller.dispose();
  }

  void showCatalogOverlay() {
    if (!_catalogFlag) {
      Overlay.of(context)!.insert(catalogOverlay);
      _controller.forward();
    } else {
      _controller.reverse();
      Future.delayed(Duration(milliseconds: _duration))
          .whenComplete(() => catalogOverlay.remove());
    }
    _catalogFlag = !_catalogFlag;
  }

  void showCartOverlay() {
    if (!_cartFlag) {
      Overlay.of(context)!.insert(cartOverlay);
      _controller.forward();
    } else {
      _controller.reverse();
      Future.delayed(Duration(milliseconds: _duration))
          .whenComplete(() => cartOverlay.remove());
    }
    _cartFlag = !_cartFlag;
  }

  void showFavoriteOverlay() {
    if (!_favoriteFlag) {
      Overlay.of(context)!.insert(favoriteOverlay);
      _controller.forward();
    } else {
      _controller.reverse();
      Future.delayed(Duration(milliseconds: _duration))
          .whenComplete(() => favoriteOverlay.remove());
    }
    _favoriteFlag = !_favoriteFlag;
  }

  void showAccountOverlay() {
    if (!_accountFlag) {
      Overlay.of(context)!.insert(accountOverlay);
      _controller.forward();
    } else {
      _controller.reverse();
      Future.delayed(Duration(milliseconds: _duration))
          .whenComplete(() => accountOverlay.remove());
    }
    _accountFlag = !_accountFlag;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Theme.of(context).bottomAppBarColor
          : kPrimaryColor,
      bottom: PreferredSize(
        preferredSize: const Size.fromRadius(10),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: singleSpace),
          constraints: const BoxConstraints(
              maxWidth: desktopWidth, maxHeight: desktopAppBarHeight),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(companyName,
                style: Theme.of(context).brightness == Brightness.dark
                    ? Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                            const Shadow(
                                color: Colors.white,
                                blurRadius: singleSpace * 3)
                          ])
                    : Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        shadows: [
                            const Shadow(
                                color: kPrimaryColor,
                                blurRadius: singleSpace * 3)
                          ])),
            const SizedBox(width: singleSpace),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  if (_cartFlag) {
                    cartOverlay.remove();
                    _cartFlag = false;
                  } else if (_favoriteFlag) {
                    favoriteOverlay.remove();
                    _favoriteFlag = false;
                  } else if (_accountFlag) {
                    accountOverlay.remove();
                    _accountFlag = false;
                  }
                  showCatalogOverlay();
                });
              },
              style: Theme.of(context).brightness == Brightness.dark
                  ? _catalogFlag
                      ? Theme.of(context).elevatedButtonTheme.style?.copyWith(
                          shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(borderRadius),
                              side: BorderSide(
                                  width: 2.0,
                                  color: Theme.of(context).bottomAppBarColor))))
                      : Theme.of(context).elevatedButtonTheme.style?.copyWith(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Theme.of(context).bottomAppBarColor))
                  : _catalogFlag
                      ? Theme.of(context).elevatedButtonTheme.style?.copyWith(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Theme.of(context).bottomAppBarColor),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(borderRadius),
                                  side: const BorderSide(width: 2.0, color: kPrimaryColor))))
                      : Theme.of(context).elevatedButtonTheme.style?.copyWith(),
              icon: Icon(Icons.widgets,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).iconTheme.color
                      : _catalogFlag
                          ? kPrimaryColor
                          : Colors.white),
              label: Text("Каталог",
                  style: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).textTheme.titleMedium
                      : _catalogFlag
                          ? Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: kPrimaryColor)
                          : Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white)),
            ),
            Expanded(
              child: SearchWidget(
                  text: query,
                  onChanged: (String str) {},
                  hintText: "Найти товар"),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.list),
            ),
            const SizedBox(width: singleSpace),
            IconButton(
              onPressed: () {
                setState(() {
                  if (_catalogFlag) {
                    catalogOverlay.remove();
                    _catalogFlag = false;
                  } else if (_cartFlag) {
                    cartOverlay.remove();
                    _cartFlag = false;
                  } else if (_accountFlag) {
                    accountOverlay.remove();
                    _accountFlag = false;
                  }
                  showFavoriteOverlay();
                });
              },
              icon: const Icon(Icons.favorite),
              color: Theme.of(context).brightness == Brightness.dark
                  ? _favoriteFlag
                      ? Theme.of(context).bottomAppBarColor
                      : Theme.of(context).iconTheme.color
                  : _favoriteFlag
                      ? kPrimaryColor
                      : Theme.of(context).iconTheme.color,
            ),
            const SizedBox(width: singleSpace),
            IconButton(
              onPressed: () {
                setState(() {
                  if (_catalogFlag) {
                    catalogOverlay.remove();
                    _catalogFlag = false;
                  } else if (_favoriteFlag) {
                    favoriteOverlay.remove();
                    _favoriteFlag = false;
                  } else if (_accountFlag) {
                    accountOverlay.remove();
                    _accountFlag = false;
                  }
                  showCartOverlay();
                });
              },
              icon: const Icon(Icons.shopping_cart),
              color: Theme.of(context).brightness == Brightness.dark
                  ? _cartFlag
                      ? Theme.of(context).bottomAppBarColor
                      : Theme.of(context).iconTheme.color
                  : _cartFlag
                      ? kPrimaryColor
                      : Theme.of(context).iconTheme.color,
            ),
            const SizedBox(width: singleSpace),
            IconButton(
              onPressed: () {
                setState(() {
                  if (_catalogFlag) {
                    catalogOverlay.remove();
                    _catalogFlag = false;
                  } else if (_favoriteFlag) {
                    favoriteOverlay.remove();
                    _favoriteFlag = false;
                  } else if (_cartFlag) {
                    cartOverlay.remove();
                    _cartFlag = false;
                  }
                  showAccountOverlay();
                });
              },
              icon: const Icon(Icons.person),
              color: Theme.of(context).brightness == Brightness.dark
                  ? _accountFlag
                      ? Theme.of(context).bottomAppBarColor
                      : Theme.of(context).iconTheme.color
                  : _accountFlag
                      ? kPrimaryColor
                      : Theme.of(context).iconTheme.color,
            ),
          ]),
        ),
      ),
    );
  }
}
