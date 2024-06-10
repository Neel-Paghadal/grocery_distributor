// To parse this JSON data, do
//
//     final getNotificationData = getNotificationDataFromJson(jsonString);

import 'dart:convert';

List<GetNotificationData> getNotificationDataFromJson(String str) => List<GetNotificationData>.from(json.decode(str).map((x) => GetNotificationData.fromJson(x)));

String getNotificationDataToJson(List<GetNotificationData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetNotificationData {
  String orderId;
  String product;
  String quantity;
  String unit;
  String price;
  String address;
  String imageName;

  GetNotificationData({
    required this.orderId,
    required this.product,
    required this.quantity,
    required this.unit,
    required this.price,
    required this.address,
    required this.imageName,
  });

  factory GetNotificationData.fromJson(Map<String, dynamic> json) => GetNotificationData(
    orderId: json["OrderId"],
    product: json["Product"],
    quantity: json["Quantity"],
    unit: json["Unit"],
    price: json["Price"],
    address: json["Address"],
    imageName: json["ImageName"],
  );

  Map<String, dynamic> toJson() => {
    "OrderId": orderId,
    "Product": product,
    "Quantity": quantity,
    "Unit": unit,
    "Price": price,
    "Address": address,
    "ImageName": imageName,
  };
}
