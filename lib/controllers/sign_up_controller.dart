import 'dart:convert';

import 'package:fruits/models/sign_up_model.dart';
import 'package:fruits/services/app_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';

class SignUpController extends GetxController {
  bool isLoading = false;
  bool success = false;

  Future userSignUp(SignUpModel signUpModel) async {
    try {
      isLoading = true;
      update();
      final prefs = await SharedPreferences.getInstance();

      var response = await AppService().postSignUpApi(signUpModel);
      final respStr = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        Get.snackbar("Success", "User Registered Successfully");
        // var token = json.decode(respStr)["token"];
        // prefs.setString("token", token);

        success = true;
      } else if (response.statusCode == 400) {
        print(respStr);
        Get.snackbar("Error", "An Error Occured!");
        success = false;
      } else {
        Get.snackbar("Error", "An Error Occured!");
      }
    } catch (e) {
      success = false;

      isLoading = false;
      update();
    }

    isLoading = false;
    update();
    return success;
  }
}
