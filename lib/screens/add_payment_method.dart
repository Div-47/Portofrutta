import 'package:dotted_border/dotted_border.dart';
import "package:flutter/material.dart";
import 'package:fruits/utility/colors.dart';
import 'package:fruits/utility/text_style.dart';
import "package:google_fonts/google_fonts.dart";

class AddPaymentMethod extends StatefulWidget {
  AddPaymentMethod({Key? key}) : super(key: key);

  @override
  State<AddPaymentMethod> createState() => _AddPaymentMethodState();
}

class _AddPaymentMethodState extends State<AddPaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
        backgroundColor: Color(0xffff5340),
            title: Text("Payment Option")),
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
                  primary: Color(0xffF11515),
                  shape: StadiumBorder()),
              child: Text(
                "Add Credit Card",
                style: GoogleFonts.poppins(
                    color: ColorResource.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              onPressed: () {},
            ),
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(children: [
              SizedBox(height: 10),
              Image.asset("assets/icons/mastercard.png"),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Card Number",
                        style: headingStyle16NBLightGrey(),
                      ),
                      TextFormField(),
                      SizedBox(height: 10),
                      Text(
                        "Name",
                        style: headingStyle16NBLightGrey(),
                      ),
                      TextFormField(),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Expires Dates",
                                  style: headingStyle16NBLightGrey(),
                                ),
                                TextFormField(),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "CVV",
                                  style: headingStyle16NBLightGrey(),
                                ),
                                TextFormField(),
                              ],
                            ),
                          )
                        ],
                      )
                    ]),
              )
            ]),
          ),
        ));
  }
}
