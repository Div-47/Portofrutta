import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fruits/controllers/list_controller.dart';
import 'package:fruits/models/cart_model.dart';
import 'package:fruits/models/delivery_details_model.dart';
import 'package:fruits/models/pickup_details_model.dart' as pickupDetails;
import 'package:fruits/models/user_address_model.dart';
import 'package:fruits/models/pickup_time_model.dart' as pickupTime;
import 'package:fruits/models/delivery_time_model.dart' as deliveryTime;

import 'package:fruits/screens/drawer/cart.dart';
import 'package:fruits/services/app_services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import "package:shared_preferences/shared_preferences.dart";
import '../models/product_model.dart';
import '../models/province_model.dart' as province;
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../screens/home.dart';
import '../screens/order_success.dart';
import '../screens/payment_option.dart';
import '../utility/logout.dart';
import 'box_controller.dart';

final listController = Get.put(ListController());
final boxController = Get.put(BoxController());

class CartController extends GetxController {
  bool isLoading = false;
  bool isPromoLoading = false;
  bool isProvinceLoading = false;
  bool isAddressLoading = false;
  bool isCouponAppliedSuccess = false;
  String appliedCouponCode = '';
  bool isCurrentLocationLoading = false;
  bool isDeliveryDetailsLoading = false;
  bool isPromoApplied = false;
  String deliveryType = '';
  bool isPickupDetailsLoading = false;
  bool isCartCheckoutLoading = false;
  bool cartCheckoutSuccess = false;
  String pickupLat = '';
  String pickupLng = '';
  String selectedPincode = '';
  String selectedDeliveryPrice = '';
  String selectedDeliveryDate = '';
  String selectedDeliveryTime = '';
  String selectedPickupDate = '';
  String selectedPickupTime = '';
  String paymentMethod = '';
  String shippping_method_id = '';

  List<Marker> markers = <Marker>[];
  bool addressSelected = false;
  int selectedAddressIndex = 0;
  LatLng? selectedPickupLatLng;

  bool success = false;
  late CartModel cartModel;
  late province.ProvinceModel provinceModel;
  late UserAddressModel userAddressModel;
  late DeliveryDetailsModel deliveryDetailsModel;
  late pickupDetails.PickupDetailsModel pickupDetailsModel;
  late pickupTime.PickupTimeModel pickupTimeModel;
  late deliveryTime.DeliveryTimeModel deliveryTimeModel;
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(22.7196, 75.8577),
    zoom: 14.4746,
  );
  GoogleMapController? googleMapController;

  Future fetchCart() async {
    cartModel = CartModel(data: CartData(token: '', cartDetails: []));
    try {
      isLoading = true;
      update();
      var response = await AppService().getCartApi();
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        cartModel = CartModel.fromJson(data);
        update();
        print(cartModel);
      } else if (response.statusCode == 401) {
        logout();
        Get.snackbar("401 Unauthorized", "Authorization Failed");
      } else {
        cartModel = CartModel(data: CartData(cartDetails: [], token: ""));
        update();
      }
    } catch (e) {
      print("fetch cart -----> $e");
      isLoading = false;
      cartModel = CartModel(data: CartData(cartDetails: [], token: ""));
      update();
    }

    isLoading = false;
    listController.syncListCart();

    boxController.syncBoxCart();
    update();
  }

  Future updateCart(CartDetails model, String isProductAddFromDetailsPage,
      bool isCouponApplied) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      isLoading = true;
      success = false;
      update();

      var response = await AppService().postUpdateCartApi(
          model, isProductAddFromDetailsPage, isCouponApplied);
      var res = await response.stream.bytesToString();
      print(res);
      if (response.statusCode == 200) {
        success = true;

        var _cartUserId = json.decode(res)["data"]["user_id"];
        if (prefs.getInt("cart_user_id") == null) {
          if (_cartUserId != null) {
            prefs.setInt("cart_user_id", _cartUserId);
            prefs.remove("cart_token");
          }
        }

        String? cartToken = prefs.getString("cart_token");
        int? cartUserId = prefs.getInt("cart_user_id");

        if (cartUserId == null) {
          if (cartToken == null) {
            var _cartToken = json.decode(res)["data"]["token"];
            prefs.setString("cart_token", _cartToken);
          }
        }
        if (token == null) {
          var _cartToken = json.decode(res)["data"]["token"];
          prefs.setString("cart_token", _cartToken);
        }
        cartModel = CartModel.fromJson(json.decode(res));
        listController.syncListCart();

        boxController.syncBoxCart();
        update();
      } else if (response.statusCode == 401) {
        logout();
        Get.snackbar("401 Unauthorized", "Authorization Failed");
      } else {
        Get.snackbar("Failed", "An Error Occurred");
      }
    } catch (e) {
      print("update cart -----> $e");

      isLoading = false;
      update();
    }
    isLoading = false;
    update();
    return success;
  }

  Future<province.ProvinceModel> getProvince() async {
    try {
      provinceModel = province.ProvinceModel(status: "false", data: []);
      final prefs = await SharedPreferences.getInstance();
      isProvinceLoading = true;
      success = false;
      update();
      var response = await AppService().getProvinceApi();
      if (response.statusCode == 200) {
        success = true;
        var data = jsonDecode(response.body.toString());
        // provinceModel = ProvinceModel(data: [], status: "");
        provinceModel = province.ProvinceModel.fromJson(data);
      } else if (response.statusCode == 401) {
        logout();
        Get.snackbar("401 Unauthorized", "Authorization Failed");
      }
    } catch (e) {
      print(e);
      isProvinceLoading = false;
      update();
    }

    isProvinceLoading = false;
    update();
    return provinceModel;
  }

  Future<UserAddressModel> getUserAddresses() async {
    try {
      userAddressModel = UserAddressModel(status: "false", data: []);
      final prefs = await SharedPreferences.getInstance();
      isAddressLoading = true;
      success = false;
      update();
      var response = await AppService().getUserAddressesApi();
      if (response.statusCode == 200) {
        success = true;
        var data = jsonDecode(response.body.toString());
        // provinceModel = ProvinceModel(data: [], status: "");
        userAddressModel = UserAddressModel.fromJson(data);
      } else if (response.statusCode == 401) {
        logout();
        Get.snackbar("401 Unauthorized", "Authorization Failed");
      }
    } catch (e) {
      print(e);
      isAddressLoading = false;
      update();
    }

    isAddressLoading = false;
    update();
    return userAddressModel;
  }

  Future<DeliveryDetailsModel> getDeliveryDetails() async {
    try {
      deliveryDetailsModel = DeliveryDetailsModel(status: "false", data: []);
      final prefs = await SharedPreferences.getInstance();
      isDeliveryDetailsLoading = true;
      success = false;
      update();
      var response = await AppService().getDeliveryDetailsApi();
      if (response.statusCode == 200) {
        success = true;
        var data = jsonDecode(response.body.toString());
        // provinceModel = ProvinceModel(data: [], status: "");
        deliveryDetailsModel = DeliveryDetailsModel.fromJson(data);
      } else if (response.statusCode == 401) {
        logout();
        Get.snackbar("401 Unauthorized", "Authorization Failed");
      }
    } catch (e) {
      print(e);
      isDeliveryDetailsLoading = false;
      update();
    }

    isDeliveryDetailsLoading = false;
    update();
    return deliveryDetailsModel;
  }

  Future<pickupDetails.PickupDetailsModel> getPickupDetails() async {
    try {
      pickupDetailsModel =
          pickupDetails.PickupDetailsModel(status: "false", data: []);
      final prefs = await SharedPreferences.getInstance();
      isPickupDetailsLoading = true;
      success = false;
      update();
      var response = await AppService().getPickupDetailsApi();
      if (response.statusCode == 200) {
        success = true;
        var data = jsonDecode(response.body.toString());
        // provinceModel = ProvinceModel(data: [], status: "");
        pickupDetailsModel = pickupDetails.PickupDetailsModel.fromJson(data);
      } else if (response.statusCode == 401) {
        logout();
        Get.snackbar("401 Unauthorized", "Authorization Failed");
      }
    } catch (e) {
      print(e);
      isPickupDetailsLoading = false;
      update();
    }

    isPickupDetailsLoading = false;
    update();
    return pickupDetailsModel;
  }

  Future<pickupTime.PickupTimeModel> getPickupTimeDetails() async {
    try {
      pickupTimeModel = pickupTime.PickupTimeModel(status: "false", data: []);
      final prefs = await SharedPreferences.getInstance();
      isPickupDetailsLoading = true;
      success = false;
      update();
      var response = await AppService().getPickupTimeApi();
      if (response.statusCode == 200) {
        success = true;
        var data = jsonDecode(response.body.toString());
        // provinceModel = ProvinceModel(data: [], status: "");
        pickupTimeModel = pickupTime.PickupTimeModel.fromJson(data);
      } else if (response.statusCode == 401) {
        logout();
        Get.snackbar("401 Unauthorized", "Authorization Failed");
      }
    } catch (e) {
      print(e);
      isPickupDetailsLoading = false;
      update();
    }

    isPickupDetailsLoading = false;
    update();
    return pickupTimeModel;
  }

  Future<deliveryTime.DeliveryTimeModel> getDeliveryTimeDetails() async {
    try {
      deliveryTimeModel =
          deliveryTime.DeliveryTimeModel(status: "false", data: []);
      final prefs = await SharedPreferences.getInstance();
      isDeliveryDetailsLoading = true;
      success = false;
      update();
      var response = await AppService().getDeliveryTimeApi();
      if (response.statusCode == 200) {
        success = true;
        var data = jsonDecode(response.body.toString());
        // provinceModel = ProvinceModel(data: [], status: "");
        deliveryTimeModel = deliveryTime.DeliveryTimeModel.fromJson(data);
      } else if (response.statusCode == 401) {
        logout();
        Get.snackbar("401 Unauthorized", "Authorization Failed");
      }
    } catch (e) {
      print(e);
      isDeliveryDetailsLoading = false;
      update();
    }

    isDeliveryDetailsLoading = false;
    update();
    return deliveryTimeModel;
  }

  Future checkPromocode(String code, bool isCouponApplied) async {
    var res;
    try {
      final prefs = await SharedPreferences.getInstance();
      isPromoLoading = true;
      success = false;
      update();
      var response = await AppService().postCheckPromocode(code);
      res = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        var code = jsonDecode(res)["data"]["code"];
        var productToBePurchased =
            int.tryParse(jsonDecode(res)["data"]["product_to_be_purchased"]);
        var productToGive = jsonDecode(res)["data"]["product_to_give"];
        var productToGiveQuantity = jsonDecode(res)["data"]["quantity"];
        for (var cart in cartModel.data.cartDetails) {
          if (productToBePurchased! == cart.productId) {
            success = true;
            await updateCart(
                    CartDetails(
                        productId: int.tryParse(productToGive)!,
                        quantity: int.tryParse(productToGiveQuantity)!,
                        productDiscountPrice: "0.0",
                        latitude: "123",
                        longitude: "123"),
                    "0",
                    isCouponApplied)
                .then((value) async {
              if (value) {
                Get.snackbar('Success', '$code Applied Successfully',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    margin: const EdgeInsets.all(10),
                    duration: const Duration(seconds: 2));
                isCouponAppliedSuccess = true;
                appliedCouponCode = code;
                await Future.delayed(Duration(seconds: 2));

                update();
              } else {
                Get.snackbar('Failed', '$code Applied Failed',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                    margin: const EdgeInsets.all(10),
                    duration: const Duration(seconds: 2));
              }
            });
            break;
          }
        }
        if (success == false) {
          Get.snackbar('Failed', 'Relevant Product Not Found In Cart',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
              margin: const EdgeInsets.all(10),
              duration: const Duration(seconds: 2));
        }
      } else if (response.statusCode == 401) {
        logout();
        Get.snackbar("401 Unauthorized", "Authorization Failed");
      }
    } catch (e) {
      print(e);
      isPromoLoading = false;
      update();
    }

    isPromoLoading = false;
    update();
    return res;
  }

  void setAddressIndex(int index) {
    selectedAddressIndex = index;
    update();
  }

  void setDeliveryType(String type) {
    deliveryType = type;
    update();
  }

  addMarker() async {
    markers = [];
    await Future.forEach<pickupDetails.Data>(pickupDetailsModel.data,
        (element) {
      markers.add(Marker(
          markerId: MarkerId(element.id.toString() ?? ""),
          position: LatLng(
            double.parse(element.latitude != null ? element.latitude! : "0.00"),
            double.parse(
                element.longitude != null ? element.longitude! : "0.00"),
          ),
          infoWindow: InfoWindow(
            title: element.pickupName! ?? "",
            snippet: element.from! + " - " + element.to!,
          ),
          onTap: () {
            shippping_method_id = element.id.toString();
            pickupLat = element.latitude != null ? element.latitude! : "0.00";
            pickupLng = element.longitude != null ? element.longitude! : "0.00";
            Get.snackbar("Success", "Pickup location selected succesfully");
          }));
      // cameraPosition = CameraPosition(
      //     target: LatLng(
      //         double.parse(
      //             element.latitude != null ? element.latitude! : "0.00"),
      //         double.parse(
      //             element.longitude != null ? element.longitude! : "0.00")),
      //     zoom: 20);

      // googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
      //     CameraPosition(
      //         target: LatLng(
      //             double.parse(
      //                 element.latitude != null ? element.latitude! : "0.00"),
      //             double.parse(
      //                 element.longitude != null ? element.longitude! : "0.00")),
      //         zoom: 20)));

      update();
    });
  }

  void updateCameraPosition(double lat, double lng) {
    googleMapController!.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(lat != null ? lat : 0.00, lng != null ? lng : 0.00),
            zoom: 20)));
    update();
  }

  void fetchCurrentLocation() async {
    LocationPermission permission;

    permission = await Geolocator.requestPermission();
    isCurrentLocationLoading = true;
    update();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    cameraPosition = CameraPosition(
        target: LatLng(position.latitude != null ? position.latitude : 0.00,
            position.longitude != null ? position.longitude : 0.00),
        zoom: 20);
    googleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  Future<double> calculateTotal() async {
    double price = 0.0;
    await Future.forEach<CartDetails>(cartModel.data.cartDetails, (element) {
      price +=
              // element.productMeasurement == "pcs"
              //     ?
              element.quantity * (double.parse(element.productDiscountPrice!))
          // : (element.quantity / 0.5) *
          //     (double.parse(element.productDiscountPrice!))
          ;
    });
    return price;
  }

  Future<double> calculateTotalQuantity() async {
    double quantity = 0.0;
    await Future.forEach<CartDetails>(cartModel.data.cartDetails, (element) {
      quantity += double.parse(element.quantity.toString());
    });
    return quantity;
  }

  Future cartCheckout() async {
    var res;
    try {
      final prefs = await SharedPreferences.getInstance();
      double total = await calculateTotal();
      double subTotal = total +
              double.tryParse(selectedDeliveryPrice.isNotEmpty
                  ? selectedDeliveryPrice
                  : "0")! ??
          0;
      double totalQuantity = await calculateTotalQuantity();
      isCartCheckoutLoading = true;
      cartCheckoutSuccess = false;
      update();
      var response = await AppService().postCartCheckoutApi({
        "user_shipping_address":
            userAddressModel.data[selectedAddressIndex].id.toString(),
        "user_billing_address":
            userAddressModel.data[selectedAddressIndex].id.toString(),
        "delivery_charge": selectedDeliveryPrice,
        "total_items": cartModel.data.cartDetails.length.toString(),
        "total_quantity": totalQuantity.toStringAsFixed(2),
        // "_checkout_vat_tax": "0",
        "_checkout_subtotal_amnt": subTotal.toStringAsFixed(2),
        "_checkout_total_amnt": total.toStringAsFixed(2),
        // "product_discount_price": total.toStringAsFixed(2),
        "delivery_date": selectedDeliveryDate,
        "delivery_time": selectedDeliveryTime,
        "pickup_date": selectedPickupDate,
        "pickup_time": selectedPickupTime,
        "pickup_latitude": pickupLat,
        "pickup_longitude": pickupLng,
        "delivery_type": deliveryType,
        "shipping_method_id": shippping_method_id
      });
      res = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        prefs.remove("cart_token");
        await fetchCart();
        cartCheckoutSuccess = true;
      } else if (response.statusCode == 401) {
        logout();
        Get.snackbar("401 Unauthorized", "Authorization Failed");
      } else {
        prefs.remove("cart_token");
        print(res);
        Get.snackbar("Failed", "Cart Checkout Failed");
        Get.offAll(Home());
      }
    } catch (e) {
      await fetchCart();
      print(e);
      isCartCheckoutLoading = false;
      update();
    }
    isCartCheckoutLoading = false;
    update();
    return res;
  }

  void validateDeliveryTypeScreen() {
    if (deliveryType.isNotEmpty) {
      if (deliveryType == "delivery") {
        if (selectedPincode.isEmpty) {
          Get.snackbar("Failed", "Please select the pincode");
        } else if (selectedDeliveryDate.isEmpty) {
          Get.snackbar("Failed", "Please select Delivery Date");
        } else if (selectedDeliveryTime.isEmpty) {
          Get.snackbar("Failed", "Please select Delivery Time");
        } else {
          Get.to(PaymentOption());
        }
      } else if (deliveryType == "pickup") {
        if (pickupLat.isEmpty && pickupLng.isEmpty) {
          Get.snackbar("Failed", "Please Select Pickup Location");
        } else if (selectedPickupDate.isEmpty) {
          Get.snackbar("Failed", "Please Select Pickup Date");
        } else if (selectedPickupTime.isEmpty) {
          Get.snackbar("Failed", "Please Select Pickup Time");
        } else {
          Get.to(PaymentOption());
        }
      }
    } else {
      Get.snackbar("Failed", "Please select Delivery Type");
    }
  }

  Future<Placemark> getLocation() async {
    LocationPermission permission;
    // permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    isCurrentLocationLoading = true;
    update();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    isCurrentLocationLoading = false;
    update();
    return placemarks[0];
  }

  // Future checkout() async {
  //   if (addressSelected != false) {
  //     cartCheckout().then((value) {
  //       if (value != null) {
  //         if (value) {
  //           Get.to(OrderSuccess(value));
  //         }
  //       } else {
  //         Get.to(CartScreen());
  //       }
  //     });
  //   } else {
  //     Get.snackbar("Failed", "No Addresses Found. Please Add");
  //   }
  // }
  void paymentLoading(bool value) {
    isCartCheckoutLoading = value;
    update();
  }
}
