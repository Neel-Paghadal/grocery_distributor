

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/ConstFile/constApi.dart';
import 'package:grocery_distributor/ConstFile/constPreferences.dart';
import 'package:grocery_distributor/Model/userOrder_model.dart';
import 'package:http/http.dart' as http;

class UserOrderHistoryController extends GetxController{

  int? messageCode;
  RxList<UserOrder> userOrderHistory = <UserOrder>[].obs;
  String? customerId;

  // Future<void> UserOrderListApiCall(int userId) async {
  //   String? distributorId = await ConstPreferences().getDistributorId("DistributorId");
  //   debugPrint("Pref distributorId" + distributorId.toString());
  //   final response = await http.post(Uri.parse(ConstApi.userList),
  //       body: {
  //         "PageSize": 10,
  //         "PageIndex": 0,
  //         "Keyword": "",
  //         "UserId": 156,
  //         "DistriButerId": 20
  //       });
  //   var data = response.body;
  //   debugPrint(data.toString());
  //
  //   if (response.statusCode == 200) {
  //     final responseData = userOrderDetailFromJson(response.body);
  //     debugPrint(responseData.toString());
  //     messageCode = responseData.messageCode;
  //     debugPrint("LiveOrder : " + messageCode.toString());
  //
  //     if (messageCode == 200) {
  //       userOrderHistory.clear();
  //       userOrderHistory.addAll(responseData.data);
  //       debugPrint("User fetched Succefully");
  //     } else {
  //       debugPrint("Error in User fetched");
  //     }
  //   } else {}
  // }

  UserOrderListApiCall(String userId) async {

    String? distributorId = await ConstPreferences().getDistributorId("DistributorId");
    debugPrint("Pref distributorId " + distributorId.toString());
    debugPrint("Pref customerId " + userId.toString());
    final response = await http.post(Uri.parse(ConstApi.userOrderHistory),
        body: {
          "PageSize": "100",
          "PageIndex": "0",
          "Keyword": "",
          "UserId": userId,
          "DistriButerId": distributorId
        });
    var data = response.body;
    debugPrint(data.toString());

    if (response.statusCode == 200) {
      final responseData = userOrderDetailFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint("LiveOrder : " + messageCode.toString());

      if (messageCode == 200) {
        userOrderHistory.clear();
        userOrderHistory.addAll(responseData.data);
        return userOrderHistory;
        debugPrint("UserOrder History Fetch Succefully");
      } else {
        debugPrint("Error in UserOrder History");
      }
    } else {}
  }


}