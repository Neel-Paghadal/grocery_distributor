
import 'dart:convert';

AssignOrder assignOrderFromJson(String str) => AssignOrder.fromJson(json.decode(str));

String assignOrderToJson(AssignOrder data) => json.encode(data.toJson());

class AssignOrder {
  String message;
  int messageCode;
  String status;
  List<OrderList> data;

  AssignOrder({
    required this.message,
    required this.messageCode,
    required this.status,
    required this.data,
  });

  factory AssignOrder.fromJson(Map<String, dynamic> json) => AssignOrder(
    message: json["Message"],
    messageCode: json["MessageCode"],
    status: json["Status"],
    data: List<OrderList>.from(json["Data"].map((x) => OrderList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "MessageCode": messageCode,
    "Status": status,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class OrderList {
  String imageName;
  int productId;
  int quantity;
  double totalAmount;
  int distriButerId;
  int customerId;
  int liveOrderType;
  String productName;
  String discription;
  String mobileNo;
  String address;
  String name;
  int orderId;
  String unitType;
  double unitVal;
  int orderStatus;

  OrderList({
    required this.imageName,
    required this.productId,
    required this.quantity,
    required this.totalAmount,
    required this.distriButerId,
    required this.customerId,
    required this.liveOrderType,
    required this.productName,
    required this.discription,
    required this.mobileNo,
    required this.address,
    required this.name,
    required this.orderId,
    required this.unitType,
    required this.unitVal,
    required this.orderStatus,

  });

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
    imageName: json["ImageName"],
    productId: json["ProductId"],
    quantity: json["Quantity"],
    totalAmount: json["TotalAmount"],
    distriButerId: json["DistriButerId"],
    customerId: json["CustomerId"],
    liveOrderType: json["LiveOrderType"],
    productName: json["ProductName"],
    discription: json["Description"],
    mobileNo: json["MobileNo"],
    address: json["Address"],
    name: json["Name"] == null ? "Name" : json["Name"],
    orderId: json["OrderId"],
    unitType: json["UnitType"],
    unitVal: json["UnitVal"]?.toDouble(),
    orderStatus: json["OrderStatus"],
  );

  Map<String, dynamic> toJson() => {
    "ImageName": imageName,
    "ProductId": productId,
    "Quantity": quantity,
    "TotalAmount": totalAmount,
    "DistriButerId": distriButerId,
    "CustomerId": customerId,
    "LiveOrderType": liveOrderType,
    "ProductName": productName,
    "Description" : discription,
    "MobileNo": mobileNo,
    "Address": address,
    "Name": name,
    "OrderId": orderId,
    "UnitType": unitType,
    "UnitVal": unitVal,
    "OrderStatus": orderStatus,
  };
}



class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}





// import 'dart:convert';
//
// AssignOrder assignOrderFromJson(String str) => AssignOrder.fromJson(json.decode(str));
//
// String assignOrderToJson(AssignOrder data) => json.encode(data.toJson());
//
// class AssignOrder {
//   String message;
//   int messageCode;
//   String status;
//   List<OrderList> data;
//
//   AssignOrder({
//     required this.message,
//     required this.messageCode,
//     required this.status,
//     required this.data,
//   });
//
//   factory AssignOrder.fromJson(Map<String, dynamic> json) => AssignOrder(
//     message: json["Message"],
//     messageCode: json["MessageCode"],
//     status: json["Status"],
//     data: List<OrderList>.from(json["Data"].map((x) => OrderList.fromJson(x))),
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
// class OrderList {
//   String imageName;
//   int productId;
//   int quantity;
//   double totalAmount;
//   int distriButerId;
//   int customerId;
//   int liveOrderType;
//   String productName;
//   Address? address;
//   double unitVal;
//   int orderStatus;
//   MobileNo? mobileNo;
//   dynamic customerName;
//   int orderId;
//
//   factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
//     imageName: json["ImageName"],
//     productId: json["ProductId"],
//     quantity: json["Quantity"],
//     totalAmount: json["TotalAmount"],
//     distriButerId: json["DistriButerId"],
//     customerId: json["CustomerId"],
//     liveOrderType: json["LiveOrderType"],
//     productName: json["ProductName"],
//     address: addressValues.map[json["Address"]],
//     unitVal: json["UnitVal"],
//     orderStatus: json["OrderStatus"],
//     mobileNo: mobileNoValues.map[json["MobileNo"]],
//     customerName: json["CustomerName"],
//     orderId: json["OrderId"],
//   );
//
//   OrderList({
//     required this.imageName,
//     required this.productId,
//     required this.quantity,
//     required this.totalAmount,
//     required this.distriButerId,
//     required this.customerId,
//     required this.liveOrderType,
//     required this.productName,
//     required this.address,
//     required this.unitVal,
//     required this.orderStatus,
//     required this.mobileNo,
//     required this.customerName,
//     required this.orderId,
//   });
//
//   Map<String, dynamic> toJson() => {
//     "ImageName": imageName,
//     "ProductId": productId,
//     "Quantity": quantity,
//     "TotalAmount": totalAmount,
//     "DistriButerId": distriButerId,
//     "CustomerId": customerId,
//     "LiveOrderType": liveOrderType,
//     "ProductName": productName,
//     "Address": addressValues.reverse[address],
//     "UnitVal": unitVal,
//     "OrderStatus": orderStatus,
//     "MobileNo": mobileNoValues.reverse[mobileNo],
//     "CustomerName": customerName,
//     "OrderId": orderId,
//   };
// }
//
// enum Address {
//   F,
//   RAM_NAGAR_VARACHHA_SURAT_GUJARAT_395006_INDIA
// }
//
// final addressValues = EnumValues({
//   "f": Address.F,
//   "Ram Nagar, Varachha, Surat, Gujarat 395006, India": Address.RAM_NAGAR_VARACHHA_SURAT_GUJARAT_395006_INDIA
// });
//
// enum MobileNo {
//   H,
//   THE_9913365917
// }
//
// final mobileNoValues = EnumValues({
//   "h": MobileNo.H,
//   "9913365917": MobileNo.THE_9913365917
// });
//
// // enum ProductName {
// //   PATANJALI_COW_GHEE_TETRA_PACK,
// //   WINGREENS_GARLIC_DIP
// // }
//
// // final productNameValues = EnumValues({
// //   "Patanjali Cow Ghee (Tetra Pack)": ProductName.PATANJALI_COW_GHEE_TETRA_PACK,
// //   "Wingreens Garlic Dip": ProductName.WINGREENS_GARLIC_DIP
// // });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }



//
// import 'dart:convert';
//
// AssignOrder assignOrderFromJson(String str) => AssignOrder.fromJson(json.decode(str));
//
// String assignOrderToJson(AssignOrder data) => json.encode(data.toJson());
//
// class AssignOrder {
//   String message;
//   int messageCode;
//   String status;
//   List<OrderList> data;
//
//   AssignOrder({
//     required this.message,
//     required this.messageCode,
//     required this.status,
//     required this.data,
//   });
//
//   factory AssignOrder.fromJson(Map<String, dynamic> json) => AssignOrder(
//     message: json["Message"],
//     messageCode: json["MessageCode"],
//     status: json["Status"],
//     data: List<OrderList>.from(json["Data"].map((x) => OrderList.fromJson(x))),
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
// class OrderList {
//   String imageName;
//   int productId;
//   int quantity;
//   double totalAmount;
//   int distriButerId;
//   int customerId;
//   int liveOrderType;
//   String productName;
//   Address address;
//   double unitVal;
//   int orderStatus;
//   MobileNo mobileNo;
//   dynamic customerName;
//
//   OrderList({
//     required this.imageName,
//     required this.productId,
//     required this.quantity,
//     required this.totalAmount,
//     required this.distriButerId,
//     required this.customerId,
//     required this.liveOrderType,
//     required this.productName,
//     required this.address,
//     required this.unitVal,
//     required this.orderStatus,
//     required this.mobileNo,
//     required this.customerName,
//   });
//
//   factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
//     imageName: json["ImageName"],
//     productId: json["ProductId"],
//     quantity: json["Quantity"],
//     totalAmount: json["TotalAmount"],
//     distriButerId: json["DistriButerId"],
//     customerId: json["CustomerId"],
//     liveOrderType: json["LiveOrderType"],
//     productName: json["ProductName"],
//     address: addressValues.map[json["Address"]]!,
//     unitVal: json["UnitVal"],
//     orderStatus: json["OrderStatus"],
//     mobileNo: mobileNoValues.map[json["MobileNo"]]!,
//     customerName: json["CustomerName"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "ImageName": imageName,
//     "ProductId": productId,
//     "Quantity": quantity,
//     "TotalAmount": totalAmount,
//     "DistriButerId": distriButerId,
//     "CustomerId": customerId,
//     "LiveOrderType": liveOrderType,
//     "ProductName": productNameValues.reverse[productName],
//     "Address": addressValues.reverse[address],
//     "UnitVal": unitVal,
//     "OrderStatus": orderStatus,
//     "MobileNo": mobileNoValues.reverse[mobileNo],
//     "CustomerName": customerName,
//   };
// }
//
// enum Address {
//   F,
//   RAM_NAGAR_VARACHHA_SURAT_GUJARAT_395006_INDIA
// }
//
// final addressValues = EnumValues({
//   "f": Address.F,
//   "Ram Nagar, Varachha, Surat, Gujarat 395006, India": Address.RAM_NAGAR_VARACHHA_SURAT_GUJARAT_395006_INDIA
// });
//
// enum MobileNo {
//   H,
//   THE_9913365917
// }
//
// final mobileNoValues = EnumValues({
//   "h": MobileNo.H,
//   "9913365917": MobileNo.THE_9913365917
// });
//
// enum ProductName {
//   PATANJALI_COW_GHEE_TETRA_PACK,
//   WINGREENS_GARLIC_DIP
// }
//
// final productNameValues = EnumValues({
//   "Patanjali Cow Ghee (Tetra Pack)": ProductName.PATANJALI_COW_GHEE_TETRA_PACK,
//   "Wingreens Garlic Dip": ProductName.WINGREENS_GARLIC_DIP
// });
//
// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;
//
//   EnumValues(this.map);
//
//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
