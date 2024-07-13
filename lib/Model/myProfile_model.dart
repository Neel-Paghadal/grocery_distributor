// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  String message;
  int messageCode;
  String status;
  List<Datum> data;

  ProfileModel({
    required this.message,
    required this.messageCode,
    required this.status,
    required this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
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
  int distiButerId;
  String name;
  String address;
  String mobileNo;
  String userId;
  String latitude;
  String longitude;
  String profileImage;
  String aadharCard;
  String panCard;
  String drivingLicence;
  String signImage;
  int distiButerType;
  String address1;
  int pincode;
  dynamic password;
  dynamic conformPassword;
  String city;
  int totalStockCount;
  int lowStockCount;
  double totalAmount;

  Datum({
    required this.distiButerId,
    required this.name,
    required this.address,
    required this.mobileNo,
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.profileImage,
    required this.aadharCard,
    required this.panCard,
    required this.drivingLicence,
    required this.signImage,
    required this.distiButerType,
    required this.address1,
    required this.pincode,
    required this.password,
    required this.conformPassword,
    required this.city,
    required this.totalStockCount,
    required this.lowStockCount,
    required this.totalAmount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    distiButerId: json["DistiButerId"],
    name: json["Name"],
    address: json["Address"],
    mobileNo: json["MobileNo"],
    userId: json["UserId"],
    latitude: json["Latitude"],
    longitude: json["Longitude"],
    profileImage: json["ProfileImage"],
    aadharCard: json["AadharCard"],
    panCard: json["PanCard"],
    drivingLicence: json["DrivingLicence"],
    signImage: json["SignImage"],
    distiButerType: json["DistiButerType"],
    address1: json["Address1"],
    pincode: json["Pincode"],
    password: json["Password"],
    conformPassword: json["ConformPassword"],
    city: json["City"],
    totalStockCount: json["TotalStockCount"],
    lowStockCount: json["LowStockCount"],
    totalAmount: json["TotalAmount"],
  );

  Map<String, dynamic> toJson() => {
    "DistiButerId": distiButerId,
    "Name": name,
    "Address": address,
    "MobileNo": mobileNo,
    "UserId": userId,
    "Latitude": latitude,
    "Longitude": longitude,
    "ProfileImage": profileImage,
    "AadharCard": aadharCard,
    "PanCard": panCard,
    "DrivingLicence": drivingLicence,
    "SignImage": signImage,
    "DistiButerType": distiButerType,
    "Address1": address1,
    "Pincode": pincode,
    "Password": password,
    "ConformPassword": conformPassword,
    "City": city,
    "TotalStockCount": totalStockCount,
    "LowStockCount": lowStockCount,
    "TotalAmount": totalAmount,
  };
}


// // To parse this JSON data, do
// //
// //     final profileModel = profileModelFromJson(jsonString);
//
// import 'dart:convert';
//
// ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));
//
// String profileModelToJson(ProfileModel data) => json.encode(data.toJson());
//
// class ProfileModel {
//   String message;
//   int messageCode;
//   String status;
//   List<Datum> data;
//
//   ProfileModel({
//     required this.message,
//     required this.messageCode,
//     required this.status,
//     required this.data,
//   });
//
//   factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
//     message: json["Message"],
//     messageCode: json["MessageCode"],
//     status: json["Status"],
//     data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
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
// class Datum {
//   int distiButerId;
//   String name;
//   String address;
//   String mobileNo;
//   String userId;
//   String latitude;
//   String longitude;
//   String profileImage;
//   String aadharCard;
//   String panCard;
//   String drivingLicence;
//   String signImage;
//   int distiButerType;
//   String address1;
//   int pincode;
//   dynamic password;
//   dynamic conformPassword;
//   String city;
//   int totalStockCount;
//   int lowStockCount;
//
//   Datum({
//     required this.distiButerId,
//     required this.name,
//     required this.address,
//     required this.mobileNo,
//     required this.userId,
//     required this.latitude,
//     required this.longitude,
//     required this.profileImage,
//     required this.aadharCard,
//     required this.panCard,
//     required this.drivingLicence,
//     required this.signImage,
//     required this.distiButerType,
//     required this.address1,
//     required this.pincode,
//     required this.password,
//     required this.conformPassword,
//     required this.city,
//     required this.totalStockCount,
//     required this.lowStockCount,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     distiButerId: json["DistiButerId"],
//     name: json["Name"],
//     address: json["Address"],
//     mobileNo: json["MobileNo"],
//     userId: json["UserId"],
//     latitude: json["Latitude"],
//     longitude: json["Longitude"],
//     profileImage: json["ProfileImage"],
//     aadharCard: json["AadharCard"],
//     panCard: json["PanCard"],
//     drivingLicence: json["DrivingLicence"],
//     signImage: json["SignImage"],
//     distiButerType: json["DistiButerType"],
//     address1: json["Address1"],
//     pincode: json["Pincode"],
//     password: json["Password"],
//     conformPassword: json["ConformPassword"],
//     city: json["City"],
//     totalStockCount: json["TotalStockCount"],
//     lowStockCount: json["LowStockCount"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "DistiButerId": distiButerId,
//     "Name": name,
//     "Address": address,
//     "MobileNo": mobileNo,
//     "UserId": userId,
//     "Latitude": latitude,
//     "Longitude": longitude,
//     "ProfileImage": profileImage,
//     "AadharCard": aadharCard,
//     "PanCard": panCard,
//     "DrivingLicence": drivingLicence,
//     "SignImage": signImage,
//     "DistiButerType": distiButerType,
//     "Address1": address1,
//     "Pincode": pincode,
//     "Password": password,
//     "ConformPassword": conformPassword,
//     "City": city,
//     "TotalStockCount": totalStockCount,
//     "LowStockCount": lowStockCount,
//   };
// }
