// To parse this JSON data, do
//
//     final lowStockModel = lowStockModelFromJson(jsonString);

import 'dart:convert';

LowStockModel lowStockModelFromJson(String str) => LowStockModel.fromJson(json.decode(str));

String lowStockModelToJson(LowStockModel data) => json.encode(data.toJson());

class LowStockModel {
  String message;
  int messageCode;
  String status;
  int totalRecord;
  int recordPageCount;
  List<LowStockList> data;

  LowStockModel({
    required this.message,
    required this.messageCode,
    required this.status,
    required this.totalRecord,
    required this.recordPageCount,
    required this.data,
  });

  factory LowStockModel.fromJson(Map<String, dynamic> json) => LowStockModel(
    message: json["Message"],
    messageCode: json["MessageCode"],
    status: json["Status"],
    totalRecord: json["TotalRecord"],
    recordPageCount: json["RecordPageCount"],
    data: List<LowStockList>.from(json["Data"].map((x) => LowStockList.fromJson(x))),
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

class LowStockList {
  int productId;
  String imageName;
  String productName;
  double stockIn;
  double stockOut;
  double totalStock;
  double productLowStockSet;
  String unit;

  LowStockList({
    required this.productId,
    required this.imageName,
    required this.productName,
    required this.stockIn,
    required this.stockOut,
    required this.totalStock,
    required this.productLowStockSet,
    required this.unit,
  });

  factory LowStockList.fromJson(Map<String, dynamic> json) => LowStockList(
    productId: json["ProductId"],
    imageName: json["ImageName"],
    productName: json["ProductName"],
    stockIn: json["StockIn"],
    stockOut: json["StockOut"],
    totalStock: json["TotalStock"],
    productLowStockSet: json["ProductLowStockSet"],
    unit: json["Unit"],
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "ImageName": imageName,
    "ProductName": productName,
    "StockIn": stockIn,
    "StockOut": stockOut,
    "TotalStock": totalStock,
    "ProductLowStockSet": productLowStockSet,
    "Unit": unit,
  };
}
