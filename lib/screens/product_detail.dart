import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fruits/controllers/cart_controller.dart';
import 'package:fruits/controllers/product_details_controller.dart';
import 'package:fruits/models/cart_model.dart';
import 'package:fruits/utility/colors.dart';
import 'package:fruits/utility/text_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';

class ProductDetail extends StatefulWidget {
  int productId;
  ProductDetail(this.productId);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int _current = 0;
  final controller = Get.put(ProductDetailsController());
  final cartController = Get.put(CartController());

  final CarouselController _controller = CarouselController();
  var list = [
    1,
    2,
    3,
  ];
  @override
  void initState() {
    // TODO: implement initState
    controller.getProductDetails(widget.productId);
    super.initState();
  }

  bool addToCartLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorResource.light_white,
      bottomNavigationBar: Container(
        height: 105,
        color: Colors.white,
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: SizedBox(
          height: 45,
          width: MediaQuery.of(context).size.width * 8,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(10),
                primary: Color(0xffF11515),
                shape: StadiumBorder()),
            child: addToCartLoading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(),
                  )
                : Text(
                    "Add To Cart",
                    style: GoogleFonts.poppins(
                        color: ColorResource.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
            onPressed: () {
              addProductToCart();
            },
          ),
        ),
      ),

      body: GetBuilder<ProductDetailsController>(
          init: controller,
          builder: (con) {
            if (controller.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Container(
                height: double.infinity,
                width: double.infinity,
                child: SafeArea(
                    child: SingleChildScrollView(
                        child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                              height: 300.0,
                              autoPlay: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              }),
                          items: [
                            1,
                            2,
                            3,
                          ].map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Image.network(
                                  controller
                                      .productDetailsModel!.data.productImage,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                );
                              },
                            );
                          }).toList(),
                        ),
                        Positioned(
                          top: 6,
                          left: 4,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.white70),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                  size: 30,
                                )),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: list.asMap().entries.map((entry) {
                              return Container(
                                width: 12.0,
                                height: 12.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _current == entry.key
                                        ? Color(0xffF11515)
                                        : Colors.white
                                    // (Theme.of(context).brightness == Brightness.dark
                                    //         ? Colors.white
                                    //         : Colors.black)
                                    //     .withOpacity(_current == entry.key ? 0.9 : 0.4)
                                    ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 80,
                      padding: EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.productDetailsModel!.data.name,
                                style: headingStyle16MB()),
                            Row(
                              children: [
                                Text(
                                    "€ ${controller.productDetailsModel!.data.productDiscountPrice}/ ${controller.productDetailsModel!.data.productMeasurement}",
                                    style: headingStyle14MBRed()),
                                SizedBox(width: 10),
                                Text(
                                    "€ ${controller.productDetailsModel!.data.productMrpPrice}/ ${controller.productDetailsModel!.data.productMeasurement}  ",
                                    style: GoogleFonts.poppins(
                                        color: Color(0xff9B9B9B),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        decoration:
                                            TextDecoration.lineThrough)),
                                Text(
                                    "${calculatePercentage(controller.productDetailsModel!.data.productMrpPrice!, controller.productDetailsModel!.data.productDiscountPrice!)}%  off ",
                                    style: headingStyle13MBLightGrey())
                              ],
                            )
                          ]),
                    ),
                    Divider(
                      color: ColorResource.light_white,
                      thickness: 5,
                    ),
                    Container(
                      height: 80,
                      padding: EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: ColorResource.red),
                                  child: Center(
                                      child: Text(
                                    "P",
                                    style: headingStyle16MBWhite(),
                                  )),
                                ),
                                SizedBox(width: 10),
                                Text("Portofrutta", style: headingStyle16MB()),
                              ],
                            ),
                          ]),
                    ),
                    Divider(
                      color: ColorResource.light_white,
                      thickness: 5,
                    ),
                    Container(
                      height: 280,
                      padding: EdgeInsets.only(
                          top: 20, right: 20, left: 20, bottom: 10),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller
                                .productDetailsModel!.data.productDescription!),
                          ]),
                    ),
                    Divider(
                      color: ColorResource.light_white,
                      thickness: 5,
                    ),
                    Container(
                      height: 220,
                      padding: EdgeInsets.only(
                          top: 20, right: 20, left: 20, bottom: 10),
                      child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Details",
                              style: headingStyle18SBblack(),
                            ),
                            SizedBox(height: 30),
                            Row(
                              children: [
                                Text(
                                  "Condition",
                                  style: headingStyle14Grey(),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                Text(
                                  "Organic",
                                  style: headingStyle14MBBlack(),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  "Price Type",
                                  style: headingStyle14Grey(),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                Text(
                                  "Fixed",
                                  style: headingStyle14MBBlack(),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Category  ",
                                  style: headingStyle14Grey(),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                Text(
                                  controller.productDetailsModel!.data.category,
                                  style: headingStyle14MBBlack(),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.start,
                            //   children: [
                            //     Text(
                            //       "Location",
                            //       style: headingStyle14Grey(),
                            //     ),
                            //     SizedBox(
                            //       width: 60,
                            //     ),
                            //     Text(
                            //       "Kualalumpur, Malaysia",
                            //       style: headingStyle14MBBlack(),
                            //     ),
                            //   ],
                            // ),
                            // SizedBox(height: 10),
                          ]),
                    ),
                    Divider(
                      color: ColorResource.light_white,
                      thickness: 5,
                    ),
                    Container(
                      height: 150,
                      padding: EdgeInsets.only(
                          top: 20, right: 20, left: 20, bottom: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Additional Details",
                              style: headingStyle18SBblack(),
                            ),
                            SizedBox(height: 30),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Delivery Details",
                                    style: headingStyle14Grey(),
                                  ),
                                  SizedBox(
                                    width: 60,
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 40,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Home Delivery Available",
                                              style: headingStyle14MBBlack(),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(
                                            "Stripe",
                                            style: headingStyle14MBBlack(),
                                            maxLines: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]),
                    ),
                    Divider(
                      color: ColorResource.light_white,
                      thickness: 5,
                    ),
                  ],
                ))),
              );
            }
          }),
    );
  }

  calculatePercentage(String mrpAmount, String finalAmount) {
    double mrp = double.parse(mrpAmount);
    double dis = double.parse(finalAmount);
    double diffAmount = mrp - dis;
    return ((diffAmount / mrp) * 100).toStringAsFixed(2);
  }

  void addProductToCart() async {
    setState(() {
      addToCartLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    // String? cartToken = prefs.getString("cart_token");
    // if (cartToken == null) {
    //   await cartController.addToCart(CartDetails(
    //     productId: widget.productDetails.id!,
    //     productDiscountPrice: widget.productDetails.productMrpPrice.toString(),
    //     quantity: widget.productDetails.productQuantity!,
    //     latitude: "234",
    //     longitude: "234",
    //   ));
    //   widget.productDetails.productQuantity =
    //       widget.productDetails.productQuantity! + 1;
    // } else {
    await cartController
        .updateCart(
            CartDetails(
              productId: controller.productDetailsModel!.data.id,
              productDiscountPrice: controller
                  .productDetailsModel!.data.productDiscountPrice
                  .toString(),
              quantity:
                  controller.productDetailsModel!.data.productMeasurement ==
                          "pcs"
                      ? 1
                      : 0.5,
              latitude: "234",
              longitude: "234",
            ),
            "1",false)
        .then((value) {
      if (value) {
        Get.snackbar(
            'Success',
            controller.productDetailsModel!.data.productMeasurement == "pcs"
                ? '1 pcs Added Successfully'
                : '0.5 Kg Added Successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
            margin: const EdgeInsets.all(10),
            duration: const Duration(seconds: 2));
        // controller.productDetailsModel!.data.productQuantity =
        //     controller.productDetailsModel!.data.productQuantity! + 1;
      }
    });
    // }
    setState(() {
      addToCartLoading = false;
    });
  }
}
