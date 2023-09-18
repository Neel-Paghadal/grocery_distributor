// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  String message;
  int messageCode;
  String status;
  List<Datum> data;

  Login({
    required this.message,
    required this.messageCode,
    required this.status,
    required this.data,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    message: json["Message"],
    messageCode: json["MessageCode"],
    status: json["Status"],
    data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "MessageCode": messageCode,
    "Status": status,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  int id;
  String name;
  String address;
  String address1;
  String userId;
  String password;
  String conformPassword;
  String latitude;
  String longitude;
  String aadharCard;
  String panCard;
  String drivingLicence;
  String profileImage;
  String signImage;
  String mobileNo;
  int distiButerType;
  int bid;
  int uid;
  DateTime entryDate;
  DateTime updateDate;
  String updateBy;
  bool isActive;
  bool isDelete;

  Datum({
    required this.id,
    required this.name,
    required this.address,
    required this.address1,
    required this.userId,
    required this.password,
    required this.conformPassword,
    required this.latitude,
    required this.longitude,
    required this.aadharCard,
    required this.panCard,
    required this.drivingLicence,
    required this.profileImage,
    required this.signImage,
    required this.mobileNo,
    required this.distiButerType,
    required this.bid,
    required this.uid,
    required this.entryDate,
    required this.updateDate,
    required this.updateBy,
    required this.isActive,
    required this.isDelete,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["Id"],
    name: json["Name"],
    address: json["Address"],
    address1: json["Address1"],
    userId: json["UserId"],
    password: json["Password"],
    conformPassword: json["ConformPassword"],
    latitude: json["Latitude"],
    longitude: json["Longitude"],
    aadharCard: json["AadharCard"],
    panCard: json["PanCard"],
    drivingLicence: json["DrivingLicence"],
    profileImage: json["ProfileImage"],
    signImage: json["SignImage"],
    mobileNo: json["MobileNo"],
    distiButerType: json["DistiButerType"],
    bid: json["Bid"],
    uid: json["Uid"],
    entryDate: DateTime.parse(json["EntryDate"]),
    updateDate: DateTime.parse(json["UpdateDate"]),
    updateBy: json["UpdateBy"],
    isActive: json["IsActive"],
    isDelete: json["IsDelete"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": name,
    "Address": address,
    "Address1": address1,
    "UserId": userId,
    "Password": password,
    "ConformPassword": conformPassword,
    "Latitude": latitude,
    "Longitude": longitude,
    "AadharCard": aadharCard,
    "PanCard": panCard,
    "DrivingLicence": drivingLicence,
    "ProfileImage": profileImage,
    "SignImage": signImage,
    "MobileNo": mobileNo,
    "DistiButerType": distiButerType,
    "Bid": bid,
    "Uid": uid,
    "EntryDate": entryDate.toIso8601String(),
    "UpdateDate": updateDate.toIso8601String(),
    "UpdateBy": updateBy,
    "IsActive": isActive,
    "IsDelete": isDelete,
  };
}
