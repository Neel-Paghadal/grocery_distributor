// To parse this JSON data, do
//
//     final distributorDetail = distributorDetailFromJson(jsonString);

import 'dart:convert';

DistributorDetail distributorDetailFromJson(String str) => DistributorDetail.fromJson(json.decode(str));

String distributorDetailToJson(DistributorDetail data) => json.encode(data.toJson());

class DistributorDetail {
  String message;
  int messageCode;
  String status;
  List<DistibutorData> data;

  DistributorDetail({
    required this.message,
    required this.messageCode,
    required this.status,
    required this.data,
  });

  factory DistributorDetail.fromJson(Map<String, dynamic> json) => DistributorDetail(
    message: json["Message"],
    messageCode: json["MessageCode"],
    status: json["Status"],
    data: List<DistibutorData>.from(json["Data"].map((x) => DistibutorData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "MessageCode": messageCode,
    "Status": status,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DistibutorData {
  int id;
  String name;
  String address;
  String address1;
  int pincode;
  String userId;
  String password;
  String conformPassword;
  String city;
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

  DistibutorData({
    required this.id,
    required this.name,
    required this.address,
    required this.address1,
    required this.pincode,
    required this.userId,
    required this.password,
    required this.conformPassword,
    required this.city,
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

  factory DistibutorData.fromJson(Map<String, dynamic> json) => DistibutorData(
    id: json["Id"],
    name: json["Name"],
    address: json["Address"],
    address1: json["Address1"],
    pincode: json["Pincode"],
    userId: json["UserId"],
    password: json["Password"],
    conformPassword: json["ConformPassword"],
    city: json["City"],
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
    "Pincode": pincode,
    "UserId": userId,
    "Password": password,
    "ConformPassword": conformPassword,
    "City": city,
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
