import "package:flutter/material.dart";
import 'package:fruits/controllers/cart_controller.dart';
import 'package:fruits/screens/product_detail.dart';
import 'package:fruits/utility/text_style.dart';
import 'package:get/get.dart';

import '../../controllers/box_controller.dart';
import '../../controllers/list_controller.dart';
import '../../models/cart_model.dart';
import '../../models/product_model.dart';

class HomeScreen extends StatefulWidget {
  final TabController tabController;
  HomeScreen({required this.tabController});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final listController = Get.put(ListController());
  final boxController = Get.put(BoxController());
  final cartController = Get.put(CartController());
  @override
  void initState() {
    // TODO: implement initState
    listController.fetchList();

    boxController.fetchBox();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: TabBarView(
            controller: widget.tabController, children: [listino(), box()]),
      ),
    );
  }

  Widget listino() {
    return GetBuilder<ListController>(
        init: listController,
        builder: (context) {
          if (listController.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
                shrinkWrap: false,
                // physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(10),
                itemCount: listController.productModel!.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Row(children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: GestureDetector(
                              onTap: () {
                                Get.to(ProductDetail(listController
                                    .productModel!.data![index].id!));
                              },
                              child: Image.network(
                                listController
                                    .productModel!.data![index].productImage!,
                                height: 95,
                                width: 95,
                                fit: BoxFit.cover,
                              ))),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(ProductDetail(
                                listController.productModel!.data![index].id!));
                          },
                          child: Text(
                            listController.productModel!.data![index].name! +
                                "\n€${listController.productModel!.data![index].productDiscountPrice!} ${listController.productModel!.data![index].productMeasurement!} ",
                            style: headingStyle14B(),
                          ),
                        ),
                      ),
                      manageCart(index, "List"),
                      SizedBox(width: 10),
                    ]),
                  );
                });
          }
        });
  }

  Widget box() {
    return GetBuilder<BoxController>(
        init: boxController,
        builder: (context) {
          if (boxController.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return GridView.builder(
                itemCount: boxController.productModel!.data!.length,
                padding: EdgeInsets.all(10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(ProductDetail(
                          boxController.productModel!.data![index].id!));
                    },
                    child: Container(
                      child: Column(children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              boxController
                                  .productModel!.data![index].productImage!,
                              height: 95,
                              width: 95,
                              fit: BoxFit.cover,
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          boxController.productModel!.data![index].name!,
                          style: headingStyle14B(),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "€ ${boxController.productModel!.data![index].productMrpPrice!}",
                          style: headingStyle14B(),
                        ),
                        manageCart(index, "Box"),
                        // Text(boxController
                        //     .productModel!.data![index].productMeasurement!)
                      ]),
                    ),
                  );
                });
          }
        });
  }

  Widget manageCart(int index, String type) {
    return Container(
      width: 90,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
      child: IntrinsicHeight(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    type == "List"
                        ? listController.decrementProduct(
                            index,
                          )
                        : boxController.decrementProduct(index);
                  });
                },
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 15,
                ),
              ),
              const VerticalDivider(
                color: Colors.black,
                thickness: 2,
              ),
              // FutureBuilder<String>(
              //     future: checkQuantityWithCart(type == "List"
              //         ? listController.productModel!.data![index]
              //         : boxController.productModel!.data![index]),
              //     builder: (context, snapshot) {
              //       if (snapshot.data != null && snapshot.data != '') {
              //         return Text(snapshot.data!);
              //       } else {
              //         return Text(type == "List"
              //             ? listController
              //                         .productModel!.data![index].productQuantity !=
              //                     null
              //                 ? listController
              //                     .productModel!.data![index].productQuantity
              //                     .toString()
              //                 : "0"
              //             : boxController
              //                         .productModel!.data![index].productQuantity !=
              //                     null
              //                 ? boxController
              //                     .productModel!.data![index].productQuantity
              //                     .toString()
              //                 : "0");
              //       }
              //     }),
              Center(
                child: Container(
                  // height: 16,
                  // width: 18,
                  child: type == "List"
                      ? listController
                              .productModel!.data![index].cartUpdateLoading!
                          ? SizedBox(
                              height: 6,
                              width: 6,
                              child: Center(child: CircularProgressIndicator()))
                          : Center(
                              child: Text(listController.productModel!
                                          .data![index].productQuantity !=
                                      null
                                  ? listController.productModel!.data![index]
                                      .productQuantity
                                      .toString()
                                  : "0"),
                            )
                      : boxController
                              .productModel!.data![index].cartUpdateLoading!
                          ? SizedBox(
                              height: 10,
                              width: 10,
                              child: CircularProgressIndicator())
                          : Text(boxController.productModel!.data![index]
                                      .productQuantity !=
                                  null
                              ? boxController
                                  .productModel!.data![index].productQuantity
                                  .toString()
                              : "0"),
                ),
              ),

              const VerticalDivider(
                color: Color.fromARGB(255, 0, 0, 0),
                thickness: 2,
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      type == "List"
                          ? listController.incrementProduct(
                              index,
                            )
                          : boxController.incrementProduct(index);
                    });
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  )),
            ]),
      ),
    );
  }

  Future<String> checkQuantityWithCart(Data data) async {
    String quantity = '';

    await Future.forEach<CartDetails>(
        cartController.cartModel!.data.cartDetails, (element) {
      if (element.productId == data.id) {
        quantity = element.quantity.toString();
        return;
      }
    });
    return quantity;
  }
}
