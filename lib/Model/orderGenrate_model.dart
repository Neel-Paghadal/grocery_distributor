// To parse this JSON data, do
//
//     final orderGenrate = orderGenrateFromJson(jsonString);

import 'dart:convert';

OrderGenrate orderGenrateFromJson(String str) => OrderGenrate.fromJson(json.decode(str));

String orderGenrateToJson(OrderGenrate data) => json.encode(data.toJson());

class OrderGenrate {
  String message;
  int messageCode;
  String status;
  int totalRecord;
  int recordPageCount;
  List<GenrateOrder> data;

  OrderGenrate({
    required this.message,
    required this.messageCode,
    required this.status,
    required this.totalRecord,
    required this.recordPageCount,
    required this.data,
  });

  factory OrderGenrate.fromJson(Map<String, dynamic> json) => OrderGenrate(
    message: json["Message"],
    messageCode: json["MessageCode"],
    status: json["Status"],
    totalRecord: json["TotalRecord"],
    recordPageCount: json["RecordPageCount"],
    data: List<GenrateOrder>.from(json["Data"].map((x) => GenrateOrder.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "MessageCode": messageCode,
    "Status": status,
    "TotalRecord": totalRecord,
    "RecordPageCount": recordPageCount,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GenrateOrder {
  int id;
  String productName;
  String productImage;

  GenrateOrder({
    required this.id,
    required this.productName,
    required this.productImage,

  });

  factory GenrateOrder.fromJson(Map<String, dynamic> json) => GenrateOrder(
    id: json["Id"],
    productName: json["ProductName"],
    productImage: json["ProductImage"],

  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "ProductName": productName,
    "ProductImage": productImage,
  };
}
