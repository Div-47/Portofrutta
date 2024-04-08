import "package:flutter/material.dart";
import 'package:fruits/controllers/auth_controller.dart';
import 'package:fruits/screens/home.dart';
import 'package:fruits/screens/sign_up.dart';
import 'package:fruits/utility/close_keyboard.dart';
import 'package:fruits/utility/colors.dart';
import 'package:fruits/utility/text_style.dart';
import 'package:fruits/widget.dart/text_field_styles.dart';
import "package:google_fonts/google_fonts.dart";
import "package:get/get.dart";
import 'package:fruits/utility/validation.dart';

import 'forgot_password.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authController = Get.put(AuthController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Color(0xffE77A7A),
            Color(0xffE95757),
          ])),
      child: SafeArea(
          child: Center(
        child: SingleChildScrollView(
            child: Form(
          key: formKey,
          child: GetBuilder<AuthController>(
              init: authController,
              builder: (c) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/icons/app_logo.png"),
                      Text("Welcome to PORTOFRUTTA",
                          style: headingStyle24MBWhite()),
                      SizedBox(height: 50),
                      Text("Login to your account",
                          style: headingStyle16MBWhite()),
                      SizedBox(height: 20),
                      whiteTextField("Email", emailController,
                          TextInputType.emailAddress, false, "", (v) {
                        // ignore: empty_statements
                        if (isValidEmail(v!)) {
                          return null;
                        } else {
                          return "Please Enter Valid Email";
                        }
                      }),
                      SizedBox(height: 10),
                      whiteTextField("Password", passwordController,
                          TextInputType.emailAddress, false, "", (v) {
                        if (v!.isEmpty) {
                          return "Please Enter the Password";
                        } else {
                          return null;
                        }
                      }, isPassword: true),
                      SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 8,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(10),
                                primary: ColorResource.white,
                                shape: StadiumBorder()),
                            child: authController.isLoading
                                ? CircularProgressIndicator()
                                : Text(
                                    "Login",
                                    style: GoogleFonts.poppins(
                                        color: Color(0xffF11515),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                            onPressed: () {
                              // hideKeyboard(context);
                              if (formKey.currentState!.validate()) {
                                authController
                                    .userLogin(
                                        emailController.text.toLowerCase(),
                                        passwordController.text)
                                    .then((value) {
                                  print(value);
                                  if (value) {
                                    Get.snackbar("Success 200",
                                        "Signed In Successfully");
                                    Get.to(Home());
                                  } else {
                                    Get.snackbar("Error 404",
                                        "Invalid Username or Password");
                                  }
                                });
                              }

                              //
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      GestureDetector(
                        onTap: () {
                          Get.to(ForgotPasswordScreen());
                        },
                        child: Text("Forgot your password?",
                            style: headingStyle16MBWhite()),
                      ),
                      // SizedBox(height: 10),
                      GestureDetector(
                          onTap: () {
                            Get.offAll(Home());
                          },
                          child: Text("Skip Login!",
                              style: headingStyle16MBWhite())),
                      // SizedBox(height: 10),
                      SizedBox(height: 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Dont have an Account?",
                              style: headingStyle16MBWhite()),
                          GestureDetector(
                              onTap: () {
                                Get.to(SignUpScreen());
                              },
                              child: Text("Sign Up",
                                  style: headingStyle18SBWhite())),
                        ],
                      )
                    ]);
              }),
        )),
      )),
    ));
  }
}
