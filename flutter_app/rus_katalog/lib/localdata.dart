import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalData {
  static void saveComparison(int productId, bool toCompare) async {
    final prefs = await SharedPreferences.getInstance();
    List<int>? comparison = [];

    List<String>? data = prefs.getStringList('comparison');
    if (data != null) {
      comparison.addAll(data.map((e) => int.parse(e)));
    }

    if (toCompare) {
      comparison.contains(productId) ? null : comparison.add(productId);
    } else {
      comparison.remove(productId);
    }

    await prefs.setStringList(
        "comparison", comparison.map((e) => e.toString()).toList());
  }

  static Future<bool> getComparison(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    List<int>? comparison = [];

    List<String>? data = prefs.getStringList('comparison');
    if (data != null) {
      comparison.addAll(data.map((e) => int.parse(e)));
    }

    return comparison.contains(productId);
  }

  static void saveFavorite(int productId, bool isFavorite) async {
    final prefs = await SharedPreferences.getInstance();
    List<int>? favorite = [];

    List<String>? data = prefs.getStringList('favorite');
    if (data != null) {
      favorite.addAll(data.map((e) => int.parse(e)));
    }

    if (isFavorite) {
      favorite.contains(productId) ? null : favorite.add(productId);
    } else {
      favorite.remove(productId);
    }

    await prefs.setStringList(
        "favorite", favorite.map((e) => e.toString()).toList());
  }

  static Future<bool> getFavorite(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    List<int>? favorite = [];

    List<String>? data = prefs.getStringList('favorite');
    if (data != null) {
      favorite.addAll(data.map((e) => int.parse(e)));
    }

    return favorite.contains(productId);
  }

  static Future<List<int>> getFavoriteList() async {
    final prefs = await SharedPreferences.getInstance();
    List<int>? favorite = [];

    List<String>? data = prefs.getStringList('favorite');
    if (data != null) {
      favorite.addAll(data.map((e) => int.parse(e)));
    }

    return favorite;
  }

  static void saveProductToCart(int productId, int shopId, bool toAdd) async {
    final prefs = await SharedPreferences.getInstance();
    List<int>? productsInCart = [];
    List<int>? shopsInCart = [];
    List<int>? amount = [];

    List<String>? data = prefs.getStringList('productsInCart');
    if (data != null) {
      productsInCart.addAll(data.map((e) => int.parse(e)));
    }

    data = null;
    data = prefs.getStringList('shopsInCart');
    if (data != null) {
      shopsInCart.addAll(data.map((e) => int.parse(e)));
    }

    data = null;
    data = prefs.getStringList('amount');
    if (data != null) {
      amount.addAll(data.map((e) => int.parse(e)));
    }

    int index = -1;
    for (var i = 0; i < productsInCart.length; i++) {
      if (productsInCart[i] == productId && shopsInCart[i] == shopId) {
        index = i;
        break;
      }
    }

    if (toAdd) {
      if (index != -1) {
        amount[index]++;
      } else {
        productsInCart.add(productId);
        shopsInCart.add(shopId);
        amount.add(1);
      }
    } else {
      amount[index]--;
      if (amount[index] == 0) {
        productsInCart.removeAt(index);
        shopsInCart.removeAt(index);
        amount.removeAt(index);
      }
    }
    await prefs.setStringList(
        "productsInCart", productsInCart.map((e) => e.toString()).toList());
    await prefs.setStringList(
        "shopsInCart", shopsInCart.map((e) => e.toString()).toList());
    await prefs.setStringList(
        "amount", amount.map((e) => e.toString()).toList());
  }

  static Future<List> getProductsInCart() async {
    final prefs = await SharedPreferences.getInstance();
    List result = [];
    List<int>? productsInCart = [];
    List<int>? shopsInCart = [];
    List<int>? amount = [];

    List<String>? data = prefs.getStringList('productsInCart');
    if (data != null) {
      productsInCart.addAll(data.map((e) => int.parse(e)));
    }

    data = null;
    data = prefs.getStringList('shopsInCart');
    if (data != null) {
      shopsInCart.addAll(data.map((e) => int.parse(e)));
    }

    data = null;
    data = prefs.getStringList('amount');
    if (data != null) {
      amount.addAll(data.map((e) => int.parse(e)));
    }

    result.add(productsInCart);
    result.add(shopsInCart);
    result.add(amount);

    return result;
  }

  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("productsInCart");
    prefs.remove("shopsInCart");
    prefs.remove("amount");
  }

  static void saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("isDark", isDark);
  }

  static Future<bool?> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isDark");
  }

  static void saveUser(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("user", token);
  }

  static Future<String?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("user");
  }

  static void removeUser() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("user");
  }
}
