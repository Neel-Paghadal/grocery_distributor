// To parse this JSON data, do
//
//     final stockRequest = stockRequestFromJson(jsonString);

import 'dart:convert';

StockRequest stockRequestFromJson(String str) => StockRequest.fromJson(json.decode(str));

String stockRequestToJson(StockRequest data) => json.encode(data.toJson());

class StockRequest {
  String message;
  int messageCode;
  String status;
  String data;

  StockRequest({
    required this.message,
    required this.messageCode,
    required this.status,
    required this.data,
  });

  factory StockRequest.fromJson(Map<String, dynamic> json) => StockRequest(
    message: json["Message"],
    messageCode: json["MessageCode"],
    status: json["Status"],
    data: json["Data"],
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "MessageCode": messageCode,
    "Status": status,
    "Data": data,
  };
}
