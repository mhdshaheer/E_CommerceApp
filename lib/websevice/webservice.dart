import 'dart:convert';
import 'dart:math';

import 'package:e_commerce_app/models/category_model.dart';
import 'package:e_commerce_app/models/orderdetailmodel.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/models/user_model.dart';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class WebService {
  final imageurl = 'https://bootcamp.cyralearnings.com/products/';
  final mainurl = 'http://bootcamp.cyralearning.com/';

  Future<List<ProductModel>?> fetchProducts() async {
    final response = await http.get(
        Uri.parse('http://bootcamp.cyralearnings.com/view_offerproducts.php'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load produucts");
    }
  }

  Future<List<ProductModel>?> fetchCatProducts(int catid) async {
    //print("now working......");
    final response = await http.post(
        Uri.parse(
            'http://bootcamp.cyralearnings.com/get_category_products.php'),
        body: {'catid': catid.toString()});

    // print("response==" + response.statusCode.toString());

    if (response.statusCode == 200) {
      // print("inside if");
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<ProductModel>((json) => ProductModel.fromJson(json))
          .toList();
    } else {
      // print("inside else");

      throw Exception('Failed to load category products');
    }
  }

  Future<List<CategoryModel>?> fetchCategory() async {
    final response = await http
        .get(Uri.parse('http://bootcamp.cyralearnings.com/getcategories.php'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed
          .map<CategoryModel>((json) => CategoryModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to load categories");
    }
  }

  Future<UserModel?> fetchUser(String username) async {
    try {
      print("heellllllllo");
      final response = await http.post(
          Uri.parse('http://bootcamp.cyralearnings.com/get_user.php'),
          body: {'username': username});
      print("response==" + response.statusCode.toString());

      if (response.statusCode == 200) {
        print("hhhhhhhhh");
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load User');
      }
    } catch (e) {
      log(e.toString() as num);
    }
    return null;
  }

  Future<List<OrderModel>?> fetchOrderDetails(String username) async {
    try {
      // log("username ==" + username.toString());
      final response = await http.post(
          Uri.parse(mainurl + 'get_orderdetails.php'),
          body: {'username': username.toString()});

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

        return parsed
            .map<OrderModel>((json) => OrderModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load order details');
      }
    } catch (e) {
      //log("order details ==" + e.toString());
    }
  }
}
