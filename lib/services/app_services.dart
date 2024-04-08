import 'dart:convert';
import 'dart:io';

import 'package:fruits/models/sign_up_model.dart';
import 'package:fruits/services/urls.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

import '../models/cart_model.dart';
import 'package:fruits/models/user_address_model.dart' as address;

class AppService {
  Future getListApi() async {
    var response =
        await http.get(Uri.parse(Url.BASE_URL + "user/list_products/"));
    return response;
  }

  Future getBoxApi() async {
    var response =
        await http.get(Uri.parse(Url.BASE_URL + "user/box_products/"));
    return response;
  }

  Future postSearchApi(String query) async {
    var body = {"name": query};
    var request = http.MultipartRequest(
        'POST', Uri.parse(Url.BASE_URL + "user/search_products/"))
      ..fields.addAll(body);
    var response = await request.send();
    return response;
  }

  Future getProductDetailsApi(int productId) async {
    var response =
        await http.get(Uri.parse(Url.BASE_URL + "user/get_product/$productId"));

    return response;
  }

  Future getOfferApi() async {
    var response =
        await http.get(Uri.parse(Url.BASE_URL + "user/offer_products/"));
    return response;
  }

  Future getProfileApi() async {
    final prefs = await SharedPreferences.getInstance();

    var token = prefs.getString("token")!;
    var response = await http
        .get(Uri.parse(Url.BASE_URL + "user/user_details/"), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    });
    print(response.body);
    return response;
  }

  Future postLoginApi(String userEmail, String userPassword) async {
    var body = {"email": userEmail, "password": userPassword};

    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(Url.BASE_URL + "user/login/"),
    )
      ..fields.addAll(body)
      ..headers.addAll({"Accept": "application/json"});
    var response = await request.send();
    return response;
  }

  Future postSignUpApi(SignUpModel model) async {
    var body = {
      "name": model.name!,
      "email": model.userEmail!,
      "password": model.userPassword!,
      "surname": model.lastName!,
      "phone": model.phone!,
      "city_of_birth": model.cityOfBirth!,
      "address_of_living": model.addressOfLiving!,
      "address_for_shipment": model.addressOfShipment!,
      "fiscal_code": model.fiscalCode!,
      "zip_code": model.zipCode!,
      "dob": model.dob!,
      "province_id": model.provinceId!,
      "street_name": model.streetName!,
      "flat": model.flat!,
      "state": model.state!,
      "country": model.country!,
      "road_name": model.roadName!,
    };

    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(Url.BASE_URL + "user/register/"),
    )
      ..fields.addAll(body)
      ..headers.addAll({"Accept": "application/json"});
    var response = await request.send();
    return response;
  }

  Future postForgotPasswordApi(String email, String password) async {
    var body = {"email": email,"password":password,"password_confirmation":password};
    var request = http.MultipartRequest(
        'POST', Uri.parse(Url.BASE_URL + "user/forgot-password/"))
      ..fields.addAll(body);
    var response = await request.send();
    return response;
  }

  Future postUserProfileUpdate(var body, String filePath) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Url.BASE_URL + "user/update_profile/"),
    )
      ..fields.addAll(body)
      ..headers.addAll(
          {"Accept": "application/json", "Authorization": "Bearer $token"});
    if (filePath.isNotEmpty) {
      request.files.add(http.MultipartFile.fromBytes(
          "profile_picture", File(filePath).readAsBytesSync(),
          contentType: MediaType('image', 'jpeg'),
          filename: filePath.split('/').last));
    }
    print(request);
    var response = await request.send();
    return response;
  }

  // Future postAddToCartApi(
  //   CartDetails model,
  // ) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString("token");
  //   var body = {
  //     "product_id": model.productId.toString(),
  //     "price": model.productDiscountPrice!,
  //     "quantity": model.quantity.toString(),
  //     "latitude": model.latitude,
  //     "longitude": model.longitude,
  //   };
  //   //   String url = '';
  //   // if (token != null && token.isNotEmpty) {
  //   //   url = Url.BASE_URL + "user/add_to_cart/";
  //   // } else if (token == null && (cartToken != null && cartToken.isNotEmpty)) {
  //   //   url = Url.BASE_URL + "user/get_cart/$cartToken";
  //   // }

  //   var request = await http.MultipartRequest(
  //     'POST',
  //     Uri.parse(Url.BASE_URL + "user/add_to_cart/"),
  //   )
  //     ..fields.addAll(body)
  //     ..headers.addAll({
  //       "Accept": "application/json",
  //       "Authorization":
  //           token != null && token.isNotEmpty ? "Bearer $token" : ""
  //     });
  //   var response = await request.send();
  //   var res = await response.stream.bytesToString();
  //   print(res);
  //   return response;
  // }

  Future postUpdateCartApi(CartDetails model,
      String isProductAddfromDetailsPage, bool isCouponApplied) async {
    final prefs = await SharedPreferences.getInstance();
    String? cartToken = prefs.getString("cart_token");
    String? token = prefs.getString("token");

    var body = {
      "product_id": model.productId.toString(),
      "price": model.productDiscountPrice!,
      "quantity": model.quantity.toString(),
      "new_cart": isProductAddfromDetailsPage,
      "latitude": model.latitude!,
      "longitude": model.longitude!,
      "apply_coupon": isCouponApplied.toString()
    };
    String url = '';
    var headers;
    if (token == null && cartToken == null) {
      url = Url.BASE_URL + "user/update_cart/";
    } else if (token == null && cartToken != null) {
      url = Url.BASE_URL + "user/update_cart/$cartToken";
    } else if (token != null && cartToken == null) {
      url = Url.BASE_URL + "user/update_cart/";
    } else if (token != null && cartToken != null) {
      url = Url.BASE_URL + "user/update_cart/$cartToken";
    }
    if (token != null) {
      headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
    } else {
      headers = {
        "Accept": "application/json",
      };
    }

    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(url),
    )
      ..fields.addAll(body)
      ..headers.addAll(headers);
    var response = await request.send();
    // var res = await response.stream.bytesToString();
    // print(res);
    return response;
  }

  Future getCartApi() async {
    var request;
    try {
      final prefs = await SharedPreferences.getInstance();
      String? cartToken = prefs.getString("cart_token");
      String? token = prefs.getString("token");
      String url = '';
      var headers;
      if (token == null && cartToken == null) {
        url = Url.BASE_URL + "user/get_cart/";
      } else if (token == null && cartToken != null) {
        url = Url.BASE_URL + "user/get_cart/$cartToken";
      } else if (token != null && cartToken == null) {
        url = Url.BASE_URL + "user/get_cart/";
      } else if (token != null && cartToken != null) {
        url = Url.BASE_URL + "user/get_cart/$cartToken";
      }
      // else if( token ){}
      if (token != null) {
        headers = {
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        };
      } else {
        headers = {
          "Accept": "application/json",
        };
      }
      print("token---> $token");
      print("cart token---> $cartToken");
      print("get cart url---> $url");

      request = await http.get(Uri.parse(url), headers: headers);
    } catch (e) {
      print(e);
    }

    return request;
  }

  Future getUserOrdersApi() async {
    final prefs = await SharedPreferences.getInstance();
    String? cartToken = prefs.getString("cart_token");
    String? token = prefs.getString("token");
    String url = '';
    var headers;
    if (token != null) {
      headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
    }
    var request = await http.get(Uri.parse(Url.BASE_URL + "user/orders/"),
        headers: headers);

    return request;
  }

  Future removeCartItemApi(int id) async {
    final prefs = await SharedPreferences.getInstance();
    String? cartToken = prefs.getString("cart_token");
    String? token = prefs.getString("token");
    String url = '';
    if (token != null && token.isNotEmpty) {
      url = Url.BASE_URL + "user/removeCart/?product_id=${id.toString()}";
    } else if (token == null && (cartToken != null && cartToken.isNotEmpty)) {
      url = Url.BASE_URL +
          "user/removeCart/$cartToken?product_id=${id.toString()}";
    }
    var request = await http.get(
      Uri.parse(url),
    )
      ..headers.addAll({
        "Accept": "application/json",
        "Authorization":
            token != null && token.isNotEmpty ? "Bearer $token" : ""
      });

    return request;
  }

  Future getProvinceApi() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    var headers;
    if (token != null) {
      headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
    } else {
      headers = {
        "Accept": "application/json",
      };
    }
    var request = await http.get(
      Uri.parse(Url.BASE_URL + "user/province"),
    )
      ..headers.addAll(headers);

    return request;
  }

  Future getUserAddressesApi() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    var headers;
    if (token != null) {
      headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
    } else {
      headers = {
        "Accept": "application/json",
      };
    }
    var request = await http.get(
        Uri.parse(Url.BASE_URL + "user/shipping_addresses/"),
        headers: headers);

    return request;
  }

  Future postCheckPromocode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    var headers;
    // if (token != null) {
    headers = {"Accept": "application/json", "Authorization": "Bearer $token"};
    // } else {
    //   headers = {
    //     "Accept": "application/json",
    //   };
    // }
    var request = http.MultipartRequest(
      "POST",
      Uri.parse(Url.BASE_URL + "user/get_coupon/"),
    );
    request.headers.addAll(headers);
    request.fields.addAll({"code": code});
    var response = await request.send();

    return response;
  }

  Future getDeliveryDetailsApi() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    var headers;
    if (token != null) {
      headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
    } else {
      headers = {
        "Accept": "application/json",
      };
    }
    var request = await http.get(
        Uri.parse(Url.BASE_URL + "user/delivery_details/"),
        headers: headers);

    return request;
  }

  Future getPickupDetailsApi() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    var headers;
    if (token != null) {
      headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
    } else {
      headers = {
        "Accept": "application/json",
      };
    }
    var request = await http.get(
        Uri.parse(Url.BASE_URL + "user/pickup_details/"),
        headers: headers);

    return request;
  }

  Future getPickupTimeApi() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    var headers;
    if (token != null) {
      headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
    } else {
      headers = {
        "Accept": "application/json",
      };
    }
    var request = await http.get(Uri.parse(Url.BASE_URL + "user/pickup_time/"),
        headers: headers);

    return request;
  }

  Future getDeliveryTimeApi() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    var headers;
    if (token != null) {
      headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      };
    } else {
      headers = {
        "Accept": "application/json",
      };
    }
    var request = await http
        .get(Uri.parse(Url.BASE_URL + "user/delivery_time/"), headers: headers);

    return request;
  }

  Future postAddressApi(address.Data model) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    var body = {
      "name": model.name!,
      "email": model.email!,
      "phone": model.phone!,
      "city": model.city!,
      "flat_number": model.phone!,
      "state": model.state!,
      "country": model.country!,
      "street_name": model.streetName!,
      "zipcode": model.zipcode!,
      // "address_for_shipment": model.addressOfShipment!,
      "province": model.provinceId!
    };

    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(Url.BASE_URL + "user/shipping_address/"),
    )
      ..fields.addAll(body)
      ..headers.addAll(
          {"Accept": "application/json", "Authorization": "Bearer $token"});
    var response = await request.send();
    return response;
  }

  Future postOrderPaymetnApi(
      String transactionId, String paymentMethod, String orderId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    var body = {
      "payment_method": paymentMethod,
      "transaction_id": transactionId,
      "order_id": orderId,
    };

    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(Url.BASE_URL + "user/order_payment/"),
    )
      ..fields.addAll(body)
      ..headers.addAll(
          {"Accept": "application/json", "Authorization": "Bearer $token"});
    var response = await request.send();
    return response;
  }

  Future postCartCheckoutApi(var body) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    var request = await http.MultipartRequest(
      'POST',
      Uri.parse(Url.BASE_URL + "user/place_order/"),
    )
      ..fields.addAll(body)
      ..headers.addAll(
          {"Accept": "application/json", "Authorization": "Bearer $token"});
    var response = await request.send();
    return response;
  }

  Future isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token != null ? true : false;
  }
}
