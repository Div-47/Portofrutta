class OfferModel {
  OfferModel({
    required this.data,
  });
  late final List<Data> data;
  
  OfferModel.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.sliderImage,
    required this.sliderTitle,
    required this.sliderDescription,
    required this.sliderLink,
    required this.createdAt,
    required this.updatedAt,
    required this.productId,
  });
  late final int id;
  late final String sliderImage;
  late final String sliderTitle;
  late final String sliderDescription;
  late final String sliderLink;
  late final String createdAt;
  late final String updatedAt;
  late final String productId;
  
  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    sliderImage = json['slider_image'];
    sliderTitle = json['slider_title'];
    sliderDescription = json['slider_description'];
    sliderLink = json['slider_link'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['slider_image'] = sliderImage;
    _data['slider_title'] = sliderTitle;
    _data['slider_description'] = sliderDescription;
    _data['slider_link'] = sliderLink;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['product_id'] = productId;
    return _data;
  }
}