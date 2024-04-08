class SignUpModel {
  String? userEmail;
  String? userPassword;
  String? name;
  String? lastName;
  String? phone;
  String? dob;
  String? fiscalCode;
  String? addressOfLiving;
  String? addressOfShipment;
  String? cityOfBirth;
  String? zipCode;
  String? provinceId;
  String? streetName;
  String? flat;
  String? state;
  String? country;
  String? roadName;
  SignUpModel(
      this.name,
      this.lastName,
      this.userEmail,
      this.userPassword,
      this.phone,
      this.addressOfLiving,
      this.addressOfShipment,
      this.dob,
      this.fiscalCode,
      this.cityOfBirth,
      this.zipCode,this.provinceId,this.streetName,this.flat,this.state,this.country,this.roadName);
}
