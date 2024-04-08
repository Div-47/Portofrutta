class ProductDetailsModel {
  ProductDetailsModel({
    required this.data,
  });
  late final Data data;
  
  ProductDetailsModel.fromJson(Map<String, dynamic> json){
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.italicName,
    required this.productShortDescription,
    required this.productShortDescriptionItalic,
    required this.productDescription,
    required this.productDescriptionItalic,
    required this.productImage,
    required this.category,
    required this.productStock,
    required this.productMrpPrice,
    required this.productDiscountPrice,
    required this.productMeasurement,
    required this.productImages,
  });
  late final int id;
  late final String name;
  late final String italicName;
  late final String productShortDescription;
  late final String productShortDescriptionItalic;
  late final String productDescription;
  late final String productDescriptionItalic;
  late final String productImage;
  late final String category;
  late final String productStock;
  late final String productMrpPrice;
  late final String productDiscountPrice;
  late final String productMeasurement;
  late final List<dynamic> productImages;
  
  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    italicName = json['italic_name'];
    productShortDescription = json['product_short_description'];
    productShortDescriptionItalic = json['product_short_description_italic'];
    productDescription = json['product_description'];
    productDescriptionItalic = json['product_description_italic'];
    productImage = json['product_image'];
    category = json['category'];
    productStock = json['product_stock'];
    productMrpPrice = json['product_mrp_price'];
    productDiscountPrice = json['product_discount_price'];
    productMeasurement = json['product_measurement'];
    productImages = List.castFrom<dynamic, dynamic>(json['product_images']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['italic_name'] = italicName;
    _data['product_short_description'] = productShortDescription;
    _data['product_short_description_italic'] = productShortDescriptionItalic;
    _data['product_description'] = productDescription;
    _data['product_description_italic'] = productDescriptionItalic;
    _data['product_image'] = productImage;
    _data['category'] = category;
    _data['product_stock'] = productStock;
    _data['product_mrp_price'] = productMrpPrice;
    _data['product_discount_price'] = productDiscountPrice;
    _data['product_measurement'] = productMeasurement;
    _data['product_images'] = productImages;
    return _data;
  }
}