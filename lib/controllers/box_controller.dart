import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fruits/controllers/cart_controller.dart';
import 'package:fruits/models/cart_model.dart';
import 'package:fruits/services/app_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';
import '../utility/logout.dart';

class BoxController extends GetxController {
  bool isLoading = false;
  ProductModel? productModel;
  final cartController = Get.put(CartController());

  Future fetchBox() async {
    try {
      isLoading = true;
      update();
      var response = await AppService().getBoxApi();
      if (response.statusCode == 200) {
        print(response.body);
        var list = jsonDecode(response.body.toString());
        productModel = ProductModel.fromJson(list);
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
    syncBoxCart();
    update();
    return;
  }

  void incrementProduct(
    int index,
  ) async {
    productModel!.data![index].cartUpdateLoading = true;
    // isLoading = true;
    update();
    final prefs = await SharedPreferences.getInstance();
    String? cartToken = prefs.getString("cart_token");
    // if (cartToken == null) {
    //   await cartController.addToCart(CartDetails(
    //     productId: productModel!.data![index].id!,
    //     productDiscountPrice:
    //         productModel!.data![index].productMrpPrice.toString(),
    //     quantity: productModel!.data![index].productQuantity!,
    //     latitude: "234",
    //     longitude: "234",
    //   ));
    //   productModel!.data![index].productQuantity =
    //       productModel!.data![index].productQuantity! + 1;
    // } else {
    await cartController
        .updateCart(CartDetails(
      productId: productModel!.data![index].id!,
      productDiscountPrice:
          productModel!.data![index].productDiscountPrice.toString(),
      quantity: productModel!.data![index].productQuantity +
          checkMeasurement(productModel!.data![index].productMeasurement!),
      latitude: "234",
      longitude: "234",
    ),"0",false)
        .then((value) async {
      Get.snackbar('Success', 'Cart Item Added Successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2));
      if (value) if (cartController.cartModel!.data!.cartDetails.isEmpty) {
        final prefs = await SharedPreferences.getInstance();
        prefs.remove("cart_token");
      }
    });
    // }
    productModel!.data![index].cartUpdateLoading = false;
    // isLoading = false;
    update();
  }

  void decrementProduct(
    int index,
  ) async {
    productModel!.data![index].cartUpdateLoading = true;
    update();
    if (productModel!.data![index].productQuantity! != 0) {
      await cartController
          .updateCart(CartDetails(
              productId: productModel!.data![index].id!,
              productDiscountPrice:
                  productModel!.data![index].productDiscountPrice.toString(),
              quantity: productModel!.data![index].productQuantity -
                  checkMeasurement(
                      productModel!.data![index].productMeasurement!),
              latitude: "234",
              longitude: "234"),"0",false)
          .then((value) async {
        Get.snackbar('Success', 'Cart Item Removed Successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            margin: const EdgeInsets.all(10),
            duration: const Duration(seconds: 2));
        if (value) if (cartController.cartModel!.data!.cartDetails.isEmpty) {
          final prefs = await SharedPreferences.getInstance();
          prefs.remove("cart_token");
        }
      });
      productModel!.data![index].cartUpdateLoading = false;
      update();
    }
    productModel!.data![index].cartUpdateLoading = false;
    update();
  }

  syncBoxCart() async {
    await Future.forEach<Data>(productModel!.data!, (element) {
      element.productQuantity = 0;
    });
    await Future.forEach<Data>(productModel!.data!, (element) {
      cartController.cartModel!.data.cartDetails.forEach((e) {
        if (element.id == e.productId) {
          element.productQuantity = e.quantity;
        }
      });
    });
    update();
  }

  checkMeasurement(String measurement) {
    if (measurement == "kg") {
      return 0.5;
    } else {
      return 1;
    }
  }
}
