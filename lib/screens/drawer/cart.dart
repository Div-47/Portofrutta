import "package:flutter/material.dart";
import 'package:fruits/controllers/cart_controller.dart';
import 'package:fruits/screens/choose_delivery_type.dart';
import 'package:fruits/screens/login.dart';
import 'package:fruits/screens/payment_option.dart';
import 'package:fruits/services/app_services.dart';
import 'package:fruits/utility/colors.dart';
import 'package:fruits/utility/text_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/cart_model.dart';
import '../add_new_address.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cartController = Get.put(CartController());
  @override
  void initState() {
    // TODO: implement initState
    cartController.fetchCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        init: cartController,
        builder: (con) {
          return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                backgroundColor: Color(0xffff5340),
                title: Text("My Cart")),
            bottomNavigationBar:
                cartController.cartModel.data!.cartDetails.length != 0
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20),
                        child: SizedBox(
                          height: 45,
                          width: MediaQuery.of(context).size.width * 8,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(10),
                                primary: Color(0xffF11515),
                                shape: StadiumBorder()),
                            child: Text(
                              "Next",
                              style: GoogleFonts.poppins(
                                  color: ColorResource.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            onPressed: () {
                              AppService().isUserLoggedIn().then((value) {
                                if (value) {
                                  Get.to(ChooseDeliveryType());
                                } else {
                                  Get.snackbar(
                                      "Failed", "Please sign in to checkout");
                                  Get.offAll(LoginScreen());
                                }
                              });
                            },
                          ),
                        ),
                      )
                    : SizedBox(),
            body: GetBuilder<CartController>(
                init: cartController,
                builder: (con) {
                  if (cartController.isLoading == false) {
                    return cartController.cartModel.data!.cartDetails.length !=
                            0
                        ? Container(
                            height: double.infinity,
                            width: double.infinity,
                            child: SafeArea(
                              child: SingleChildScrollView(
                                child: Column(children: [
                                  Container(
                                    height: 55,
                                    padding: EdgeInsets.only(
                                        top: 20,
                                        right: 20,
                                        left: 20,
                                        bottom: 10),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                Get.to(AddNewAddress());
                                              },
                                              child: Text(
                                                "+ Add New Address",
                                                style:
                                                    headingStyle16MBAppColor(),
                                              ))
                                        ]),
                                  ),

                                  ListView.builder(
                                      itemCount:
                                          cartController.cartModel != null
                                              ? cartController.cartModel.data!
                                                  .cartDetails.length
                                              : 0,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Divider(
                                              color: ColorResource.light_white,
                                              thickness: 5,
                                            ),
                                            Container(
                                              // height: 50,
                                              padding: EdgeInsets.only(
                                                  top: 20,
                                                  right: 20,
                                                  left: 20,
                                                  bottom: 10),
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Image.network(
                                                          cartController
                                                              .cartModel!
                                                              .data!
                                                              .cartDetails[
                                                                  index]
                                                              .productImage!,
                                                          height: 80,
                                                          width: 80,
                                                        ),
                                                        SizedBox(width: 20),
                                                        Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(cartController
                                                                      .cartModel!
                                                                      .data!
                                                                      .cartDetails[
                                                                          index]
                                                                      .name! ??
                                                                  ''),
                                                              SizedBox(
                                                                  height: 5),
                                                              Text(
                                                                  "€ " +
                                                                      cartController
                                                                          .cartModel!
                                                                          .data!
                                                                          .cartDetails[
                                                                              index]
                                                                          .productDiscountPrice! +
                                                                      " " +
                                                                      cartController
                                                                          .cartModel!
                                                                          .data!
                                                                          .cartDetails[
                                                                              index]
                                                                          .productMeasurement!,
                                                                  style:
                                                                      headingStyle14MBRed()),
                                                              SizedBox(
                                                                  height: 5),
                                                              Text(cartController
                                                                  .cartModel!
                                                                  .data!
                                                                  .cartDetails[
                                                                      index]
                                                                  .quantity
                                                                  .toString())
                                                            ])
                                                      ],
                                                    )
                                                  ]),
                                            ),
                                            Divider(
                                              color: ColorResource.light_white,
                                              thickness: 2,
                                            ),
                                            GestureDetector(
                                                onTap: () async {
                                                  await cartController
                                                      .updateCart(CartDetails(
                                                          productId:
                                                              cartController
                                                                  .cartModel!
                                                                  .data!
                                                                  .cartDetails[
                                                                      index]
                                                                  .productId,
                                                          quantity: 0,
                                                          productDiscountPrice:
                                                              cartController
                                                                  .cartModel
                                                                  .data
                                                                  .cartDetails[
                                                                      index]
                                                                  .productDiscountPrice,
                                                          latitude: cartController
                                                                  .cartModel
                                                                  .data
                                                                  .cartDetails[
                                                                      index]
                                                                  .latitude ??
                                                              '939',
                                                          longitude: cartController
                                                                  .cartModel!
                                                                  .data!
                                                                  .cartDetails[
                                                                      index]
                                                                  .longitude ??
                                                              '333'),"0",false)
                                                      .then((value) async {
                                                    if (value) if (cartController
                                                        .cartModel!
                                                        .data!
                                                        .cartDetails
                                                        .isEmpty) {
                                                      final prefs =
                                                          await SharedPreferences
                                                              .getInstance();
                                                      prefs
                                                          .remove("cart_token");
                                                    }
                                                  });
                                                },
                                                child: cartController.isLoading
                                                    ? SizedBox(
                                                        height: 20,
                                                        width: 20,
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )
                                                    : Text("Remove")),
                                            SizedBox(height: 10),
                                            Divider(
                                              color: ColorResource.light_white,
                                              thickness: 2,
                                            ),
                                          ],
                                        );
                                      }),
                                  // SizedBox(height: 20),
                                  Divider(
                                    color: ColorResource.light_white,
                                    thickness: 35,
                                  ),
                                  Container(
                                    // height: 150,
                                    padding: EdgeInsets.only(
                                        top: 20,
                                        right: 20,
                                        left: 20,
                                        bottom: 10),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Price Details",
                                            style: headingStyle18SBblack(),
                                          ),
                                          SizedBox(height: 30),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            // crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Price ( ${cartController.cartModel.data.cartDetails.length} items )",
                                                    style: headingStyle14Grey(),
                                                  ),
                                                  Text(
                                                    "Delivery Fee",
                                                    style: headingStyle14Grey(),
                                                  ),
                                                ],
                                              ),
                                              FutureBuilder<double>(
                                                  future: cartController
                                                      .calculateTotal(),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.data != null)
                                                      return Text(
                                                        "€ ${snapshot.data!.toStringAsFixed(2)}",
                                                        style:
                                                            headingStyle14MBRed(),
                                                      );
                                                    else
                                                      return Text("0.00");
                                                  })
                                              // Text(
                                              //   "€ 5.00/ kg",
                                              //   style: headingStyle14MBRed(),
                                              // )
                                            ],
                                          )
                                        ]),
                                  ),
                                  Divider(
                                    color: ColorResource.light_white,
                                    thickness: 5,
                                  ),
                                  SizedBox(height: 10),

                                  Container(
                                      padding: EdgeInsets.only(
                                          top: 20,
                                          right: 20,
                                          left: 20,
                                          bottom: 20),
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Total Amount",
                                            style: headingStyle18SBblack(),
                                          ),
                                          FutureBuilder<double>(
                                              future: cartController
                                                  .calculateTotal(),
                                              builder: (context, snapshot) {
                                                if (snapshot.data != null)
                                                  return Text(
                                                    "€ ${snapshot.data!.toStringAsFixed(2)}",
                                                    style:
                                                        headingStyle14MBRed(),
                                                  );
                                                else
                                                  return Text("0.00");
                                              })
                                        ],
                                      )),

                                  SizedBox(height: 10),

                                  Divider(
                                    color: ColorResource.light_white,
                                    thickness: 5,
                                  ),
                                ]),
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              "Your Cart is Empty",
                              style: headingStyle16MB(),
                            ),
                          );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          );
        });
  }
}
