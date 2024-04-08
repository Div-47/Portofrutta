 import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../screens/login.dart';

logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.offAll(LoginScreen());
  }