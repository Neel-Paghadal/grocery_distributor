
// To parse this JSON data, do
//
//     final godwonStockModel = godwonStockModelFromJson(jsonString);

import 'dart:convert';

GodwonStockModel godwonStockModelFromJson(String str) => GodwonStockModel.fromJson(json.decode(str));

String godwonStockModelToJson(GodwonStockModel data) => json.encode(data.toJson());

class GodwonStockModel {
  String message;
  int messageCode;
  String status;
  List<GodownStockList > data;

  GodwonStockModel({
    required this.message,
    required this.messageCode,
    required this.status,
    required this.data,
  });

  factory GodwonStockModel.fromJson(Map<String, dynamic> json) => GodwonStockModel(
    message: json["Message"],
    messageCode: json["MessageCode"],
    status: json["Status"],
    data: List<GodownStockList >.from(json["Data"].map((x) => GodownStockList .fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "MessageCode": messageCode,
    "Status": status,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class GodownStockList  {
  int productId;
  String productName;
  String productImage;
  double stockIn;
  double stockOut;
  double totalStock;

  GodownStockList ({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.stockIn,
    required this.stockOut,
    required this.totalStock,
  });

  factory GodownStockList .fromJson(Map<String, dynamic> json) => GodownStockList (
    productId: json["ProductId"],
    productName: json["ProductName"],
    productImage: json["ProductImage"],
    stockIn: json["StockIn"],
    stockOut: json["StockOut"],
    totalStock: json["TotalStock"],
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "ProductName": productName,
    "ProductImage": productImage,
    "StockIn": stockIn,
    "StockOut": stockOut,
    "TotalStock": totalStock,
  };
}
