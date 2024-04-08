import 'package:flutter/material.dart';
import 'package:fruits/models/user_order_model.dart';

import '../utility/colors.dart';
import '../utility/text_style.dart';

class OrderDetails extends StatefulWidget {
  final Data model;
  final int currentStep;
  OrderDetails(this.model, this.currentStep);

  @override
  State<OrderDetails> createState({order = OrderDetails}) =>
      _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  List<Step> stepList() => [
        Step(
            isActive: true,
            subtitle: Text('Order#${widget.model.id} '),
            title: Text('Order Placed'),
            content: Text(''),
            state: widget.currentStep >= 0
                ? StepState.complete
                : StepState.indexed),
        Step(
            isActive: true,
            title: Text('Packed'),
            subtitle: Text(''),
            content: Center(
              child: Text(''),
            ),
            state: widget.currentStep >= 1
                ? StepState.complete
                : StepState.indexed),
        Step(
            isActive: true,
            title: Text('On The Way'),
            subtitle: Text('Order#${widget.model.id} '),
            content: Center(
              child: Text(''),
            ),
            state: widget.currentStep >= 2
                ? StepState.complete
                : StepState.indexed),
        Step(
            isActive: true,
            title: Text('Delivered'),
            subtitle: Text('Order#${widget.model.id} '),
            content: Center(
              child: Text(''),
            ),
            state: widget.currentStep >= 3
                ? StepState.complete
                : StepState.indexed)
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: ColorResource.appColor,
            title: Text("Order Details")),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(height: 10),
              Text(
                "Order No",
                style: headingStyle24MBGrey(),
              ),
              Text(
                widget.model.id.toString(),
                style: headingStyle13MBBlack(),
              ),
              SizedBox(height: 10),
              Container(
                  padding: EdgeInsets.all(20),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.model.orderItems.length,
                      itemBuilder: (context, index) {
                        return Column(children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: FadeInImage.assetNetwork(
                                  image: widget
                                      .model.orderItems[index].productImage,
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                  placeholder: "assets/icons/app_logo.png",
                                ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${widget.model.orderItems[index].productName}",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                          "€ ${widget.model.orderItems[index].price}/ ${widget.model.orderItems[index].productMeasurement}",
                                          style: headingStyle14MBRed()),
                                      SizedBox(height: 5),
                                      Text(
                                          "Qty : ${widget.model.orderItems[index].qty}")
                                    ]),
                              )
                            ],
                          ),
                          SizedBox(height: 10)
                        ]);
                      })),
              SizedBox(height: 10),
              Divider(
                color: ColorResource.light_white,
                thickness: 2,
              ),
              SizedBox(height: 30),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.currentStep == -1 
                        ? SizedBox()
                        : Text("Track Order", style: headingStyle18SBblack()),
                    // Text("Order ID - ${json["order_details"]['id']}"),
                    SizedBox(height: 20),
                    widget.currentStep == -1
                        ? Text(
                            "Order Cancelled",
                            style: headingStyle14MBRed(),
                          )
                        : Stepper(
                            currentStep: 1,
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
                            Text("Delivery Address",
                                style: headingStyle18SBblack()),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(),
                            Text(
                              "${widget.model.shippingDetails.name}",
                              style: headingStyle16MBGrey(),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                "${widget.model.shippingDetails.flatOrHouseNumber}, ${widget.model.shippingDetails.streetName},${widget.model.shippingDetails.city}, ${widget.model.shippingDetails.zipcode}"),
                            SizedBox(
                              height: 5,
                            ),
                            Text("${widget.model.shippingDetails.phone}"),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                "${widget.model.shippingDetails.state} ${widget.model.shippingDetails.country}"),
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
