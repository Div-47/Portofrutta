import 'dart:convert';

import 'package:fruits/services/app_services.dart';
import 'package:get/get.dart';

import '../models/offer_model.dart';
import '../utility/logout.dart';

class OfferController extends GetxController {
  bool isLoading = false;
  OfferModel? offerModel;

  Future fetchOffer() async {
    try {
      isLoading = true;
      update();
      var response = await AppService().getOfferApi();
      if (response.statusCode == 200) {
        print(response.body);
        var list = jsonDecode(response.body.toString());
        offerModel = OfferModel.fromJson(list);
        // print(listModel);
      } else if (response.statusCode == 401) {
        logout();
        Get.snackbar("401 Unauthorized", "Authorization Failed");
      }
    } catch (e) {
      isLoading = false;
      update();
    }

    isLoading = false;
    update();
  }
}
