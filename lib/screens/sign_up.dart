import "package:flutter/material.dart";
import 'package:fruits/controllers/cart_controller.dart';
import 'package:fruits/controllers/sign_up_controller.dart';
import 'package:fruits/models/sign_up_model.dart';
import 'package:fruits/screens/home.dart';
import 'package:fruits/screens/login.dart';
import 'package:fruits/utility/colors.dart';
import 'package:fruits/utility/text_style.dart';
import 'package:fruits/widget.dart/text_field_styles.dart';
import "package:google_fonts/google_fonts.dart";
import "package:get/get.dart";
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../models/province_model.dart';
import '../utility/validation.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpModel? signUpModel = SignUpModel(
      "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "");
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController cobController = TextEditingController();
  final TextEditingController fiscalController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController aolController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController flatController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController roadController = TextEditingController();
  final TextEditingController aosController = TextEditingController();
  final controller = Get.put(SignUpController());
  GlobalKey<FormState> formKey = GlobalKey();
  var dobMaskFormatter = new MaskTextInputFormatter(
      mask: '##-##-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);
  String dateofBirth = "";
  String dropdownValue = 'Select Province';
  int provinceId = 1;
  final cartController = Get.put(CartController());

  @override
  void initState() {
    // TODO: implement initState
    cartController.getProvince();

    super.initState();
  }

  bool termsAndCondition = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GetBuilder<SignUpController>(
          init: controller,
          builder: (con) {
            return Container(
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
                  child: SingleChildScrollView(
                      child: Form(
                key: formKey,
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      Text("Welcome to PORTOFRUTTA",
                          style: headingStyle24MBWhite()),
                      SizedBox(height: 10),
                      Text("Sign up to your account",
                          style: headingStyle16MBWhite()),
                      SizedBox(height: 20),
                      whiteTextField("Name", nameController,
                          TextInputType.emailAddress, false, "", (v) {
                        if (v!.isEmpty) {
                          return 'Please enter name';
                        } else {
                          return null;
                        }
                      }, onchange: (v) {
                        signUpModel!.name = v;
                      }),
                      SizedBox(height: 10),
                      whiteTextField("Surname", lastNameController,
                          TextInputType.emailAddress, false, "", (v) {
                        if (v!.isEmpty) {
                          return 'Please enter surname';
                        } else {
                          return null;
                        }
                      }, onchange: (v) {
                        signUpModel!.lastName = v;
                      }),
                      SizedBox(height: 10),
                      whiteTextField("Email", emailController,
                          TextInputType.emailAddress, false, "", (v) {
                        if (isValidEmail(v!)) {
                          return null;
                        } else {
                          return "Please Enter Valid Email";
                        }
                      }, onchange: (v) {
                        signUpModel!.userEmail = v;
                      }),
                      SizedBox(height: 10),
                      whiteTextField("Password", passwordController,
                          TextInputType.emailAddress, false, "", (v) {
                        if (v!.isEmpty) {
                          return 'Please enter passwrd';
                        } else if (v.length < 8) {
                          return "Password should not be less than 8";
                        } else {
                          return null;
                        }
                      }, onchange: (v) {
                        signUpModel!.userPassword = v;
                      }),
                      SizedBox(height: 10),
                      whiteTextField("Phone", phoneController,
                          TextInputType.number, false, "", (v) {
                        if (v!.isEmpty) {
                          return 'Please enter Phone';
                        } else {
                          return null;
                        }
                      }, onchange: (v) {
                        signUpModel!.phone = v;
                      }),
                      SizedBox(height: 10),
                      whiteTextField(
                          "Date Of Birth (DD-MM-YYYY)",
                          dobController,
                          TextInputType.number,
                          true,
                          "",
                          (v) {
                            if (v!.isEmpty) {
                              return 'Please enter date of birth';
                            } else {
                              return null;
                            }
                          },
                          onchange: (v) {
                            signUpModel!.dob = v;
                          },
                          formatter: [dobMaskFormatter],
                          onTap: () {
                            pickDate();
                          }),
                      SizedBox(height: 10),
                      whiteTextField("City Of Birth", cobController,
                          TextInputType.emailAddress, false, "", (v) {
                        if (v!.isEmpty) {
                          return 'Please enter city of birth';
                        } else {
                          return null;
                        }
                      }, onchange: (v) {
                        signUpModel!.cityOfBirth = v;
                      }),
                      SizedBox(height: 10),
                      whiteTextField("Fiscal Code", fiscalController,
                          TextInputType.number, false, "", (v) {
                        if (v!.isEmpty) {
                          return 'Please enter fiscal code';
                        } else {
                          return null;
                        }
                      }, onchange: (v) {
                        signUpModel!.fiscalCode = v;
                      }),
                      SizedBox(height: 10),
                      whiteTextField(
                        "Zip Code",
                        zipController,
                        TextInputType.number,
                        false,
                        "",
                        (v) {
                          if (v!.isEmpty) {
                            return 'Please enter zip code';
                          } else {
                            return null;
                          }
                        },
                        onchange: (v) {
                          signUpModel!.zipCode = v;
                        },
                      ),
                      SizedBox(height: 10),
                      whiteTextField("Street Name", streetController,
                          TextInputType.name, false, "", (v) {
                        if (v!.isEmpty) {
                          return 'Please enter Street name';
                        } else {
                          return null;
                        }
                      }, onchange: (v) {
                        signUpModel!.streetName = v;
                      }),
                      SizedBox(height: 10),
                      whiteTextField(
                        "State",
                        stateController,
                        TextInputType.name,
                        false,
                        "",
                        (v) {
                          if (v!.isEmpty) {
                            return 'Please enter state';
                          } else {
                            return null;
                          }
                        },
                        onchange: (v) {
                          signUpModel!.state = v;
                        },
                      ),
                      SizedBox(height: 10),
                      whiteTextField("Flat", flatController,
                          TextInputType.streetAddress, false, "", (v) {
                        if (v!.isEmpty) {
                          return 'Please enter flat ';
                        } else {
                          return null;
                        }
                      }, onchange: (v) {
                        signUpModel!.flat = v;
                      }),
                      SizedBox(height: 10),
                      whiteTextField(
                        "Country",
                        countryController,
                        TextInputType.name,
                        false,
                        "",
                        (v) {
                          if (v!.isEmpty) {
                            return 'Please enter country';
                          } else {
                            return null;
                          }
                        },
                        onchange: (v) {
                          signUpModel!.country = v;
                        },
                      ),
                      SizedBox(height: 10),
                      whiteTextField("Road Name", roadController,
                          TextInputType.name, false, "", (v) {
                        if (v!.isEmpty) {
                          return 'Please enter road name';
                        } else {
                          return null;
                        }
                      }, onchange: (v) {
                        signUpModel!.roadName = v;
                      }),
                      SizedBox(height: 10),
                      GetBuilder<CartController>(builder: (context) {
                        return Container(
                          // height: 55,
                          child: InputDecorator(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(45.0)),
                                // contentPadding: EdgeInsets.all(10),
                              ),
                              // border: OutlineInputBorder(
                              //   borderSide: BorderSide(color: Colors.white),
                              //   borderRadius:
                              //       const BorderRadius.all(Radius.circular(45.0)),
                              //   // contentPadding: EdgeInsets.all(10),
                              // ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<Data>(
                                dropdownColor: ColorResource.white,
                                isDense: true,
                                hint: Text(
                                  dropdownValue,
                                  style: headingStyle16MBWhite(),
                                ),
                                icon: const Icon(
                                  Icons.arrow_downward,
                                  color: ColorResource.white,
                                ),
                                elevation: 10,
                                isExpanded: true,
                                borderRadius: BorderRadius.circular(25),
                                style:
                                    const TextStyle(color: ColorResource.white),
                                onChanged: (Data? newValue) {
                                  setState(() {
                                    provinceId = newValue!.id;
                                    signUpModel!.provinceId =
                                        provinceId.toString();

                                    dropdownValue = newValue.name;
                                  });
                                },
                                items: cartController.provinceModel.data
                                    .map<DropdownMenuItem<Data>>((Data value) {
                                  return DropdownMenuItem<Data>(
                                    value: value,
                                    child: Text(
                                      value.name,
                                      style: headingStyle16NBLightGrey(),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        );
                      }),
                      SizedBox(height: 10),
                      whiteTextField("Address Of Living", aolController,
                          TextInputType.emailAddress, false, "", (v) {
                        if (v!.isEmpty) {
                          return 'Please enter address of living';
                        } else {
                          return null;
                        }
                      }, onchange: (v) {
                        signUpModel!.addressOfLiving = v;
                      }),
                      SizedBox(height: 10),
                      whiteTextField("Address OF Shipment", aosController,
                          TextInputType.emailAddress, false, "", (v) {
                        if (v!.isEmpty) {
                          return 'Please enter address of shipment';
                        } else {
                          return null;
                        }
                      }, onchange: (v) {
                        signUpModel!.addressOfShipment = v;
                      }),
                      SizedBox(height: 10),
                      CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          value: termsAndCondition,
                          onChanged: (v) {
                            setState(() {
                              termsAndCondition = v!;
                            });
                          },
                          activeColor: Colors.white,
                          checkColor: Colors.black,
                          contentPadding: EdgeInsets.all(0),
                          title: Text(
                            "Accept Terms and Conditions",
                            style: headingStyle16MBWhite(),
                          )),
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
                                    "Register",
                                    style: GoogleFonts.poppins(
                                        color: Color(0xffF11515),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                            onPressed: () {
                              if (formKey.currentState!.validate() &&
                                  termsAndCondition) {
                                controller
                                    .userSignUp(signUpModel!)
                                    .then((value) => Get.offAll(LoginScreen()));
                              }
                            },
                          ),
                        ),
                      ),
                    ]),
              ))),
            );
          }),
    );
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
            "${value!.day.toString().padLeft(2, '0')}-${value.month.toString().padLeft(2, '0')}-${value.year.toString()}";
        signUpModel!.dob = date;
        dobController.text = date;
      });
    });
  }
}
