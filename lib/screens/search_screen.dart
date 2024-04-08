import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:fruits/controllers/search_controller.dart';
import 'package:fruits/screens/product_detail.dart';
import 'package:fruits/utility/text_style.dart';

import '../utility/colors.dart';
import 'package:get/get.dart';

import 'drawer/cart.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final controller = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        centerTitle: false,
        title: boxHeader(),
        backgroundColor: Color(0xffff5340),
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<SearchController>(
          init: controller,
          builder: (con) {
            if (controller.isLoading == false) {
              return controller.productModel != null &&
                      controller.productModel!.data!.length != 0
                  ? Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: SafeArea(
                        child: SingleChildScrollView(
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:
                                      controller.productModel!.data!.length,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisExtent: 250),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                        onTap: () {
                                          Get.to(ProductDetail(controller
                                              .productModel!.data![index].id!));
                                        },
                                        child: searchResultCard(index));
                                  }),
                            ),
                          ]),
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        "No Results Found!",
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
  }

  Widget boxHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Drawer(),
        GestureDetector(
          onTap: () {
            Get.back();
            // _key.currentState!.openDrawer();
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        SizedBox(width: 15),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(child: Text("Browse", style: headingStyle20MBWhite())),
              SizedBox(height: 20),
              SizedBox(child: _searchBox())
            ],
          ),
        ),
        SizedBox(
          width: 15,
        ),
        GestureDetector(
            onTap: () {
              Get.to(CartScreen());
            },
            child: Image.asset("assets/icons/cart.png"))
      ],
    );
  }

  Widget _searchBox() {
    return Container(
      height: 45,
      // width: 280,
      // width: double.infinity,
      child: TextFormField(
        onChanged: (v) {
          EasyDebounce.debounce(
              'search', // <-- An ID for this particular debouncer
              Duration(milliseconds: 500), // <-- The debounce duration
              () => controller.searchProduct(v) // <-- The target method
              );
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0.0),
          hintText: "Search Product",
          fillColor: Colors.white,
          filled: true,
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xffF11515),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorResource.white, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(25))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorResource.white, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(25))),
        ),
      ),
    );
  }

  Widget searchResultCard(int index) {
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
                            controller.productModel!.data![index].productImage!,
                        placeholder: "assets/icons/apple.png",
                        height: 143,
                        width: double.infinity,
                        fit: BoxFit.cover
                        // "assets/icons/apple.png",
                        ),
                    Positioned(
                      top: 5,
                      left: 5,
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(25)),
                        child: Center(
                            child: Text(
                                "${calculatePercentage(controller.productModel!.data![index].productMrpPrice!, controller.productModel!.data![index].productDiscountPrice!)}%",
                                style: TextStyle(color: Colors.white))),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      controller.productModel!.data![index].name!,
                      style: headingStyle14MB(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      Text(
                        "€ ${(controller.productModel!.data![index].productDiscountPrice)} /  ${controller.productModel!.data![index].productMeasurement}",
                        style: headingStyle14MBRed(),
                      ),
                      SizedBox(width: 1),
                      Expanded(
                        child: Text(
                          "€ ${controller.productModel!.data![index].productMrpPrice}/ ${controller.productModel!.data![index].productMeasurement}  ",
                          style: GoogleFonts.poppins(
                              color: Color(0xff9B9B9B),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.lineThrough),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
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
