import "package:flutter/material.dart";
import 'package:fruits/controllers/offer_controller.dart';
import 'package:fruits/screens/product_detail.dart';
import 'package:fruits/utility/colors.dart';
import 'package:fruits/utility/text_style.dart';
import 'package:get/get.dart';

class OfferScreen extends StatefulWidget {
  OfferScreen({Key? key}) : super(key: key);

  @override
  State<OfferScreen> createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  final offerController = Get.put(OfferController());

  // int _currentIndex = 0;
  // List<String> products = ["All Products", "Fruits", "Vegetables", "Box"];
  @override
  void initState() {
    // TODO: implement initState
    offerController.fetchOffer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<OfferController>(
          init: offerController,
          builder: (con) {
            if (offerController.isLoading) {
              return Container(
                  height: MediaQuery.of(context).size.height * .78,
                  child: Center(child: CircularProgressIndicator()));
            } else {
              return Column(children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: offerController.offerModel!.data.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, mainAxisExtent: 230),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Get.to(ProductDetail(int.tryParse(offerController
                                  .offerModel!.data[index].productId)!));
                            },
                            child: fruitsCard(index));
                      }),
                )
              ]);
            }
          }),
    );
  }

  Widget fruitsCard(int index) {
    return Container(
      width: double.infinity,
      height: 500,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    FadeInImage.assetNetwork(
                        image:
                            offerController.offerModel!.data[index].sliderImage,
                        placeholder: "assets/icons/app_logo.png",
                        height: 143,
                        width: double.infinity,
                        fit: BoxFit.cover
                        // "assets/icons/apple.png",
                        ),
                    // Positioned(
                    //   top: 5,
                    //   left: 5,
                    //   child: Container(
                    //     height: 50,
                    //     width: 50,
                    //     decoration: BoxDecoration(
                    //         color: Colors.red,
                    //         borderRadius: BorderRadius.circular(25)),
                    //     child: Center(
                    //         child: Text("${calculatePercentage(offerController.productModel!.data![index].productMrpPrice!, offerController.productModel!.data![index].productDiscountPrice!)}%",
                    //             style: TextStyle(color: Colors.white))),
                    //   ),
                    // )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    offerController.offerModel!.data[index].sliderTitle,
                    style: headingStyle14MB(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      // Text(
                      //   "€ ${(offerController.productModel!.data![index].productDiscountPrice)} /  ${offerController.productModel!.data![index].productMeasurement}",
                      //   style: headingStyle14MBRed(),
                      // )
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }

  calculatePercentage(String mrpAmount, String finalAmount) {
    double mrp = double.parse(mrpAmount);
    double dis = double.parse(finalAmount);
    double diffAmount = mrp - dis;
    return ((diffAmount / mrp) * 100).toStringAsFixed(1);
  }
}
