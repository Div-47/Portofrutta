import 'dart:convert';

import 'package:fruits/models/profile_model.dart';
import 'package:fruits/models/user_order_model.dart';
import 'package:fruits/services/app_services.dart';
import 'package:get/get.dart';

import '../models/product_model.dart';
import '../utility/logout.dart';

class OrderController extends GetxController {
  bool isLoading = false;
  UserOrderModel? userOrderModel;

  Future fetchUserOrder() async {
    try {
      userOrderModel = UserOrderModel(data: [], status: "false");
      isLoading = true;
      update();
      var response = await AppService().getUserOrdersApi();
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        var data = jsonDecode(response.body.toString());
        userOrderModel = UserOrderModel.fromJson(data);
      } else if (response.statusCode == 401) {
        logout();
        Get.snackbar("401 Unauthorized", "Authorization Failed");
      }
    } catch (e) {
      print("order error ---> $e");
      isLoading = false;
      update();
    }

    isLoading = false;
    update();
  }
}
