import "package:flutter/material.dart";
import 'package:fruits/controllers/cart_controller.dart';
import 'package:fruits/screens/user_addresses.dart';
import 'package:fruits/utility/text_style.dart';

import 'package:get/get.dart';

import '../models/user_address_model.dart';
import '../services/app_services.dart';
import 'add_new_address.dart';
import 'add_payment_method.dart';
import 'order_success.dart';

class UserAddress extends StatefulWidget {
  UserAddress({Key? key}) : super(key: key);

  @override
  State<UserAddress> createState() => _UserAddressState();
}

class _UserAddressState extends State<UserAddress> {
  int groupValue = -1;

  final controller = Get.put(CartController());
  @override
  void initState() {
    // TODO: implement initState
    controller.getUserAddresses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        init: controller,
        builder: (con) {
          return Scaffold(
              appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Color(0xffff5340),
                  title: Text("My Addresses")),
              body: controller.isAddressLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(children: [
                          Container(
                            height: 55,
                            padding: EdgeInsets.only(
                                top: 20, right: 20, left: 20, bottom: 10),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Get.to(AddNewAddress());
                                      },
                                      child: Text(
                                        "+ Add New Address",
                                        style: headingStyle16MBAppColor(),
                                      ))
                                ]),
                          ),
                          ListView.builder(
                              itemCount:
                                  controller.userAddressModel.data.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return addressWidget(
                                    controller.userAddressModel.data[index],
                                    index);
                              })
                        ]),
                      ),
                    ));
        });
  }

  Widget addressWidget(Data model, int index) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            controller.setAddressIndex(index);
            Navigator.pop(context);
            Get.snackbar('Success', 'Address Selected Successfully',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
                margin: const EdgeInsets.all(10),
                duration: const Duration(seconds: 2));
          },
          child: Container(
            padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image.asset("assets/icons/home.png"),
                        controller.selectedAddressIndex == index
                            ? Positioned(
                                bottom: 0,
                                right: 0,
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.blue,
                                ))
                            : SizedBox()
                      ],
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            model.name,
                            style: headingStyle14MB(),
                          ),
                          Text(
                            model.flatOrHouseNumber +
                                "," +
                                model.streetName +
                                "," +
                                model.fiscalCode,
                            style: headingStyle14MB(),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            model.city +
                                " " +
                                model.zipcode +
                                " " +
                                model.country,
                            style: headingStyle14MB(),
                          )
                        ],
                      ),
                    ),
                    // Icon(Icons.more_vert)
                  ],
                )
              ],
            ),
          ),
        ),
        Divider(
          height: 0,
          thickness: 2,
        )
      ],
    );
  }
}
