import 'dart:convert';
import 'dart:io';

import 'package:fruits/models/profile_model.dart' as profile;
import 'package:fruits/services/app_services.dart';
import 'package:fruits/utility/logout.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/product_model.dart';

class ProfileController extends GetxController {
  bool isLoading = false;
  bool profileUpdateLoading = false;

  profile.ProfileModel? profileModel;

  Future fetchProfile() async {
    try {
      profileModel = profile.ProfileModel(
          status: "false",
          data: profile.Data(
              name: "",
              addressForShipment: "",
              addressOfLiving: "",
              cityOfBirth: "",
              dob: "",
              email: "",
              fiscalCode: "",
              phone: "",
              profilePicture: "",
              surname: ""));
      isLoading = true;
      update();
      var response = await AppService().getProfileApi();
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.body);
        var list = jsonDecode(response.body.toString());
        profileModel = profile.ProfileModel.fromJson(list);
        // print(listModel);
      } else if (response.statusCode == 401) {
        logout();
        Get.snackbar("401 Unauthorized", "Authorization Failed");
      }
    } catch (e) {
      isLoading = false;
      update();
    }

    isLoading = false;
    update();
  }

  Future updateProfile() async {
    try {
      profileUpdateLoading = true;
      update();
      var body = {
        "name": profileModel!.data!.name!,
        "email": profileModel!.data!.email!,
        "surname": profileModel!.data!.surname!,
        "phone": profileModel!.data!.phone!,
        // "password": "12345678",
        "city_of_birth": profileModel!.data!.cityOfBirth!,
        "address_of_living": profileModel!.data!.addressOfLiving!,
        "dob": profileModel!.data!.dob!
      };
      var response = await AppService()
          .postUserProfileUpdate(body, profileModel!.data!.filePath!);
      var res = await response.stream.bytesToString();
      print(res);
      if (response.statusCode == 200) {
        Get.snackbar("Success", "Updated Profile");
        // var list = jsonDecode(response.body.toString());
        // profileModel = profile.ProfileModel.fromJson(list);
        // print(listModel);
      } else if (response.statusCode == 401) {
        logout();
        Get.snackbar("401 Unauthorized", "Authorization Failed");
      }
    } catch (e) {
      print(e);
      profileUpdateLoading = false;
      update();
    }

    profileUpdateLoading = false;
    update();
  }

  void updateName(String name) {
    profileModel!.data!.name = name;
    // update();
  }

  void updateLastName(String lastName) {
    profileModel!.data!.surname = lastName;
    // update();
  }

  void updatePhone(String phone) {
    profileModel!.data!.phone = phone;
    // update();
  }

  void updateEmail(String email) {
    profileModel!.data!.email = email;
    // update();
  }

  void updateCob(String cob) {
    profileModel!.data!.cityOfBirth = cob;
    // update();
  }

  void updateDob(String dob) {
    profileModel!.data!.dob = dob;
    // update();
  }

  void updateAol(String aol) {
    profileModel!.data!.addressOfLiving = aol;
    // update();
  }

  void pickImage() async {
    var file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      profileModel!.data!.filePath = file.path;
      update();
    }
  }
}
