class UserOrderModel {
  UserOrderModel({
    required this.status,
    required this.data,
  });
  late final String status;
  late final List<Data> data;

  UserOrderModel.fromJson(Map<String, dynamic> json) {
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
    required this.orderId,
    required this.userId,
    required this.shippingAddresId,
    required this.billingAddresId,
    required this.totalItems,
    required this.totalQuantity,
    required this.tax,
    required this.shippingAmount,
    required this.subTotal,
    required this.total,
    this.deleiveryDate,
    this.deleiveryTime,
    required this.orderStatus,
    required this.transactionId,
    required this.paymentMethod,
    required this.couponId,
    this.fattura24Id,
    required this.cancellNotes,
    required this.createdAt,
    required this.updatedAt,
    required this.deliveryType,
    this.latAndLong,
    required this.pickupAddressChoosen,
    required this.pickupDate,
    required this.pickupTime,
    required this.orderItems,
    required this.shippingDetails,
    // this.billingDetails,
  });
  late final int id;
  late final String orderId;
  late final String userId;
  late final String shippingAddresId;
  late final String billingAddresId;
  late final String totalItems;
  late final String totalQuantity;
  late final String tax;
  late final String shippingAmount;
  late final String subTotal;
  late final String total;
  late final String? deleiveryDate;
  late final String? deleiveryTime;
  late final String orderStatus;
  late final String transactionId;
  late final String paymentMethod;
  late final String? couponId;
  late final String? fattura24Id;
  late final String? cancellNotes;
  late final String createdAt;
  late final String? updatedAt;
  late final String deliveryType;
  late final String? latAndLong;
  late final String? pickupAddressChoosen;
  late final String? pickupDate;
  late final String? pickupTime;
  late final List<OrderItems> orderItems;
  late final ShippingDetails shippingDetails;
  // late final BillingDetails? billingDetails;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    userId = json['user_id'];
    shippingAddresId = json['shipping_addres_id'];
    billingAddresId = json['billing_addres_id'];
    totalItems = json['total_items'];
    totalQuantity = json['total_quantity'];
    tax = json['tax'];
    shippingAmount = json['shipping_amount'];
    subTotal = json['sub_total'];
    total = json['total'];
    deleiveryDate = json['deleivery_date'];
    deleiveryTime = json['deleivery_time'];
    orderStatus = json['order_status'];
    transactionId = json['transaction_id'];
    paymentMethod = json['payment_method'];
    couponId = json['coupon_id'];
    fattura24Id = json['fattura24_id'];
    cancellNotes = json['cancell_notes'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deliveryType = json['delivery_type'];
    latAndLong = json['lat_and_long'];
    pickupAddressChoosen = json['pickup_address_choosen'];
    pickupDate = json['pickup_date'];
    pickupTime = json['pickup_time'];
    orderItems = List.from(json['order_items'])
        .map((e) => OrderItems.fromJson(e))
        .toList();
    shippingDetails = ShippingDetails.fromJson(json['shipping_details']);
    // billingDetails = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['order_id'] = orderId;
    _data['user_id'] = userId;
    _data['shipping_addres_id'] = shippingAddresId;
    _data['billing_addres_id'] = billingAddresId;
    _data['total_items'] = totalItems;
    _data['total_quantity'] = totalQuantity;
    _data['tax'] = tax;
    _data['shipping_amount'] = shippingAmount;
    _data['sub_total'] = subTotal;
    _data['total'] = total;
    _data['deleivery_date'] = deleiveryDate;
    _data['deleivery_time'] = deleiveryTime;
    _data['order_status'] = orderStatus;
    _data['transaction_id'] = transactionId;
    _data['payment_method'] = paymentMethod;
    _data['coupon_id'] = couponId;
    _data['fattura24_id'] = fattura24Id;
    _data['cancell_notes'] = cancellNotes;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['delivery_type'] = deliveryType;
    _data['lat_and_long'] = latAndLong;
    _data['pickup_address_choosen'] = pickupAddressChoosen;
    _data['pickup_date'] = pickupDate;
    _data['pickup_time'] = pickupTime;
    _data['order_items'] = orderItems.map((e) => e.toJson()).toList();
    _data['shipping_details'] = shippingDetails.toJson();
    // _data['billing_details'] = billingDetails;
    return _data;
  }
}

class OrderItems {
  OrderItems({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.price,
    required this.qty,
    required this.totalAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.productImage,
    required this.productName,
    required this.productMeasurement,
  });
  late final int id;
  late final String orderId;
  late final String productId;
  late final String price;
  late final String qty;
  late final String totalAmount;
  late final String? createdAt;
  late final String? updatedAt;
  late final String productImage;
  late final String productName;
  late final String productMeasurement;

  OrderItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    price = json['price'];
    qty = json['qty'];
    totalAmount = json['total_amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productImage = json['product_image'];
    productName = json['product_name'];
    productMeasurement = json['product_measurement'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['order_id'] = orderId;
    _data['product_id'] = productId;
    _data['price'] = price;
    _data['qty'] = qty;
    _data['total_amount'] = totalAmount;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['product_image'] = productImage;
    _data['product_name'] = productName;
    _data['product_measurement'] = productMeasurement;
    return _data;
  }
}

class ShippingDetails {
  ShippingDetails({
    required this.id,
    required this.uuid,
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.flatOrHouseNumber,
    required this.streetName,
    required this.zipcode,
    required this.city,
    required this.province,
    required this.createdAt,
    required this.updatedAt,
    required this.state,
    required this.country,
  });
  late final int id;
  late final String uuid;
  late final String userId;
  late final String name;
  late final String email;
  late final String phone;
  late final String flatOrHouseNumber;
  late final String streetName;
  late final String zipcode;
  late final String city;
  late final String province;
  late final String? createdAt;
  late final String? updatedAt;
  late final String? state;
  late final String? country;

  ShippingDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    flatOrHouseNumber = json['flat_or_house_number'];
    streetName = json['street_name'];
    zipcode = json['zipcode'];
    city = json['city'];
    province = json['province'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['uuid'] = uuid;
    _data['user_id'] = userId;
    _data['name'] = name;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['flat_or_house_number'] = flatOrHouseNumber;
    _data['street_name'] = streetName;
    _data['zipcode'] = zipcode;
    _data['city'] = city;
    _data['province'] = province;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['state'] = state;
    _data['country'] = country;
    return _data;
  }
}

class BillingDetails {
  BillingDetails({
    required this.id,
    required this.uuid,
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.fiscalCode,
    required this.flatOrHouseNumber,
    required this.streetName,
    required this.zipcode,
    required this.city,
    required this.province,
    required this.createdAt,
    required this.updatedAt,
    required this.state,
    required this.country,
  });
  late final int id;
  late final String uuid;
  late final String userId;
  late final String name;
  late final String email;
  late final String phone;
  late final String fiscalCode;
  late final String flatOrHouseNumber;
  late final String streetName;
  late final String zipcode;
  late final String city;
  late final String province;
  late final String createdAt;
  late final String updatedAt;
  late final String state;
  late final String country;

  BillingDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    fiscalCode = json['fiscal_code'];
    flatOrHouseNumber = json['flat_or_house_number'];
    streetName = json['street_name'];
    zipcode = json['zipcode'];
    city = json['city'];
    province = json['province'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['uuid'] = uuid;
    _data['user_id'] = userId;
    _data['name'] = name;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['fiscal_code'] = fiscalCode;
    _data['flat_or_house_number'] = flatOrHouseNumber;
    _data['street_name'] = streetName;
    _data['zipcode'] = zipcode;
    _data['city'] = city;
    _data['province'] = province;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['state'] = state;
    _data['country'] = country;
    return _data;
  }
}
