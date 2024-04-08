import 'dart:convert';

import 'package:fruits/controllers/cart_controller.dart';
import 'package:fruits/models/cart_model.dart';
import 'package:fruits/services/app_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';
import '../utility/logout.dart';

class SearchController extends GetxController {
  bool isLoading = false;
  ProductModel? productModel;

  Future searchProduct(String query) async {
    try {
      isLoading = true;
      update();
      if (query.isNotEmpty) {
        var response = await AppService().postSearchApi(query);
        var res = await response.stream.bytesToString();
        if (response.statusCode == 200) {
          var list = jsonDecode(res);
          productModel = ProductModel.fromJson(list);
          update();
        } else if (response.statusCode == 401) {
        logout();
        Get.snackbar("401 Unauthorized", "Authorization Failed");
      }
      } else {
        productModel = ProductModel(data: []);
        update();
      }
    } catch (e) {
      isLoading = false;
      update();
    }

    isLoading = false;
    // syncBoxCart();
    update();
    return;
  }
}
