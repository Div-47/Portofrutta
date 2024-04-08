import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:fruits/controllers/cart_controller.dart';
import 'package:uuid/uuid.dart';
import 'package:google_maps_webservice/places.dart';
import "package:get/get.dart";
import 'package:google_api_headers/google_api_headers.dart';

const kGoogleApiKey = 'AIzaSyAhqekr5HJJ1CF2u5-7ard9R3E4CdH8eA8';

class CustomSearchScaffold extends PlacesAutocompleteWidget {
  CustomSearchScaffold({Key? key})
      : super(
          key: key,
          apiKey: kGoogleApiKey,
          sessionToken: const Uuid().v4(),
          language: 'en',
          components: [Component(Component.country, 'ind')],
        );

  @override
  _CustomSearchScaffoldState createState() => _CustomSearchScaffoldState();
}

class _CustomSearchScaffoldState extends PlacesAutocompleteState {
  GlobalKey key1 = GlobalKey();
  final controller = Get.put(CartController());
  bool hide = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField()
          // const AppBarPlacesAutoCompleteTextField(
          //   // key: key1,
          //   textStyle: null,
          //   textDecoration: null,
          //   cursorColor: null,
          // ),
          // Expanded(
          //   child: Container(
          //     height: 20,
          //     color: Colors.white,
          //     child: PlacesAutocompleteResult(
          //       // key: key1,
          //       onTap: (p) async {
          //         final _places = GoogleMapsPlaces(
          //           apiKey: kGoogleApiKey,
          //           apiHeaders: await const GoogleApiHeaders().getHeaders(),
          //         );

          //         final detail = await _places.getDetailsByPlaceId(p.placeId!);
          //         setState(() {
          //           controller.updateCameraPosition(
          //               detail.result.geometry!.location.lat,
          //               detail.result.geometry!.location.lng);
          //           // super.dispose();
          //         });
          //       },

          //       // displayPrediction(p, ScaffoldMessenger.of(context)),
          //       logo: SizedBox(),
          //     ),
          //   ),
          // ),
      
        ],
      ),
    );
  }
 
}
