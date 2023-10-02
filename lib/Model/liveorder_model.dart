import 'dart:convert';

LiveOrder liveOrderFromJson(String str) => LiveOrder.fromJson(json.decode(str));

String liveOrderToJson(LiveOrder data) => json.encode(data.toJson());

class LiveOrder {
  String message;
  int messageCode;
  String status;
  List<LiveOrders> data;

  LiveOrder({
    required this.message,
    required this.messageCode,
    required this.status,
    required this.data,
  });

  factory LiveOrder.fromJson(Map<String, dynamic> json) => LiveOrder(
    message: json["Message"],
    messageCode: json["MessageCode"],
    status: json["Status"],
    data: List<LiveOrders>.from(json["Data"].map((x) => LiveOrders.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Message": message,
    "MessageCode": messageCode,
    "Status": status,
    "Data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class LiveOrders {
  int id;
  String filterType;
  String updateBy;
  bool isActive;

  LiveOrders({
    required this.id,
    required this.filterType,
    required this.updateBy,
    required this.isActive,
  });

  factory LiveOrders.fromJson(Map<String, dynamic> json) => LiveOrders(
    id: json["Id"],
    filterType: json["FilterType"],
    updateBy: json["UpdateBy"],
    isActive: json["IsActive"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "FilterType": filterType,
    "UpdateBy": updateBy,
    "IsActive": isActive,
  };
}

