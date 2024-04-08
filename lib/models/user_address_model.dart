class UserAddressModel {
  UserAddressModel({
    required this.status,
    required this.data,
  });
  late final String status;
  late final List<Data> data;

  UserAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.fiscalCode,
    required this.flatOrHouseNumber,
    required this.streetName,
    required this.zipcode,
    required this.city,
    required this.provinceId,
    required this.provinceName,
    required this.state,
    required this.country,
  });
  late final int id;
  late final String name;
  late final String email;
  late final String phone;
  late final String fiscalCode;
  late final String flatOrHouseNumber;
  late final String streetName;
  late final String zipcode;
  late final String city;
  late final String provinceId;
  late final String provinceName;
  late final String state;
  late final String country;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    fiscalCode = json['fiscal_code'];
    flatOrHouseNumber = json['flat_or_house_number'];
    streetName = json['street_name'];
    zipcode = json['zipcode'];
    city = json['city'];
    provinceId = json['province_id'];
    provinceName = json['province_name'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['fiscal_code'] = fiscalCode;
    _data['flat_or_house_number'] = flatOrHouseNumber;
    _data['street_name'] = streetName;
    _data['zipcode'] = zipcode;
    _data['city'] = city;
    _data['province_id'] = provinceId;
    _data['province_name'] = provinceName;
    _data['state'] = state;
    _data['country'] = country;
    return _data;
  }
}
