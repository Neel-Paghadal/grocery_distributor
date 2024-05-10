
// To parse this JSON data, do
//
//     final godwonStockModel = godwonStockModelFromJson(jsonString);

import 'dart:convert';

GodownStockModel godownStockModelFromJson(String str) => GodownStockModel.fromJson(json.decode(str));

String godownStockModelToJson(GodownStockModel data) => json.encode(data.toJson());

class GodownStockModel {
  String message;
  int messageCode;
  String status;
  List<GodownStockList > data;

  GodownStockModel({
    required this.message,
    required this.messageCode,
    required this.status,
    required this.data,
  });

  factory GodownStockModel.fromJson(Map<String, dynamic> json) => GodownStockModel(
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
  double offerPrice;
  double price;
  double unitVal;
  String unit;
  double productLowStockSet;

  GodownStockList ({
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.stockIn,
    required this.stockOut,
    required this.totalStock,
    required this.offerPrice,
    required this.price,
    required this.unitVal,
    required this.unit,
    required this.productLowStockSet,
  });

  factory GodownStockList .fromJson(Map<String, dynamic> json) => GodownStockList (
    productId: json["ProductId"],
    productName: json["ProductName"],
    productImage: json["ProductImage"],
    stockIn: json["StockIn"],
    stockOut: json["StockOut"],
    totalStock: json["TotalStock"],
    offerPrice: json["OfferPrice"],
    price: json["Price"],
    unitVal: json["UnitVal"],
    unit: json["Unit"],
    productLowStockSet: json["ProductLowStockSet"],
  );

  Map<String, dynamic> toJson() => {
    "ProductId": productId,
    "ProductName": productName,
    "ProductImage": productImage,
    "StockIn": stockIn,
    "StockOut": stockOut,
    "TotalStock": totalStock,
    "OfferPrice": offerPrice,
    "Price": price,
    "UnitVal": unitVal,
    "Unit": unit,
    "ProductLowStockSet": productLowStockSet,
  };
}
