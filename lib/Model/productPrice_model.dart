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
  double price;
  String commission;
  double priceWithCommission;
  double offerPrice;
  String unit;
  double quantity;

  ProductPriceDetail({
    required this.priceId,
    required this.price,
    required this.commission,
    required this.priceWithCommission,
    required this.offerPrice,
    required this.unit,
    required this.quantity,
  });

  factory ProductPriceDetail.fromJson(Map<String, dynamic> json) => ProductPriceDetail(
    priceId: json["PriceId"],
    price: json["Price"],
    commission: json["Commission"],
    priceWithCommission: json["PriceWithCommission"]?.toDouble(),
    offerPrice: json["OfferPrice"]?.toDouble(),
    unit: json["Unit"],
    quantity: json["Quantity"],
  );

  Map<String, dynamic> toJson() => {
    "PriceId": priceId,
    "Price": price,
    "Commission": commission,
    "PriceWithCommission": priceWithCommission,
    "OfferPrice": offerPrice,
    "Unit": unit,
    "Quantity": quantity,
  };
}



// // To parse this JSON data, do
// //
// //     final priceDetail = priceDetailFromJson(jsonString);
//
// import 'dart:convert';
//
// PriceDetail priceDetailFromJson(String str) => PriceDetail.fromJson(json.decode(str));
//
// String priceDetailToJson(PriceDetail data) => json.encode(data.toJson());
//
// class PriceDetail {
//   String message;
//   int messageCode;
//   String status;
//   List<ProductPriceDetail> data;
//
//   PriceDetail({
//     required this.message,
//     required this.messageCode,
//     required this.status,
//     required this.data,
//   });
//
//   factory PriceDetail.fromJson(Map<String, dynamic> json) => PriceDetail(
//     message: json["Message"],
//     messageCode: json["MessageCode"],
//     status: json["Status"],
//     data: List<ProductPriceDetail>.from(json["Data"].map((x) => ProductPriceDetail.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "Message": message,
//     "MessageCode": messageCode,
//     "Status": status,
//     "Data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }
//
// class ProductPriceDetail {
//   int priceId;
//   double price;
//   String unit;
//   double quantity;
//
//   ProductPriceDetail({
//     required this.priceId,
//     required this.price,
//     required this.unit,
//     required this.quantity,
//   });
//
//   factory ProductPriceDetail.fromJson(Map<String, dynamic> json) => ProductPriceDetail(
//     priceId: json["PriceId"],
//     price: json["Price"],
//     unit: json["Unit"],
//     quantity: json["Quantity"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "PriceId": priceId,
//     "Price": price,
//     "Unit": unit,
//     "Quantity": quantity,
//   };
// }
//
//
