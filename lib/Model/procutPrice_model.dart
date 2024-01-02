// To parse this JSON data, do
//
//     final priceDetail = priceDetailFromJson(jsonString);

import 'dart:convert';

PriceDetail priceDetailFromJson(String str) => PriceDetail.fromJson(json.decode(str));

String priceDetailToJson(PriceDetail data) => json.encode(data.toJson());

class PriceDetail {
  String message;
  int messageCode;
  String status;
  List<ProductPriceDetail> data;

  PriceDetail({
    required this.message,
    required this.messageCode,
    required this.status,
    required this.data,
  });

  factory PriceDetail.fromJson(Map<String, dynamic> json) => PriceDetail(
    message: json["Message"],
    messageCode: json["MessageCode"],
    status: json["Status"],
    data: List<ProductPriceDetail>.from(json["Data"].map((x) => ProductPriceDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "MessageCode": messageCode,
    "Status": status,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ProductPriceDetail {
  int priceId;
  String priceDetails;
  double quantity;

  ProductPriceDetail({
    required this.priceId,
    required this.priceDetails,
    required this.quantity,

  });

  factory ProductPriceDetail.fromJson(Map<String, dynamic> json) => ProductPriceDetail(
    priceId: json["PriceId"],
    priceDetails: json["PriceDetails"],
    quantity: json["Quantity"],
  );

  Map<String, dynamic> toJson() => {
    "PriceId": priceId,
    "PriceDetails": priceDetails,
    "Quantity": quantity,
  };
}
