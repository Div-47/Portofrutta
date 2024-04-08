import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fruits/controllers/cart_controller.dart';
import 'package:fruits/services/app_services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../screens/home.dart';
import '../screens/order_success.dart';

class PaymentController extends GetxController {
  Map<String, dynamic>? paymentIntentData;
  final cartController = Get.put(CartController());

  Future<void> makePayment(
      {required String amount, required String currency}) async {
    try {
      final billingDetails = BillingDetails(
        name: cartController
            .userAddressModel.data[cartController.selectedAddressIndex].name,
        email: cartController
            .userAddressModel.data[cartController.selectedAddressIndex].email,
        phone: cartController
            .userAddressModel.data[cartController.selectedAddressIndex].phone,
        address: Address(
          city: cartController
              .userAddressModel.data[cartController.selectedAddressIndex].city,
          country: "",
          line1: cartController.userAddressModel
              .data[cartController.selectedAddressIndex].flatOrHouseNumber,
          line2: cartController.userAddressModel
              .data[cartController.selectedAddressIndex].streetName,
          state: "",
          postalCode: cartController.userAddressModel
              .data[cartController.selectedAddressIndex].zipcode,
        ),
      );
      paymentIntentData = await createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          // applePay: PaymentSheetApplePay(merchantCountryCode: ),
          // googlePay: true,
          // testEnv: true,
          // merchantCountryCode: 'US',
          // setupIntentClientSecret: ,
          billingDetails: billingDetails,
          customFlow: true,

          merchantDisplayName: 'PortoFrutta',

          customerId: paymentIntentData!['customer'],
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
        ));
        displayPaymentSheet(paymentIntentData!['id']);
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(String transactionId) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      await checkout(transactionId);
      Get.snackbar('Payment', 'Payment Successful, Creating Order',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2));
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      print("exception:$e");
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    String secretKey =
        "sk_test_51IlthdSFNMjQpaqjhlXPktypmweqLZgBq0ymMoTDjuXtsPy13DCIU72uoDT3UGN0QlFP5XTI4PXHUiOxyBd5uJik0084EyVWEe";
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer $secretKey',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (double.parse(amount)) * 100;
    return a.toStringAsFixed(0);
  }

  Future checkout(String transactionId) async {
    await cartController.cartCheckout().then((value) async {
      if (jsonDecode(value)["status"] == "success") {
        cartController.isCartCheckoutLoading = true;
        update();
        await AppService().postOrderPaymetnApi(
            transactionId,
            cartController.paymentMethod,
            jsonDecode(value)["order_details"]["id"].toString());
        cartController.isCartCheckoutLoading = false;
        update();
        Get.delete<CartController>();
        Get.to(OrderSuccess(value));
      } else {
        Get.offAll(Home());
      }
    });
  }
}
