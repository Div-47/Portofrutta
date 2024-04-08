import 'dart:convert';

import 'package:fruits/controllers/cart_controller.dart';

import 'package:fruits/models/product_details_model.dart';
import 'package:fruits/services/app_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utility/logout.dart';

class ProductDetailsController extends GetxController {
  bool isLoading = false;
  ProductDetailsModel? productDetailsModel;

  Future getProductDetails(int productId) async {
    try {
      isLoading = true;
      update();
      // if () {
      var response = await AppService().getProductDetailsApi(productId);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        productDetailsModel = ProductDetailsModel.fromJson(data);
        update();
      } else if (response.statusCode == 401) {
        logout();
        Get.snackbar("401 Unauthorized", "Authorization Failed");
      }
      // } else {
      //   productDetailsModel = ProductDetailsModel(data: Data(id: 0,category: '',italicName: '',name:'' ,productDescription:'' ,productDescriptionItalic: '',productDiscountPrice: '',productImage: '',productImages: [],productMeasurement: '',productMrpPrice:'' ,productShortDescription: '',productShortDescriptionItalic:'' ,productStock: '',));
      //   update();
      // }
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
