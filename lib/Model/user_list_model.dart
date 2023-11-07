// To parse this JSON data, do
//
//     final allUser = allUserFromJson(jsonString);

import 'dart:convert';

AllUser allUserFromJson(String str) => AllUser.fromJson(json.decode(str));

String allUserToJson(AllUser data) => json.encode(data.toJson());

class AllUser {
  String message;
  int messageCode;
  String status;
  List<Users> data;

  AllUser({
    required this.message,
    required this.messageCode,
    required this.status,
    required this.data,
  });

  factory AllUser.fromJson(Map<String, dynamic> json) => AllUser(
    message: json["Message"],
    messageCode: json["MessageCode"],
    status: json["Status"],
    data: List<Users>.from(json["Data"].map((x) => Users.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "MessageCode": messageCode,
    "Status": status,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Users {
  int distriButerId;
  int customerId;
  String customerImage;
  String name;
  String address;
  String pinCode;
  String mobileNo;

  Users({
    required this.distriButerId,
    required this.customerId,
    required this.customerImage,
    required this.name,
    required this.address,
    required this.pinCode,
    required this.mobileNo,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    distriButerId: json["DistriButerId"],
    customerId: json["CustomerId"],
    customerImage: json["CustomerImage"],
    name: json["Name"] == null ? "" : json["Name"] ,
    address: json["Address"],
    pinCode: json["PinCode"],
    mobileNo: json["MobileNo"],
  );

  Map<String, dynamic> toJson() => {
    "DistriButerId": distriButerId,
    "CustomerId": customerId,
    "CustomerImage": customerImage,
    "Name": name,
    "Address": address,
    "PinCode": pinCode,
    "MobileNo": mobileNo,
  };
}
