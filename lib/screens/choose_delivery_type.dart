import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:fruits/controllers/cart_controller.dart';
import 'package:fruits/screens/payment_option.dart';
import 'package:fruits/utility/colors.dart';
import 'package:fruits/utility/text_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import "package:google_maps_flutter/google_maps_flutter.dart";
import '../models/delivery_details_model.dart' as deliveryModel;
import 'package:fruits/models/pickup_time_model.dart' as pickupTime;
import 'package:fruits/models/delivery_time_model.dart' as deliveryTime;

import '../widget.dart/autocomplete_places.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:fruits/controllers/cart_controller.dart';
import 'package:uuid/uuid.dart';
import 'package:google_maps_webservice/places.dart';
import "package:get/get.dart";
import 'package:google_api_headers/google_api_headers.dart';

const kGoogleApiKey = 'AIzaSyAhqekr5HJJ1CF2u5-7ard9R3E4CdH8eA8';

class ChooseDeliveryType extends StatefulWidget {
  ChooseDeliveryType({Key? key}) : super(key: key);

  @override
  State<ChooseDeliveryType> createState() => _ChooseDeliveryTypeState();
}

class _ChooseDeliveryTypeState extends State<ChooseDeliveryType> {
  String dropdownValue = 'Select Pincode';
  String dropdownPickupDate = 'Select Pickup Date';
  String dropdownPickupTime = 'Select Pickup Time';
  String dropdownDeliveryDate = 'Select Delivery Date';
  String dropdownDeliveryTime = 'Select Delivery Time';

  bool isDeliveryChecked = false;
  bool isPickupChecked = false;
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  final controller = Get.put(CartController());
  var dobMaskFormatter = new MaskTextInputFormatter(
      mask: '##-##-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  double latitude = 22.7196, longitude = 75.8577;
  // GoogleMapController? _controller;

  CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(22.7196, 75.8577),
    zoom: 14.4746,
  );
  int selectedPickupDateIndex = -1;
  int selectedDeliveryDateIndex = -1;

  @override
  void initState() {
    // TODO: implement initState
    controller.getDeliveryDetails();
    controller.getPickupTimeDetails();
    controller.getDeliveryTimeDetails();
    controller.getPickupDetails().then((value) {
      controller.fetchCurrentLocation();
      controller.addMarker();
    });
    if (controller.selectedPickupDate.isNotEmpty) {
      dropdownPickupDate = controller.selectedPickupDate;
    }
    if (controller.selectedPickupTime.isNotEmpty) {
      dropdownPickupTime = controller.selectedPickupTime;
    }
    if (controller.selectedDeliveryDate.isNotEmpty) {
      dropdownDeliveryDate = controller.selectedDeliveryDate;
    }
    if (controller.selectedDeliveryTime.isNotEmpty) {
      dropdownDeliveryTime = controller.selectedDeliveryTime;
    }
    if (controller.deliveryType == "pickup") {
      isPickupChecked = true;
    }
    if (controller.deliveryType == "delivery") {
      isDeliveryChecked = true;
    }
    // _cameraPosition =
    //     CameraPosition(target: LatLng(latitude, longitude), zoom: 10.0);
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
                title: Text("Choose Delivery Type")),
            bottomNavigationBar: Container(
              height: 105,
              color: Colors.white,
              alignment: Alignment.topCenter,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: SizedBox(
                height: 45,
                width: MediaQuery.of(context).size.width * 8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      primary: Color(0xffF11515),
                      shape: StadiumBorder()),
                  child: Text(
                    "Save",
                    style: GoogleFonts.poppins(
                        color: ColorResource.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  onPressed: () {
                    controller.validateDeliveryTypeScreen();
                  },
                ),
              ),
            ),
            body: Container(
                height: double.infinity,
                width: double.infinity,
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.all(30),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                  value: isDeliveryChecked,
                                  onChanged: (v) {
                                    setState(() {
                                      controller.setDeliveryType("delivery");
                                      isPickupChecked = false;
                                      isDeliveryChecked = v!;
                                    });
                                  }),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                height: 130,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Image.asset("assets/icons/delivery.png"),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Delivery",
                                            style: headingStyle14MBBlack(),
                                          ),
                                          Text(
                                            "Select Delivery Area",
                                            style: headingStyle13MBBlack(),
                                          ),
                                          Text(
                                            "According to pincode",
                                            style: headingStyle13MBBlack(),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ]),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                  value: isPickupChecked,
                                  onChanged: (v) {
                                    setState(() {
                                      controller.setDeliveryType("pickup");
                                      isDeliveryChecked = false;
                                      isPickupChecked = v!;
                                    });
                                  }),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                height: 130,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Image.asset("assets/icons/marker.png"),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Pickup",
                                            style: headingStyle14MBBlack(),
                                          ),
                                          Text(
                                            "Pick your  order",
                                            style: headingStyle13MBBlack(),
                                            maxLines: 2,
                                          ),
                                          Text(
                                            "from selected Location",
                                            style: headingStyle13MBBlack(),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                    ]),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        isDeliveryChecked ? delivery() : SizedBox(),
                        isPickupChecked ? pickup() : SizedBox(),
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
                )),
          );
        });
  }

  Widget delivery() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(1.0)),
                // contentPadding: EdgeInsets.all(10),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<deliveryModel.Data>(
                isDense: true,
                hint: Text(dropdownValue),
                icon: const Icon(Icons.arrow_downward),
                elevation: 10,
                isExpanded: true,
                borderRadius: BorderRadius.circular(25),
                style: const TextStyle(color: Color(0xff9B9B9B)),
                onChanged: (deliveryModel.Data? newValue) {
                  setState(() {
                    controller.selectedPincode = newValue!.zipCode;
                    controller.selectedDeliveryPrice = newValue.price;
                    dropdownValue = newValue.zipCode;
                  });
                },
                items: controller.deliveryDetailsModel.data
                    .map<DropdownMenuItem<deliveryModel.Data>>(
                        (deliveryModel.Data value) {
                  return DropdownMenuItem<deliveryModel.Data>(
                    value: value,
                    child: Text(
                      value.zipCode,
                      style: headingStyle16NBLightGrey(),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text("Select Delivery Time & Date *"),
          SizedBox(height: 20),
          Text("Delivery Date *"),
          SizedBox(height: 10),
          InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(1.0)),
                // contentPadding: EdgeInsets.all(10),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<deliveryTime.Data>(
                isDense: true,
                hint: Text(dropdownDeliveryDate),
                icon: const Icon(Icons.arrow_downward),
                elevation: 10,
                isExpanded: true,
                borderRadius: BorderRadius.circular(25),
                style: const TextStyle(color: Color(0xff9B9B9B)),
                onChanged: (deliveryTime.Data? newValue) {
                  setState(() {
                    controller.selectedDeliveryDate = newValue!.date;
                    selectedDeliveryDateIndex =
                        controller.deliveryTimeModel.data.indexOf(newValue);
                    dropdownDeliveryDate = newValue.date;
                  });
                },
                items: controller.deliveryTimeModel.data
                    .map<DropdownMenuItem<deliveryTime.Data>>(
                        (deliveryTime.Data value) {
                  return DropdownMenuItem<deliveryTime.Data>(
                    value: value,
                    child: Text(
                      value.date,
                      style: headingStyle16NBLightGrey(),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text("Delivery Time *"),
          SizedBox(height: 10),
          InputDecorator(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(1.0)),
                // contentPadding: EdgeInsets.all(10),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<deliveryTime.Time>(
                isDense: true,
                hint: Text(dropdownDeliveryTime),
                icon: const Icon(Icons.arrow_downward),
                elevation: 10,
                isExpanded: true,
                borderRadius: BorderRadius.circular(25),
                style: const TextStyle(color: Color(0xff9B9B9B)),
                onChanged: (deliveryTime.Time? newValue) {
                  setState(() {
                    controller.selectedDeliveryTime = newValue!.time;
                    dropdownDeliveryTime = newValue.time;
                  });
                },
                items: selectedDeliveryDateIndex == -1
                    ? []
                    : controller
                        .deliveryTimeModel.data[selectedDeliveryDateIndex].time
                        .map<DropdownMenuItem<deliveryTime.Time>>(
                            (deliveryTime.Time value) {
                        return DropdownMenuItem<deliveryTime.Time>(
                          value: value,
                          child: Text(
                            value.time,
                            style: headingStyle16NBLightGrey(),
                          ),
                        );
                      }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget pickup() {
    return Container(
      child: Column(
        children: [
          Text("Select Pickup Location"),
          SizedBox(height: 10),
          Container(
            height: 300,
            child: Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  mapToolbarEnabled: true,
                  zoomControlsEnabled: false,
                  initialCameraPosition: controller.cameraPosition,
                  onMapCreated: (GoogleMapController control) {
                    controller.googleMapController = (control);
                    controller.googleMapController!.animateCamera(
                        CameraUpdate.newCameraPosition(
                            controller.cameraPosition));
                  },
                  onCameraIdle: () {
                    setState(() {});
                  },
                  markers: Set<Marker>.of(controller.markers),
                  gestureRecognizers: Set()
                    ..add(Factory<PanGestureRecognizer>(
                        () => PanGestureRecognizer())),
                ),
                Container(
                    height: 48,
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 10),
                    child: TextField(
                      readOnly: true,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(), hintText: "Search"),
                      onTap: () {
                        _handlePressButton();
                      },
                    )),
                Positioned(
                    bottom: 5,
                    right: 15,
                    child: GestureDetector(
                      onTap: () {
                        controller.fetchCurrentLocation();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: ColorResource.white_smoke,
                            borderRadius: BorderRadius.circular(25)),
                        height: 40,
                        width: 40,
                        child: Icon(Icons.my_location),
                      ),
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Pickup Date *"),
                SizedBox(height: 10),
                InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(1.0)),
                      // contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<pickupTime.Data>(
                      isDense: true,
                      hint: Text(dropdownPickupDate),
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 10,
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(25),
                      style: const TextStyle(color: Color(0xff9B9B9B)),
                      onChanged: (pickupTime.Data? newValue) {
                        setState(() {
                          controller.selectedPickupDate = newValue!.date;
                          selectedPickupDateIndex =
                              controller.pickupTimeModel.data.indexOf(newValue);
                          dropdownPickupDate = newValue.date;
                        });
                      },
                      items: controller.pickupTimeModel.data
                          .map<DropdownMenuItem<pickupTime.Data>>(
                              (pickupTime.Data value) {
                        return DropdownMenuItem<pickupTime.Data>(
                          value: value,
                          child: Text(
                            value.date,
                            style: headingStyle16NBLightGrey(),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text("Pick Time *"),
                SizedBox(height: 10),
                InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(1.0)),
                      // contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<pickupTime.Time>(
                      isDense: true,
                      hint: Text(dropdownPickupTime),
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 10,
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(25),
                      style: const TextStyle(color: Color(0xff9B9B9B)),
                      onChanged: (pickupTime.Time? newValue) {
                        setState(() {
                          controller.selectedPickupTime = newValue!.time;
                          dropdownPickupTime = newValue.time;
                        });
                      },
                      items: selectedPickupDateIndex == -1
                          ? []
                          : controller.pickupTimeModel
                              .data[selectedPickupDateIndex].time
                              .map<DropdownMenuItem<pickupTime.Time>>(
                                  (pickupTime.Time value) {
                              return DropdownMenuItem<pickupTime.Time>(
                                value: value,
                                child: Text(
                                  value.time,
                                  style: headingStyle16NBLightGrey(),
                                ),
                              );
                            }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _handlePressButton() async {
    void onError(PlacesAutocompleteResponse response) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.errorMessage ?? 'Unknown error'),
        ),
      );
    }

    final p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: Mode.overlay,
      language: 'it',
      // components: [Component(Component.country, 'it')],
    );

    await displayPrediction(p, ScaffoldMessenger.of(context));
  }

  Future<void> displayPrediction(
      Prediction? p, ScaffoldMessengerState messengerState) async {
    if (p == null) {
      return;
    }
    final _places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    final detail = await _places.getDetailsByPlaceId(p.placeId!);
    final geometry = detail.result.geometry!;
    final lat = geometry.location.lat;
    final lng = geometry.location.lng;
    setState(() {
      controller.updateCameraPosition(detail.result.geometry!.location.lat,
          detail.result.geometry!.location.lng);
    });
  }
}
