import 'package:flutter/material.dart';
import 'package:fruits/screens/login.dart';
import "package:google_fonts/google_fonts.dart";
import "package:get/get.dart" ;

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:20.0,vertical:10),
            child: ElevatedButton(

              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(10),
                primary: Color(0xffF11515),
                shape: StadiumBorder(

                )),
        child: Text(
            "Next",
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        onPressed: () {
          Get.to(LoginScreen());
        },
      ),
          )),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          // alignment: Alignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              color: Color(0xffE95757),
            ),
            Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/icons/onboarding.png"),
                Text(
                  "Empowering Artisans,\nFarmers & Micro Business",
                  style: GoogleFonts.poppins(
                      color: Color(0xffF11515),
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
