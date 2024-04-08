import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import "package:flutter/material.dart";
import 'package:fruits/screens/feedback_screen.dart';
import 'package:fruits/screens/home.dart';
import 'package:fruits/utility/colors.dart';
import 'package:fruits/utility/text_style.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:get/get.dart';

import 'add_payment_method.dart';

class OrderSuccess extends StatefulWidget {
  final succesResponse;
  OrderSuccess(this.succesResponse, {Key? key}) : super(key: key);

  @override
  State<OrderSuccess> createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  List<Step> stepList() => [
        const Step(
            isActive: true,
            subtitle: Text('Order#123455 from Fashion Point'),
            title: Text('Order Placed'),
            content: Text('')),
        const Step(
            isActive: true,
            title: Text('Payment Confirmed'),
            subtitle: Text('Payment Confirmed Status'),
            content: Center(
              child: Text('Address'),
            )),
        const Step(
            title: Text('Processed'),
            subtitle: Text('Processed Status'),
            content: Center(
              child: Text('Confirm'),
            )),
        const Step(
            title: Text('Delivered'),
            subtitle: Text('Order#123455 from Fashion Point'),
            content: Center(
              child: Text('Delivered Status'),
            ))
      ];

  @override
  var json;
  void initState() {
    json = jsonDecode(widget.succesResponse);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ColorResource.appColor,
          title: Text("Payment Option"),
          leading: IconButton(
            icon: Icon(Icons.close, color: Colors.black),
            onPressed: () {
              Get.offAll(Home());
            },
          ),
        ),
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
                  primary: Colors.white,
                  shape: StadiumBorder()),
              child: Text(
                "FeedBack",
                style: GoogleFonts.poppins(
                    color: ColorResource.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              onPressed: () {
                Get.to(FeedbackScreen());
              },
            ),
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                child: Image.asset("assets/icons/Done.png"),
              ),
              Text(
                "Thanks for Order",
                style: headingStyle24MBGrey(),
              ),
              SizedBox(height: 10),
              // Container(
              //   padding: EdgeInsets.all(20),
              //   child: Column(children: [
              //     Row(
              //       children: [
              //         Image.asset("assets/icons/garlic.png"),
              //         SizedBox(width: 20),
              //         Column(
              //             mainAxisAlignment: MainAxisAlignment.start,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text("Pink Garlic"),
              //               SizedBox(height: 5),
              //               Text("€ 5.00/ kg", style: headingStyle14MBRed()),
              //               SizedBox(height: 5),
              //               Text("Qty : 1")
              //             ])
              //       ],
              //     )
              //   ]),
              // ),
              // Divider(
              //   color: ColorResource.light_white,
              //   thickness: 2,
              // ),
              // Text("Remove"),
              // SizedBox(height: 10),
              // Divider(
              //   color: ColorResource.light_white,
              //   thickness: 2,
              // ),
              SizedBox(height: 30),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Track Order", style: headingStyle18SBblack()),
                    // Text("Order ID - ${json["order_details"]['id']}"),
                    SizedBox(height: 20),
                    Stepper(
                      controlsBuilder: (
                        s,
                        t,
                      ) {
                        return Row(
                          children: <Widget>[
                            Container(),
                            Container(),
                          ],
                        );
                      },
                      steps: stepList(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //     json["order_details"]["delivery_type"] ==
                            //             "Delivery"
                            //         ? "Delivery Address"
                            //         : "Pickup Address",
                            //     style: headingStyle18SBblack()),
                            SizedBox(
                              height: 10,
                            ),
                            // Text(
                            //   json["order_details"]["delivery"]['name'],
                            //   style: headingStyle16MBGrey(),
                            // ),
                            SizedBox(
                              height: 5,
                            ),
                            // Text(
                            //     "${json["order_details"]["delivery"]['flat_or_house_number']}, ${json["order_details"]["delivery"]['street_name']},${json["order_details"]["delivery"]['city']}, ${json["order_details"]["delivery"]['zipcode']}"),
                            SizedBox(
                              height: 5,
                            ),
                            // Text(
                            //     "Phone: ${json["order_details"]["delivery"]['phone']}"),
                            SizedBox(
                              height: 5,
                            ),
                          ]),
                    )
                  ],
                ),
              )
            ]),
          ),
        ));
  }
}
