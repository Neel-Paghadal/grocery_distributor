import 'package:flutter/material.dart';
import 'package:grocery_distributor/Model/assignorder_model.dart';
import 'package:grocery_distributor/Model/liveorder_model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../ConstFile/constApi.dart';

class HomeController extends GetxController {
  int? messageCode;
  int orderType = 4;
  String distributorId = "1";
  int currentIndex = 0;

  RxList<LiveOrders> liveOrderList = <LiveOrders>[].obs;
  RxList<OrderList> assignOrderList = <OrderList>[].obs;

  Future<void> LiveOrderApiCall() async {
    final response = await http.get(Uri.parse(ConstApi.liveOrderFilter),);
    var data = response.body;
    debugPrint("filter List : " + data);

    if (response.statusCode == 200) {
      final responseData = liveOrderFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint("LiveOrder : " + messageCode.toString());

      if (messageCode == 200) {
        liveOrderList.clear();
        liveOrderList.addAll(responseData.data);
        AssignOrderApiCall(orderType.toString(),distributorId);
        debugPrint("LiveOrder Successfully");
      } else {
        debugPrint("Error LiveOrder");
      }
    } else {}
  }

  Future<void> AssignOrderApiCall(String type,String distributorId) async {
    final response = await http.post(Uri.parse(ConstApi.assignOrder),
        body: {
         "LiveOrderType": "3",
         "DistriButerId": "20"

    });
    var data = response.body;
    debugPrint("Assign order List : " + data);

    if (response.statusCode == 200) {
      final responseData = assignOrderFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint("LiveOrder : " + messageCode.toString());

      if (messageCode == 200) {
        assignOrderList.clear();
        assignOrderList.addAll(responseData.data);
        debugPrint("Assign order Successfully");
      } else {
        debugPrint("Error Assign order");
      }
    } else {}
  }

  Future<void> OrderUpdateApiCall() async {
    final response = await http.post(Uri.parse(ConstApi.updateOrderStatus),
        body: {
          "OrderID": 10,
          "OrderStatusID": 2,
          "UserId": 2,
          "Remarks": "sample string 4"
        });
    var data = response.body;
    debugPrint("order update : " + data);

    if (response.statusCode == 200) {
      debugPrint("order update : " + messageCode.toString());
      if (messageCode == 200) {
        debugPrint("order update Successfully");
      } else {
        debugPrint("Error Assign order");
      }
    } else {}
  }


}
