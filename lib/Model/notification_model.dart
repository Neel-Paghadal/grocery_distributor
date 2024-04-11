// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  String message;
  int messageCode;
  String status;
  List<NotificationList> data;

  NotificationModel({
    required this.message,
    required this.messageCode,
    required this.status,
    required this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    message: json["Message"],
    messageCode: json["MessageCode"],
    status: json["Status"],
    data: List<NotificationList>.from(json["Data"].map((x) => NotificationList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "MessageCode": messageCode,
    "Status": status,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class NotificationList {
  int id;
  int distibutorId;
  String message;

  NotificationList({
    required this.id,
    required this.distibutorId,
    required this.message,
  });

  factory NotificationList.fromJson(Map<String, dynamic> json) => NotificationList(
    id: json["Id"],
    distibutorId: json["DistibutorId"],
    message: json["Message"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "DistibutorId": distibutorId,
    "Message": message,
  };
}
