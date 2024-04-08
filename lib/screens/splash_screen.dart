import "package:flutter/material.dart";
import 'package:fruits/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/icons/splash_screen.png",
                  ),
                  fit: BoxFit.cover))),
    );
  }

  navigate() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OnboardingScreen()));
    });
  }
}
