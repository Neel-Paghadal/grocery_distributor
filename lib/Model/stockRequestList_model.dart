// To parse this JSON data, do
//
//     final stockRequestListModel = stockRequestListModelFromJson(jsonString);

import 'dart:convert';

StockRequestListModel stockRequestListModelFromJson(String str) =>
    StockRequestListModel.fromJson(json.decode(str));

String stockRequestListModelToJson(StockRequestListModel data) =>
    json.encode(data.toJson());

class StockRequestListModel {
  String message;
  int messageCode;
  String status;
  int totalRecord;
  int recordPageCount;
  List<RequestList> data;

  StockRequestListModel({
    required this.message,
    required this.messageCode,
    required this.status,
    required this.totalRecord,
    required this.recordPageCount,
    required this.data,
  });

  factory StockRequestListModel.fromJson(Map<String, dynamic> json) =>
      StockRequestListModel(
        message: json["Message"],
        messageCode: json["MessageCode"],
        status: json["Status"],
        totalRecord: json["TotalRecord"],
        recordPageCount: json["RecordPageCount"],
        data: List<RequestList>.from(
            json["Data"].map((x) => RequestList.fromJson(x))),
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

class RequestList {
  int productId;
  String productName;
  String description;
  int request;
  int quantity;
  double price;
  // String productImage;
  String unit;

  RequestList({
    required this.productId,
    required this.productName,
    required this.description,
    required this.request,
    required this.quantity,
    required this.price,
    // required this.productImage,
    required this.unit,
  });

  factory RequestList.fromJson(Map<String, dynamic> json) => RequestList(
        productId: json["ProductId"],
        productName: json["ProductName"],
        description: json["Description"],
        request: json["Request"],
        quantity: json["Quantity"],
        price: json["Price"],
        // productImage: json["ProductImage"],
        unit: json["Unit"],
      );

  Map<String, dynamic> toJson() => {
        "ProductId": productId,
        "ProductName": productName,
        "Description": description,
        "Request": request,
        "Quantity": quantity,
        "Price": price,
        // "ProductImage": productImage,
        "Unit": unit,
      };
}
