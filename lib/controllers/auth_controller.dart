import 'dart:convert';

import 'package:fruits/services/app_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';

class AuthController extends GetxController {
  bool isLoading = false;
  bool success = false;

  Future userLogin(String email, String password) async {
    try {
      isLoading = true;
      update();
      final prefs = await SharedPreferences.getInstance();

      var response = await AppService().postLoginApi(email, password);

      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        var token = json.decode(respStr)["token"];
        prefs.setString("token", token);
        prefs.setString("user_email", email);
        var userId = json.decode(respStr)["user_id"];
        prefs.setInt("user_id", userId);
        prefs.setInt("cart_user_id", userId);

        success = true;
      } else if (response.statusCode == 401) {
        success = false;
      }
    } catch (e) {
      print(e);
      success = false;

      isLoading = false;
      update();
    }

    isLoading = false;
    update();
    return success;
  }
}
