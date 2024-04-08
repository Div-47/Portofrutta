class ProductModel {
  List<Data>? data;

  ProductModel({this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  bool? cartUpdateLoading = false;
  String? name;
  String? italicName;
  var productQuantity;
  String? productShortDescription;
  String? productShortDescriptionItalic;
  String? productDescription;
  String? productDescriptionItalic;
  String? productImage;
  String? productStock;
  String? productMrpPrice;
  String? productDiscountPrice;
  String? productMeasurement;

  Data(
      {this.id,
      this.cartUpdateLoading,
      this.name,
      this.italicName,
      required this.productQuantity,
      this.productShortDescription,
      this.productShortDescriptionItalic,
      this.productDescription,
      this.productDescriptionItalic,
      this.productImage,
      this.productStock,
      this.productMrpPrice,
      this.productDiscountPrice,
      this.productMeasurement});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    italicName = json['italic_name'];
    productShortDescription = json['product_short_description'];
    productShortDescriptionItalic = json['product_short_description_italic'];
    productDescription = json['product_description'];
    productDescriptionItalic = json['product_description_italic'];
    productImage = json['product_image'];
    productStock = json['product_stock'];
    productMrpPrice = json['product_mrp_price'];
    productDiscountPrice = json['product_discount_price'];
    productMeasurement = json['product_measurement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

    data['name'] = this.name;
    data['italic_name'] = this.italicName;
    data['product_short_description'] = this.productShortDescription;
    data['product_short_description_italic'] =
        this.productShortDescriptionItalic;
    data['product_description'] = this.productDescription;
    data['product_description_italic'] = this.productDescriptionItalic;
    data['product_image'] = this.productImage;
    data['product_stock'] = this.productStock;
    data['product_mrp_price'] = this.productMrpPrice;
    data['product_discount_price'] = this.productDiscountPrice;
    data['product_measurement'] = this.productMeasurement;
    return data;
  }
}
