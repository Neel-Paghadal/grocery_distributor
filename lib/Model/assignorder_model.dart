// To parse this JSON data, do
//
//     final assignOrder = assignOrderFromJson(jsonString);

import 'dart:convert';

AssignOrder assignOrderFromJson(String str) => AssignOrder.fromJson(json.decode(str));

String assignOrderToJson(AssignOrder data) => json.encode(data.toJson());

class AssignOrder {
  String message;
  int messageCode;
  String status;
  List<OrderList> data;

  AssignOrder({
    required this.message,
    required this.messageCode,
    required this.status,
    required this.data,
  });

  factory AssignOrder.fromJson(Map<String, dynamic> json) => AssignOrder(
    message: json["Message"],
    messageCode: json["MessageCode"],
    status: json["Status"],
    data: List<OrderList>.from(json["Data"].map((x) => OrderList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "MessageCode": messageCode,
    "Status": status,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class OrderList {
  String imageName;
  int productId;
  int quantity;
  double totalAmount;
  int distriButerId;
  int customerId;
  int liveOrderType;
  String productName;
  String address;

  OrderList({
    required this.imageName,
    required this.productId,
    required this.quantity,
    required this.totalAmount,
    required this.distriButerId,
    required this.customerId,
    required this.liveOrderType,
    required this.productName,
    required this.address,
  });

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
    imageName: json["ImageName"],
    productId: json["ProductId"],
    quantity: json["Quantity"],
    totalAmount: json["TotalAmount"],
    distriButerId: json["DistriButerId"],
    customerId: json["CustomerId"],
    liveOrderType: json["LiveOrderType"],
    productName: json["ProductName"],
    address: json["Address"],
  );

  Map<String, dynamic> toJson() => {
    "ImageName": imageName,
    "ProductId": productId,
    "Quantity": quantity,
    "TotalAmount": totalAmount,
    "DistriButerId": distriButerId,
    "CustomerId": customerId,
    "LiveOrderType": liveOrderType,
    "ProductName": productName,
    "Address": address,
  };
}
