import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import "package:flutter/material.dart";
import 'package:fruits/controllers/cart_controller.dart';
import 'package:fruits/controllers/payment_controller.dart';
import 'package:fruits/models/cart_model.dart';
import 'package:fruits/models/province_model.dart';
import 'package:fruits/screens/bottomNavigationItems/home_screen.dart';
import 'package:fruits/screens/drawer/cart.dart';
import 'package:fruits/screens/user_addresses.dart';
import 'package:fruits/utility/colors.dart';
import 'package:fruits/utility/text_style.dart';
import 'package:fruits/widget.dart/text_field_styles.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:get/get.dart';

import '../services/app_services.dart';
import 'add_payment_method.dart';
import 'home.dart';
import 'order_success.dart';

class PaymentOption extends StatefulWidget {
  PaymentOption({Key? key}) : super(key: key);

  @override
  State<PaymentOption> createState() => _PaymentOptionState();
}

class _PaymentOptionState extends State<PaymentOption> {
  int groupValue = -1;
  bool isPromoAvailable = false;
  final controller = Get.put(CartController());
  final paymentController = Get.put(PaymentController());
  @override
  void initState() {
    // TODO: implement initState
    controller.getProvince();
    controller.getUserAddresses().then((value) {
      if (value != null && value.data.isNotEmpty) {
        controller.addressSelected = true;
      }
    });
    super.initState();
  }

  final promoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        init: controller,
        builder: (con) {
          return Scaffold(
              appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Color(0xffff5340),
                  title: Text("Payment Option")),
              bottomNavigationBar: Container(
                height: 105,
                color: Colors.white,
                alignment: Alignment.topCenter,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width * 8,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(10),
                        primary: Color(0xffF11515),
                        shape: StadiumBorder()),
                    child: controller.isCartCheckoutLoading
                        ? Center(
                            child: SizedBox(
                                height: 40,
                                width: 26,
                                child: CircularProgressIndicator()),
                          )
                        : Text(
                            "Checkout",
                            style: GoogleFonts.poppins(
                                color: ColorResource.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                    onPressed: () async {
                      if (controller.addressSelected) {
                        if (groupValue == 0 && controller.addressSelected) {
                          controller.paymentLoading(true);
                          await paymentController.makePayment(
                              amount: "${await calculateSubTotal()}",
                              currency: "USD");
                          controller.paymentLoading(false);
                        } else {
                          Get.snackbar(
                              "Failed", "Please select the payment method");
                        }
                      } else {
                        Get.snackbar(
                            "Failed", "Please select the shipping address");
                      }
                    },
                  ),
                ),
              ),
              body: Container(
                height: double.infinity,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(children: [
                    SizedBox(height: 20),
                    // Container(
                    //   height: 240,
                    //   color: Colors.white,
                    //   child: Center(
                    //     child: SizedBox(
                    //       height: 140,
                    //       // width: 240,
                    //       child: GestureDetector(
                    //         onTap: () {
                    //           Get.to(AddPaymentMethod());
                    //         },
                    //         child: DottedBorder(
                    //           borderType: BorderType.RRect,
                    //           radius: Radius.circular(12),
                    //           color: Colors.black54,
                    //           strokeWidth: 1,
                    //           padding: EdgeInsets.all(40),
                    //           child: Column(
                    //             mainAxisAlignment: MainAxisAlignment.center,
                    //             children: [
                    //               Icon(
                    //                 Icons.add,
                    //                 color: Colors.black26,
                    //               ),
                    //               Text(
                    //                 "Add Payment Method",
                    //                 style: TextStyle(color: Colors.black26),
                    //               )
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Text(
                      "Select Payment Method",
                      style: headingStyleAColor18SB(),
                    ),
                    SizedBox(height: 20),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          // SizedBox(height: 10),
                          // Divider(thickness: 2),
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: RadioListTile(
                          //         value: 0,
                          //         groupValue: groupValue,
                          //         onChanged: (v) {
                          //           setState(() {
                          //             groupValue = v! as int;
                          //             controller.paymentMethod = "cash";
                          //           });
                          //         },
                          //         title: Text("Cash on delivery"),
                          //       ),
                          //     )
                          //   ],
                          // ),

                          // Divider(thickness: 2),

                          SizedBox(
                            // height: 40,
                            child: Row(
                              children: [
                                Expanded(
                                  child: RadioListTile(
                                    value: 0,
                                    groupValue: groupValue,
                                    onChanged: (v) {
                                      setState(() {
                                        groupValue = v! as int;
                                        controller.paymentMethod = "stripe";
                                      });
                                    },
                                    title: Text("Stripe"),
                                  ),
                                )
                              ],
                            ),
                          ),
                          // Divider(thickness: 2),
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: RadioListTile(
                          //         value: 1,
                          //         groupValue: groupValue,
                          //         onChanged: (v) {
                          //           setState(() {
                          //             groupValue = v! as int;
                          //             controller.paymentMethod = "paypal";
                          //           });
                          //         },
                          //         title: Text("Paypal"),
                          //       ),
                          //     )
                          //   ],
                          // ),
                          // Divider(thickness: 2),
                          // SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                controller.isAddressLoading
                                    ? SizedBox()
                                    : controller.userAddressModel.data !=
                                                null &&
                                            controller.userAddressModel.data
                                                .isNotEmpty
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Deliver to ${controller.userAddressModel.data[controller.selectedAddressIndex].name}, ${controller.userAddressModel.data[controller.selectedAddressIndex].zipcode}",
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                maxLines: 2,
                                              ),
                                              Text(
                                                '${controller.userAddressModel.data[controller.selectedAddressIndex].streetName}, ${controller.userAddressModel.data[controller.selectedAddressIndex].city}',
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                              )
                                            ],
                                          )
                                        : SizedBox()
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(UserAddress());
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Color(0xffF11515)),
                              child: Text(
                                "Change",
                                style: headingStyle16MBWhite(),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: controller.isCouponAppliedSuccess == true
                                  ? Text("Applied Code")
                                  : SizedBox(),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(controller.appliedCouponCode),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isPromoAvailable = !isPromoAvailable;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Color(0xffF11515)),
                                child: Text(
                                  "Have a Promocode?",
                                  style: headingStyle16MBWhite(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    isPromoAvailable ? promocode() : SizedBox(),

                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Price Details",
                            style: headingStyle18SBblack(),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Price ( ${controller.cartModel.data.cartDetails.length.toString()} item)",
                                style: headingStyle14MBBlack(),
                              ),
                              FutureBuilder<double>(
                                  future: controller.calculateTotal(),
                                  builder: (context, snapshot) {
                                    if (snapshot.data != null)
                                      return Text(
                                        "€ " +
                                            snapshot.data!.toStringAsFixed(2),
                                        style: headingStyle14MBRed(),
                                      );
                                    else
                                      return Text('');
                                  })
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Vat Tax",
                                style: headingStyle14MBBlack(),
                              ),
                              Text(
                                "€ 0",
                                style: headingStyle14MBRed(),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Shipping Charges",
                                style: headingStyle14MBBlack(),
                              ),
                              Text(
                                "€ " + controller.deliveryType == "delivery"
                                    ? controller.selectedDeliveryPrice
                                    : "€ 0",
                                style: headingStyle14MBRed(),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: headingStyle14MBBlack(),
                              ),
                              FutureBuilder<double>(
                                  future: calculateSubTotal(),
                                  builder: (context, snapshot) {
                                    if (snapshot.data != null)
                                      return Text(
                                        "€ " +
                                            snapshot.data!.toStringAsFixed(2),
                                        style: headingStyle14MBRed(),
                                      );
                                    else
                                      return Text('');
                                  })
                            ],
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              ));
        });
  }

  Widget promocode() {
    return Container(
      padding: EdgeInsets.all(20),
      // height: 200,
      child: Column(
        children: [
          greyTextField("PromoCode", promoController,
              TextInputType.emailAddress, false, "", (v) {}),
          SizedBox(
            width: 140,
            child: ElevatedButton(
              onPressed: () async {
                await controller.checkPromocode(promoController.text, true);
                isPromoAvailable = !isPromoAvailable;
              },
              child: controller.isPromoLoading
                  ? SizedBox(
                      height: 24,
                      width: 24,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : Text("Apply Coupon"),
              style: ElevatedButton.styleFrom(primary: ColorResource.green),
            ),
          )
        ],
      ),
    );
  }

  Future<double> calculateSubTotal() async {
    if (controller.deliveryType == "delivery") {
      return await controller.calculateTotal() +
          double.tryParse(controller.selectedDeliveryPrice.isNotEmpty
              ? controller.selectedDeliveryPrice
              : "0")!;
    } else {
      return await controller.calculateTotal();
    }
  }

  Future checkout() async {
    await controller.cartCheckout().then((value) {
      if (jsonDecode(value)["status"] == "success") {
        Get.delete<CartController>();
        Get.to(OrderSuccess(value));
      } else {
        Get.delete<CartController>();
        Get.offAll(Home());
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.isCouponAppliedSuccess = false;
    controller.appliedCouponCode = '';
    super.dispose();
  }
}
