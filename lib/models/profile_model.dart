class ProfileModel {
  ProfileModel({
    required this.status,
    required this.data,
  });
  late final String status;
   Data ?data;

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data!.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.name,
    required this.surname,
    required this.email,
    required this.dob,
    required this.cityOfBirth,
    required this.fiscalCode,
    required this.addressOfLiving,
    required this.addressForShipment,
    required this.phone,
    required this.profilePicture,
    this.filePath,
  });
   String ? name;
   String ?surname;
   String ?email;
   String ?dob;
   String ?cityOfBirth;
   String ?fiscalCode;
   String ?addressOfLiving;
   String ?addressForShipment;
   String ?phone;
   String ?profilePicture;
  String? filePath;

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    surname = json['surname'];
    email = json['email'];
    dob = json['dob'];
    cityOfBirth = json['city_of_birth'];
    fiscalCode = json['fiscal_code'];
    addressOfLiving = json['address_of_living'];
    addressForShipment = json['address_for_shipment'];
    phone = json['phone'];
    profilePicture = json['profile_picture'];
    filePath = '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['surname'] = surname;
    _data['email'] = email;
    _data['dob'] = dob;
    _data['city_of_birth'] = cityOfBirth;
    _data['fiscal_code'] = fiscalCode;
    _data['address_of_living'] = addressOfLiving;
    _data['address_for_shipment'] = addressForShipment;
    _data['phone'] = phone;
    _data['profile_picture'] = profilePicture;
    return _data;
  }
}
