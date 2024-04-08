import 'dart:convert';

import 'package:fruits/controllers/cart_controller.dart';
import 'package:fruits/models/cart_model.dart';
import 'package:fruits/services/app_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';
import '../utility/logout.dart';

class ForgotPasswordController extends GetxController {
  bool isLoading = false;
  bool success = false;

  Future forgotPassword(String email, String password) async {
    String res = '';
    try {
      isLoading = true;
      update();
      if (email.isNotEmpty && password.isNotEmpty) {
        var response =
            await AppService().postForgotPasswordApi(email, password);
        res = await response.stream.bytesToString();
        if (response.statusCode == 200) {
          success = true;
          update();
          String msg = jsonDecode(res)["message"];
          Get.snackbar("Success", msg);
        } else if (response.statusCode == 401) {
          isLoading = false;
          success = false;
          update();
          // Get.snackbar("401 Unauthorized", "Authorization Failed");
        } else {
          String msg = jsonDecode(res)["message"];
          Get.snackbar("Failed", msg);
        }
      } else {
        isLoading = false;
        success = false;
        update();
      }
    } catch (e) {
      isLoading = false;
      success = false;
      update();
    }
    isLoading = false;
    update();
    return;
  }
}
