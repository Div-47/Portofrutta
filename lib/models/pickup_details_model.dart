class PickupDetailsModel {
  PickupDetailsModel({
    required this.status,
    required this.data,
  });
  late final String status;
  late final List<Data> data;

  PickupDetailsModel.fromJson(Map<String, dynamic> json) {
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
  Data(
      {required this.id,
      this.pickupName,
      this.latitude,
      this.longitude,
      this.from,
      this.to});
  late final int id;
  late final String? pickupName;
  late final String? latitude;
  late final String? from;
  late final String? to;

  late final String? longitude;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pickupName = json['pickup_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['pickup_name'] = pickupName;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['from'] = from;
    _data['to'] = to;
    return _data;
  }
}
