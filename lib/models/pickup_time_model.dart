class PickupTimeModel {
  PickupTimeModel({
    required this.status,
    required this.data,
  });
  late final String status;
  late final List<Data> data;
  
  PickupTimeModel.fromJson(Map<String, dynamic> json){
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
    required this.date,
    required this.time,
  });
  late final String date;
  late final List<Time> time;
  
  Data.fromJson(Map<String, dynamic> json){
    date = json['date'];
    time = List.from(json['time']).map((e)=>Time.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['date'] = date;
    _data['time'] = time.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Time {
  Time({
    required this.id,
    required this.time,
  });
  late final int id;
  late final String time;
  
  Time.fromJson(Map<String, dynamic> json){
    id = json['id'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['time'] = time;
    return _data;
  }
}