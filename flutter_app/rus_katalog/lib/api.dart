import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:rus_katalog/Models/address.dart';
import 'package:rus_katalog/Models/order.dart';
import 'package:rus_katalog/Models/products_in_shops.dart';
import 'package:rus_katalog/Models/shop.dart';
import 'package:rus_katalog/constants.dart';

import 'Models/category.dart';
import 'Models/client.dart';
import 'Models/product.dart';
import 'Models/specification.dart';
import 'Models/feedback_item.dart';

abstract class Api {
  static Future<List<Category>> getCategories() async {
    List<Category> categoryList = [];
    try {
      var response = await Dio().get("http://$apiUrl/categories/");
      var json = response.data.toString();
      var jsonData = jsonDecode(json) as List;
      categoryList = jsonData.map((e) => Category.fromJson(e)).toList();
    } catch (ex) {
      debugPrint(ex.toString());
    }

    return categoryList;
  }

  static Future<Product> getProductById(int productId) async {
    Product? product;
    try {
      var response =
          await Dio().get("http://$apiUrl/products/?product_id=$productId");
      var json = response.data.toString();
      var jsonData = jsonDecode(json)[0]["product"];
      product = Product.fromJson(jsonData);
      jsonData = jsonDecode(json)[1]['specList'];
      product.specList = (jsonData as List<dynamic>)
          .map((e) => SpecificationValue.fromJson(
              e['specification_value'] as Map<String, dynamic>))
          .toList();
    } catch (ex) {
      debugPrint(ex.toString());
    }
    return product!;
  }

  static Future<List<Product>> getProductsByIds(List<int> productId) async {
    List<Product> productList = [];
    try {
      var url = "http://$apiUrl/products/?products_id=${productId[0]}";
      for (var i = 1; i < productId.length; i++) {
        url += "&products_id=${productId[i]}";
      }
      var response = await Dio().get(url);
      var json = "{${response.data.toString()}}";
      var jsonData = jsonDecode(json)["products"] as List;

      productList = jsonData.map((e) => Product.fromJson(e)).toList();
    } catch (ex) {
      debugPrint(ex.toString());
    }

    return productList;
  }

  static Future<List<Product>> getProductsByCategoryId(int categoryId) async {
    List<Product> productList = [];
    try {
      var response =
          await Dio().get("http://$apiUrl/products/?category_id=$categoryId");
      var json = "{${response.data.toString()}}";
      var jsonData = jsonDecode(json)["products"] as List;

      productList = jsonData.map((e) => Product.fromJson(e)).toList();
    } catch (ex) {
      debugPrint(ex.toString());
    }

    return productList;
  }

  static Future<Product> getProductByBrandModel() async {
    // добавить
    Product product = Product(
        id: 1,
        brand: "Apple",
        model: "iPhone 13",
        itemNumber: "123456",
        description: "description",
        categoryId: 1,
        specList: []);

    return product;
  }

  static Future<List<double>> getMinPricesOfProducts(
      List<int> productId) async {
    List<double> priceList = [];
    try {
      var url = "http://$apiUrl/prices/?products_id=${productId[0]}";
      for (var i = 1; i < productId.length; i++) {
        url += "&products_id=${productId[i]}";
      }
      var response = await Dio().get(url);
      var json = response.data.toString();
      var jsonData = jsonDecode(json) as List;
      priceList = jsonData.map((e) => e['price'] as double).toList();
    } catch (ex) {
      debugPrint(ex.toString());
    }

    return priceList;
  }

  static Future<List<double>> getPricesOfProducts(
      List<int> productId, List<int> shopId) async {
    List<double> priceList = [];
    try {
      var url =
          "http://$apiUrl/prices/?products_id=${productId[0]}&shops_id=${shopId[0]}";
      for (var i = 1; i < productId.length; i++) {
        url += "&products_id=${productId[i]}&shops_id=${shopId[i]}";
      }
      var response = await Dio().get(url);
      var json = response.data.toString();
      var jsonData = jsonDecode(json) as List;
      priceList = jsonData.map((e) => e['price'] as double).toList();
    } catch (ex) {
      debugPrint(ex.toString());
    }

    return priceList;
  }

  static Future<List<ProductsInShops>> getPricesOfProduct(int productId) async {
    List<ProductsInShops> priceList = [];
    try {
      var response =
          await Dio().get("http://$apiUrl/prices/?product_id=$productId");
      var json = response.data.toString();
      var jsonData = jsonDecode(json) as List;
      priceList = jsonData.map((e) => ProductsInShops.fromJson(e)).toList();
    } catch (ex) {
      debugPrint(ex.toString());
    }

    return priceList;
  }

  static Future<List<Shop>> getShopsByIds(List<int> shopId) async {
    List<Shop> shopList = [];
    try {
      var url = "http://$apiUrl/shops/?shops_id=${shopId[0]}";
      for (var i = 1; i < shopId.length; i++) {
        url += "&shops_id=${shopId[i]}";
      }
      var response = await Dio().get(url);
      var json = response.data.toString();
      var jsonData = jsonDecode(json) as List;
      shopList = jsonData.map((e) => Shop.fromJson(e)).toList();
    } catch (ex) {
      debugPrint(ex.toString());
    }

    return shopList;
  }

  static Future<List<double>> getRatingOfProducts(List<int> productId) async {
    List<double> rateList = [];
    try {
      var url = "http://$apiUrl/rating/?products_id=${productId[0]}";
      for (var i = 1; i < productId.length; i++) {
        url += "&products_id=${productId[i]}";
      }
      var response = await Dio().get(url);
      var json = response.data.toString();
      var jsonData = jsonDecode(json)["rating"] as List;
      rateList = jsonData.map((e) => e as double).toList();
    } catch (ex) {
      debugPrint(ex.toString());
    }

    return rateList;
  }

  static Future<List<Specification>> getSpecifications() async {
    List<Specification> specList = [];
    try {
      var response = await Dio().get("http://$apiUrl/specifications/");
      var json = response.data.toString();
      var jsonData = jsonDecode(json) as List;
      specList = jsonData.map((e) => Specification.fromJson(e)).toList();
    } catch (ex) {
      debugPrint(ex.toString());
    }

    return specList;
  }

  static Future<List<FeedbackItem>> getFeedbacksByProductId(int id) async {
    List<FeedbackItem> feedbackList = [];
    try {
      var response = await Dio().get("http://$apiUrl/feedback/?product_id=$id");
      var json = response.data.toString();
      var jsonData = jsonDecode(json) as List;
      feedbackList = jsonData.map((e) => FeedbackItem.fromJson(e)).toList();
    } catch (ex) {
      debugPrint(ex.toString());
    }
    return feedbackList;
  }

  static Future<Client> getClientByToken(String userToken) async {
    // String json = '''{
    // "client": {"id": 1, "email": "email@gmail.com", "phone": "89270660891",
    // "password": "12345", "fullname": "Мантуленко Андрей Игоревич", "isAdmin": true}
    // }''';

    Client? client;
    try {
      var url = "http://$apiUrl/auth/login/";
      var response = await Dio().get(url,
          options: Options(headers: {"Authorization": "Token $userToken"}));
      var json = response.data.toString();
      var jsonData = jsonDecode(json);
      client = Client.fromJson(jsonData);
    } catch (ex) {
      debugPrint(ex.toString());
    }
    return client!;
  }

  static Future<String?> loginClient(
      String login, String password, bool isPhone) async {
    String? token;
    try {
      var url = "http://$apiUrl/auth/login/";
      var data = {};
      if (isPhone) {
        url += "?phone=true";
        data.addAll({"phone": login, "password": password});
      } else {
        url += "?email=true";
        data.addAll({"email": login, "password": password});
      }
      var response = await Dio().post(url, data: data);
      var json = response.data.toString();
      token = jsonDecode(json)['token'] as String;
    } catch (ex) {
      debugPrint(ex.toString());
    }
    return token;
  }

  static Future<void> logoutClient(String userToken) async {
    try {
      var url = "http://$apiUrl/auth/logout/";
      await Dio().get(url,
          options: Options(headers: {"Authorization": "Token $userToken"}));
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  static Future<String?> registerCLient(Client client) async {
    String? token;
    try {
      var url = "http://$apiUrl/auth/register/";
      var response = await Dio().post(url, data: client.toJson());
      var json = response.data.toString();
      token = jsonDecode(json)['token'] as String;
    } catch (ex) {
      debugPrint(ex.toString());
    }
    return token;
  }

  static Future<List<Address>> getClientAdresses(String userToken) async {
    List<Address> addressList = [];
    try {
      var url = "http://$apiUrl/address/";
      var response = await Dio().get(url,
          options: Options(headers: {"Authorization": "Token $userToken"}));
      var json = response.data.toString();
      var jsonData = jsonDecode(json) as List;
      addressList
          .addAll(jsonData.map((e) => Address.fromJson(e["address"])).toList());
    } catch (ex) {
      debugPrint(ex.toString());
    }

    return addressList;
  }

  static Future<String> newOrder(
      List<int> productId,
      List<int> shopId,
      List<int> amount,
      Address address,
      bool addressIsNew,
      String userToken) async {
    try {
      var url =
          "http://$apiUrl/orders/?products_id=${productId[0]}&shops_id=${shopId[0]}&amount=${amount[0]}";
      for (var i = 1; i < productId.length; i++) {
        url +=
            "&products_id=${productId[i]}&shops_id=${shopId[i]}&amount=${amount[i]}";
      }
      if (addressIsNew) {
        url += "&new_address=true";
      }
      var data = {
        "address": address.toJson(),
      };
      var response = await Dio().post(url,
          data: data,
          options: Options(headers: {"Authorization": "Token $userToken"}));
      var json = response.data.toString();
      var jsonData = jsonDecode(json);
      var result = jsonData["id"] as int?;
      return result!.toString();
    } catch (ex) {
      debugPrint(ex.toString());
      return "Ошибка";
    }
  }

  static Future<List> getOrdersOfClient(String userToken) async {
    List<Order> orders = [];
    List<int> productsId = [];
    List<Shop> shops = [];
    List<double> prices = [];
    List<int> amount = [];
    List result = [];

    try {
      var url = "http://$apiUrl/orders/";
      var response = await Dio().get(url,
          options: Options(headers: {"Authorization": "Token $userToken"}));
      var json = response.data.toString();
      var jsonData = jsonDecode(json) as List;
      for (var item in jsonData) {
        orders.add(Order.fromJson(item['order']));
        productsId.add(item['product'] as int);
        shops.add(Shop.fromJson(item['shop']['shop']));
        prices.add(item['shop']['price'] as double);
        amount.add(item['amount'] as int);
      }

      if (orders.isNotEmpty) {
        List<Product> products = await getProductsByIds(productsId);
        result.add({
          'order': orders[0],
          'products': [products[0]],
          'shops': [shops[0]],
          'prices': [prices[0]],
          'amount': [amount[0]],
        });
        for (var i = 1; i < orders.length; i++) {
          if (orders[i - 1].id == orders[i].id) {
            List<Product> productList = result.last['products'];
            List<Shop> shopList = result.last['shops'];
            List<double> priceList = result.last['prices'];
            List<int> amountList = result.last['amount'];
            productList.add(products[i]);
            shopList.add(shops[i]);
            priceList.add(prices[i]);
            amountList.add(amount[i]);
          } else {
            result.add({
              'order': orders[i],
              'products': [products[i]],
              'shops': [shops[i]],
              'prices': [prices[i]],
              'amount': [amount[i]],
            });
          }
        }
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }

    return result;
  }
}
