class DeliveryDetailsModel {
  DeliveryDetailsModel({
    required this.status,
    required this.data,
  });
  late final String status;
  late final List<Data> data;
  
  DeliveryDetailsModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.price,
    required this.zipCode,
  });
  late final int id;
  late final String price;
  late final String zipCode;
  
  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    zipCode = json['zip_code'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['price'] = price;
    _data['zip_code'] = zipCode;
    return _data;
  }
}