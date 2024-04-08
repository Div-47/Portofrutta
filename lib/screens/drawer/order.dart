import "package:flutter/material.dart";
import 'package:fruits/controllers/order_controller.dart';
import 'package:fruits/screens/order_details.dart';
import 'package:fruits/utility/colors.dart';
import 'package:fruits/utility/text_style.dart';
import "package:get/get.dart";

class OrderScreen extends StatefulWidget {
  OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => OrdertScreenState();
}

class OrdertScreenState extends State<OrderScreen> {
  final controller = Get.put(OrderController());

  @override
  void initState() {
    // TODO: implement initState
    controller.fetchUserOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: ColorResource.appColor,
            title: Text("Order")),
        body: GetBuilder<OrderController>(
            init: controller,
            builder: (con) {
              return controller.isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.userOrderModel!.data.length == 0
                      ? Center(
                          child: Text(
                          "No Orders Found!",
                          style: headingStyle16MB(),
                        ))
                      : Container(
                          color: Color(0xffE5E5E5),
                          height: double.infinity,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Container(
                              //     color: Colors.white,
                              //     padding: EdgeInsets.only(left: 20, right: 10),
                              //     child: Column(
                              //       children: [
                              //         Column(children: [
                              //           SizedBox(height: 20),
                              //           Row(
                              //             children: [
                              //               Text(
                              //                 "Transaction",
                              //                 style: headingStyle20SBblack(),
                              //               ),
                              //               SizedBox(width: 20),
                              //               Container(
                              //                   padding: EdgeInsets.only(
                              //                       top: 10, bottom: 10, left: 20, right: 20),
                              //                   decoration: BoxDecoration(
                              //                       borderRadius: BorderRadius.circular(12),
                              //                       color: Color(0xffE6ECF0)),
                              //                   child: Text("7May2022"))
                              //             ],
                              //           ),
                              //           SizedBox(height: 20),
                              //         ])
                              //       ],
                              //     )),
                              // SizedBox(height: 20),
                              Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.userOrderModel!.data.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                          onTap: () {
                                            Get.to(OrderDetails(
                                                controller.userOrderModel!
                                                    .data[index],
                                                controller
                                                            .userOrderModel!
                                                            .data[index]
                                                            .orderStatus ==
                                                        "placed"
                                                    ? 0
                                                    : controller
                                                                .userOrderModel!
                                                                .data[index]
                                                                .orderStatus ==
                                                            "packed"
                                                        ? 1
                                                        : controller
                                                                    .userOrderModel!
                                                                    .data[index]
                                                                    .orderStatus ==
                                                                "on_the_way"
                                                            ? 2
                                                            : controller
                                                                        .userOrderModel!
                                                                        .data[
                                                                            index]
                                                                        .orderStatus ==
                                                                    "delivered"
                                                                ? 3
                                                                : controller
                                                                            .userOrderModel!
                                                                            .data[index]
                                                                            .orderStatus ==
                                                                        "cancelled"
                                                                    ? -1
                                                                    : -2));
                                          },
                                          child: orderCard(index));
                                    }),
                              )
                            ],
                          ));
            }));
  }

  Widget orderCard(int index) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(15),
          child: Column(children: [
            Row(
              children: [
                Image.asset(
                  "assets/icons/app_logo.png",
                  width: 60,
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Order Id: ${controller.userOrderModel!.data[index].id.toString()}"),
                          Row(
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text("Items",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff4F4F4F))),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .35,
                            child: Wrap(children: [
                              for (var orderItems in controller
                                  .userOrderModel!.data[index].orderItems)
                                Text(orderItems.productName)
                            ]),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      orderStatus(
                          controller.userOrderModel!.data[index].orderStatus !=
                                  "cancelled"
                              ? true
                              : false,
                          controller.userOrderModel!.data[index].orderStatus
                              .replaceAll("_", " ")
                              .capitalizeFirst!)
                    ],
                  ),
                ),
              ],
            )
          ]),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  Widget orderStatus(bool status, String orderStatus) {
    return Container(
      // width: 100,
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
      decoration: BoxDecoration(
          color: orderStatus == "Success"
              ? Colors.green[300]
              : orderStatus == "Delivered"
                  ? Colors.green
                  : orderStatus == "Cancelled"
                      ? Colors.red
                      : orderStatus == "On the way"
                          ? Colors.blue
                          : orderStatus == "Pending"
                              ? Colors.yellow
                              : orderStatus == "Placed"
                                  ? Colors.yellow[300]
                                  : Colors.green,
          borderRadius: BorderRadius.circular(35),
          border: Border.all(
              color: orderStatus == "Success"
                  ? Colors.green[300]!
                  : orderStatus == "Delivered"
                      ? Colors.green
                      : orderStatus == "Cancelled"
                          ? Colors.red
                          : orderStatus == "On the way"
                              ? Colors.blue
                              : orderStatus == "Pending"
                                  ? Colors.yellow
                                  : orderStatus == "Placed"
                                      ? Colors.yellow[50]!
                                      : Colors.green)),
      child: Center(
          child: Text(
        orderStatus,
        style: TextStyle(fontSize: 12, color: Colors.white),
      )),
    );
  }
}
