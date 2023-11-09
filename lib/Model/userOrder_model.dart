// To parse this JSON data, do
//
//     final userOrderDetail = userOrderDetailFromJson(jsonString);

import 'dart:convert';

UserOrderDetail userOrderDetailFromJson(String str) => UserOrderDetail.fromJson(json.decode(str));

String userOrderDetailToJson(UserOrderDetail data) => json.encode(data.toJson());

class UserOrderDetail {
  String message;
  int messageCode;
  String status;
  List<UserOrder> data;

  UserOrderDetail({
    required this.message,
    required this.messageCode,
    required this.status,
    required this.data,
  });

  factory UserOrderDetail.fromJson(Map<String, dynamic> json) => UserOrderDetail(
    message: json["Message"],
    messageCode: json["MessageCode"],
    status: json["Status"],
    data: List<UserOrder>.from(json["Data"].map((x) => UserOrder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "MessageCode": messageCode,
    "Status": status,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class UserOrder {
  String productName;
  int quantity;
  double price;
  double offerPrice;
  String imageName;
  int orderStatus;
  String unit;
  double unitVal;

  UserOrder({
    required this.productName,
    required this.quantity,
    required this.price,
    required this.offerPrice,
    required this.imageName,
    required this.orderStatus,
    required this.unit,
    required this.unitVal,
  });

  factory UserOrder.fromJson(Map<String, dynamic> json) => UserOrder(
    productName: json["ProductName"],
    quantity: json["Quantity"],
    price: json["Price"],
    offerPrice: json["OfferPrice"]?.toDouble(),
    imageName: json["ImageName"],
    orderStatus: json["OrderStatus"],
    unit: json["Unit"],
    unitVal: json["UnitVal"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "ProductName": productName,
    "Quantity": quantity,
    "Price": price,
    "OfferPrice": offerPrice,
    "ImageName": imageName,
    "OrderStatus": orderStatus,
    "Unit": unit,
    "UnitVal": unitVal,
  };
}
