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

import '../controllers/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController cnfpasswordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final controller = Get.put(ForgotPasswordController());
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
          child: GetBuilder<ForgotPasswordController>(
              init: controller,
              builder: (c) {
                return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image.asset("assets/icons/app_logo.png"),
                      Text("Forgot Password", style: headingStyle24MBWhite()),
                      SizedBox(height: 50),

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
                      SizedBox(height: 10),
                      whiteTextField("Confirm Password", cnfpasswordController,
                          TextInputType.emailAddress, false, "", (v) {
                        if (v! != passwordController.text) {
                          return "Password Not Matched";
                        } else {
                          return null;
                        }
                      }, isPassword: false),
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
                            child: controller.isLoading
                                ? CircularProgressIndicator()
                                : Text(
                                    "Change Password",
                                    style: GoogleFonts.poppins(
                                        color: Color(0xffF11515),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                            onPressed: () {
                              // hideKeyboard(context);
                              if (formKey.currentState!.validate()) {
                                controller.forgotPassword(emailController.text,
                                    passwordController.text);
                              }
                            },
                          ),
                        ),
                      ),
                    ]);
              }),
        )),
      )),
    ));
  }
}
