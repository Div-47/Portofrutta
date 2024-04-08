import "package:flutter/material.dart";
import 'package:fruits/controllers/cart_controller.dart';
import 'package:fruits/services/app_services.dart';
import 'package:fruits/utility/colors.dart';
import 'package:fruits/utility/text_style.dart';
import 'package:fruits/widget.dart/text_field_styles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:fruits/models/user_address_model.dart' as address;

import '../models/province_model.dart';
import '../utility/logout.dart';

class AddNewAddress extends StatefulWidget {
  AddNewAddress({Key? key}) : super(key: key);

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  bool saving = false;
  String dropdownValue = 'Select Province';
  bool isDeliveryChecked = false;
  bool isPickupChecked = false;
  int provinceId = 1;
  address.Data? userAddressData;

  GlobalKey<FormState> key = GlobalKey();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final flatNoController = TextEditingController();
  final streetNameController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final countryController = TextEditingController();

  final zipcodeController = TextEditingController();
  final controller = Get.put(CartController());
  @override
  void initState() {
    // TODO: implement initState
    controller.getProvince();
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
                title: Text("Add new address")),
            bottomNavigationBar: Container(
              height: 105,
              color: Colors.transparent,
              alignment: Alignment.topCenter,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: SizedBox(
                // height: 45,
                width: MediaQuery.of(context).size.width * 8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      primary: Color(0xffF11515),
                      shape: StadiumBorder()),
                  child: saving
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Text(
                          "Save",
                          style: GoogleFonts.poppins(
                              color: ColorResource.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                  onPressed: () {
                    save();
                  },
                ),
              ),
            ),
            body: Container(
                height: double.infinity,
                width: double.infinity,
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Form(
                      key: key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          controller.isCurrentLocationLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.gps_fixed,
                                        color: Color(0xff4EA0FF),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller
                                              .getLocation()
                                              .then((value) {
                                            setState(() {
                                              nameController.text = value.name!;
                                              streetNameController.text =
                                                  value.street!;
                                              cityController.text =
                                                  value.locality!;
                                              zipcodeController.text =
                                                  value.postalCode!;
                                            });
                                          });
                                        },
                                        child: Text(
                                          "Use current location",
                                          style: headingStyle16MBBlue(),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(30),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name",
                                    style: headingStyle16NBLightGrey(),
                                  ),
                                  greyUnderlineTextField(
                                      nameController, TextInputType.name, false,
                                      (v) {
                                    if (v!.isEmpty) {
                                      return "Enter Name";
                                    } else {
                                      return null;
                                    }
                                  }),
                                  SizedBox(height: 10),
                                  Text(
                                    "Phone",
                                    style: headingStyle16NBLightGrey(),
                                  ),
                                  greyUnderlineTextField(phoneController,
                                      TextInputType.number, false, (v) {
                                    if (v!.isEmpty) {
                                      return "Enter Phone Number";
                                    } else {
                                      return null;
                                    }
                                  }),
                                  SizedBox(height: 10),
                                  Text(
                                    "Email",
                                    style: headingStyle16NBLightGrey(),
                                  ),
                                  greyUnderlineTextField(emailController,
                                      TextInputType.name, false, (v) {
                                    if (v!.isEmpty) {
                                      return "Enter Email Adress";
                                    } else
                                      return null;
                                  }),
                                  SizedBox(height: 10),
                                  Text(
                                    "Flat Number",
                                    style: headingStyle16NBLightGrey(),
                                  ),
                                  greyUnderlineTextField(flatNoController,
                                      TextInputType.number, false, (v) {
                                    if (v!.isEmpty) {
                                      return "Enter Flat Number";
                                    } else
                                      return null;
                                  }),
                                  SizedBox(height: 10),
                                  Text(
                                    "Street Name",
                                    style: headingStyle16NBLightGrey(),
                                  ),
                                  greyUnderlineTextField(streetNameController,
                                      TextInputType.name, false, (v) {
                                    if (v!.isEmpty) {
                                      return "Enter Street Name";
                                    } else
                                      return null;
                                  }),
                                  SizedBox(height: 10),
                                  Text(
                                    "City",
                                    style: headingStyle16NBLightGrey(),
                                  ),
                                  greyUnderlineTextField(
                                      cityController, TextInputType.name, false,
                                      (v) {
                                    if (v!.isEmpty) {
                                      return "Enter City";
                                    } else
                                      return null;
                                  }),
                                  SizedBox(height: 10),
                                  Text(
                                    "State",
                                    style: headingStyle16NBLightGrey(),
                                  ),
                                  greyUnderlineTextField(stateController,
                                      TextInputType.name, false, (v) {
                                    if (v!.isEmpty) {
                                      return "Enter State Name";
                                    } else
                                      return null;
                                  }),
                                  SizedBox(height: 10),
                                  Text(
                                    "Country",
                                    style: headingStyle16NBLightGrey(),
                                  ),
                                  greyUnderlineTextField(countryController,
                                      TextInputType.name, false, (v) {
                                    if (v!.isEmpty) {
                                      return "Enter Country Name";
                                    } else
                                      return null;
                                  }),
                                  SizedBox(height: 10),
                                  Text(
                                    "Zip Code",
                                    style: headingStyle16NBLightGrey(),
                                  ),
                                  greyUnderlineTextField(zipcodeController,
                                      TextInputType.number, false, (v) {
                                    if (v!.isEmpty) {
                                      return "Enter Zip Code";
                                    } else
                                      return null;
                                  }),
                                  SizedBox(height: 10),
                                  Text(
                                    "Province",
                                    style: headingStyle16NBLightGrey(),
                                  ),
                                  SizedBox(height: 10),
                                  InputDecorator(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(1.0)),
                                        // contentPadding: EdgeInsets.all(10),
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<Data>(
                                        isDense: true,
                                        hint: Text(dropdownValue),
                                        icon: const Icon(Icons.arrow_downward),
                                        elevation: 10,
                                        isExpanded: true,
                                        borderRadius: BorderRadius.circular(25),
                                        style: const TextStyle(
                                            color: Color(0xff9B9B9B)),
                                        onChanged: (Data? newValue) {
                                          setState(() {
                                            provinceId = newValue!.id;

                                            dropdownValue = newValue.name;
                                          });
                                        },
                                        items: controller.provinceModel.data
                                            .map<DropdownMenuItem<Data>>(
                                                (Data value) {
                                          return DropdownMenuItem<Data>(
                                            value: value,
                                            child: Text(
                                              value.name,
                                              style:
                                                  headingStyle16NBLightGrey(),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                               
                                ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 30, top: 20),
                            child: Text("Order Notes (Optional)"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30, right: 30, top: 20),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              height: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black,
                                      // offset: const Offset(
                                      //   5.0,
                                      //   5.0,
                                      // ),

                                      blurRadius: 22.0,
                                      spreadRadius: 2.0,
                                    ),
                                  ],
                                  border: Border.all(color: Colors.black26)),
                              child: TextField(
                                maxLines: 10,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                )),
          );
        });
  }

  Future save() async {
    try {
      if (key.currentState!.validate()) {
        setState(() {
          saving = true;
        });

        userAddressData = address.Data(
          name: nameController.text,
          phone: phoneController.text,
          city: cityController.text,
          email: emailController.text,
          flatOrHouseNumber: flatNoController.text,
          streetName: streetNameController.text,
          fiscalCode: "",
          state: stateController.text,
          country: countryController.text,
          zipcode: zipcodeController.text,
          id: 0,
          provinceName: dropdownValue,
          provinceId: provinceId.toString(),
        );
        var response = await AppService().postAddressApi(userAddressData!);
        var res = await response.stream.bytesToString();
        print(res);
        if (response.statusCode == 200) {
          Get.snackbar("Success 200", "Address Save Successfully");
          await controller.getUserAddresses();
          Navigator.pop(context);
          setState(() {
            saving = false;
          });
        } else if (response.statusCode == 401) {
          logout();
          Get.snackbar("401 Unauthorized", "Authorization Failed");
        } else {
          setState(() {
            saving = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        saving = false;
      });
    }
    setState(() {
      saving = false;
    });
  }
}
