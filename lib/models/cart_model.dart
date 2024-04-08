class CartModel {
  CartModel({
    required this.data,
  });
  late final CartData data;

  CartModel.fromJson(Map<String, dynamic> json) {
    data = CartData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class CartData {
  CartData({
    required this.token,
    required this.cartDetails,
  });
  late var token;
  late final List<CartDetails> cartDetails;

  CartData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    cartDetails = List.from(json['cart_details'])
        .map((e) => CartDetails.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['token'] = token;
    _data['cart_details'] = cartDetails.map((e) => e.toJson()).toList();
    return _data;
  }
}

class CartDetails {
  CartDetails({
    required this.productId,
    required this.quantity,
    this.name,
    this.italicName,
    this.productShortDescription,
    this.productShortDescriptionItalic,
    this.productDescription,
    this.productDescriptionItalic,
    this.productImage,
    this.category,
    this.productStock,
    this.productMrpPrice,
    this.productDiscountPrice,
    this.productMeasurement,
    required this.latitude,
    required this.longitude,
  });
  late final int productId;
  late var quantity;
  late final String? name;
  late final String? italicName;
  late final String? productShortDescription;
  late final String? productShortDescriptionItalic;
  late final String? productDescription;
  late final String? productDescriptionItalic;
  late final String? productImage;
  late final String? category;
  late final String? productStock;
  late final String? productMrpPrice;
  late final String? productDiscountPrice;
  late final String? productMeasurement;
  late final String? latitude;
  late final String? longitude;

  CartDetails.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
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
    latitude = '';
    longitude = '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_id'] = productId;
    _data['quantity'] = quantity;
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
    return _data;
  }
}
