import 'dart:io';

import "package:flutter/material.dart";
import 'package:fruits/controllers/profile_controller.dart';
import 'package:fruits/utility/close_keyboard.dart';
import 'package:fruits/utility/colors.dart';
import 'package:fruits/widget.dart/text_field_styles.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:get/get.dart";
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController cobController = TextEditingController();
  final TextEditingController fiscalController = TextEditingController();
  final TextEditingController aolController = TextEditingController();
  final TextEditingController aosController = TextEditingController();

  final controller = Get.put(ProfileController());
  @override
  void initState() {
    // TODO: implement initState
    controller.fetchProfile().then((value) {
      dobController..text = controller.profileModel!.data!.dob!;
    });

    super.initState();
  }

  var dobMaskFormatter = new MaskTextInputFormatter(
      mask: '####-##-##-',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
        init: controller,
        builder: (con) {
          if (controller.isLoading) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * .76,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(children: [
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    controller.pickImage();
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: controller.profileModel!.data!.filePath !=
                                      null &&
                                  controller
                                      .profileModel!.data!.filePath!.isNotEmpty
                              ? Image.file(
                                  File(
                                      controller.profileModel!.data!.filePath!),
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                )
                              : FadeInImage.assetNetwork(
                                  image: controller
                                      .profileModel!.data!.profilePicture!,
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover,
                                  placeholder: "assets/icons/app_logo.png",
                                )),
                      Positioned(
                          bottom: 2,
                          right: 2,
                          child: Icon(
                            Icons.edit,
                            color: ColorResource.appColor,
                          ))
                    ],
                  ),
                ),
                SizedBox(height: 40),
                greyTextField(
                    "Name",
                    nameController
                      ..text = controller.profileModel != null
                          ? controller.profileModel!.data!.name!
                          : "",
                    TextInputType.name,
                    false,
                    "",
                    (v) {}, onchange: (v) {
                  controller.updateName(v);
                  print(controller.profileModel!.data!.name);
                }),
                SizedBox(height: 10),
                greyTextField(
                    "Surname",
                    lastNameController
                      ..text = controller.profileModel != null
                          ? controller.profileModel!.data!.surname!
                          : "",
                    TextInputType.name,
                    false,
                    "",
                    (v) {}, onchange: (v) {
                  controller.updateLastName(v);
                }),
                SizedBox(height: 10),
                greyTextField(
                    "Phone Number",
                    phoneController
                      ..text = controller.profileModel != null
                          ? controller.profileModel!.data!.phone!
                          : "",
                    TextInputType.number,
                    false,
                    "",
                    (v) {}, onchange: (v) {
                  controller.updatePhone(v);
                }),
                SizedBox(height: 10),
                greyTextField(
                    "Email Address",
                    emailController
                      ..text = controller.profileModel != null
                          ? controller.profileModel!.data!.email!
                          : "",
                    TextInputType.name,
                    false,
                    "",
                    (v) {}, onchange: (v) {
                  controller.updateEmail(v);
                }),
                // SizedBox(height: 10),
                // greyTextField("Password", passwordController,
                //     TextInputType.name, false, "", (v) {}),
                SizedBox(height: 10),
                greyTextField(
                    "City Of Birth",
                    cobController
                      ..text = controller.profileModel != null
                          ? controller.profileModel!.data!.cityOfBirth!
                          : "",
                    TextInputType.name,
                    false,
                    "",
                    (v) {}, onchange: (v) {
                  controller.updateCob(v);
                }),
                SizedBox(height: 10),
                greyTextField("Date Of Birth (YYYY-MM-DD)", dobController,
                    TextInputType.number, true, "", (v) {
                  if (v!.isEmpty) {
                    return 'Please enter date of birth';
                  } else {
                    return null;
                  }
                }, onchange: (v) {
                  // controller.updateDob(v);
                }, onTap: () {
                  pickDate();
                }),
                SizedBox(height: 10),
                greyTextField(
                    "Address Of Living",
                    aosController
                      ..text = controller.profileModel != null
                          ? controller.profileModel!.data!.addressOfLiving!
                          : "",
                    TextInputType.name,
                    false,
                    "",
                    (v) {}, onchange: (v) {
                  controller.updateAol(v);
                }),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 8,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10),
                          primary: ColorResource.white,
                          shape: StadiumBorder()),
                      child: controller.profileUpdateLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              "Update",
                              style: GoogleFonts.poppins(
                                  color: Color(0xffF11515),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                      onPressed: () {
                        print("sdfasdfasdf");
                        controller.updateProfile();
                      },
                    ),
                  ),
                ),
              ]),
            );
          }
        });
  }

  Future pickDate() async {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1975),
            lastDate: DateTime(2050))
        .then((value) {
      setState(() {
        String date =
            "${value!.year.toString().padLeft(2, '0')}-${value.month.toString().padLeft(2, '0')}-${value.day.toString()}";
        // signUpModel!.dob = date;
        dobController.text = date;
        controller.updateDob(date);
      });
    });
  }
}
