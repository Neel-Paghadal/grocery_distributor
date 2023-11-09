import 'package:flutter/material.dart';
import 'package:grocery_distributor/Common/utils.dart';
import 'package:grocery_distributor/Model/assignorder_model.dart';
import 'package:grocery_distributor/Model/liveorder_model.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../ConstFile/constApi.dart';
import '../ConstFile/constPreferences.dart';

class HomeController extends GetxController {
  int? messageCode;
  int? orderType;
  String distributorId = "1";
  int currentIndex = 0;
  int? OrderStatus;
  TextEditingController reasonController = TextEditingController();
  RxList<LiveOrders> liveOrderList = <LiveOrders>[].obs;
  RxList<OrderList> assignOrderList = <OrderList>[].obs;
  RxBool isChange = false.obs;


  String? distributorEmail;
  String? distributorName;
  String? distributorAddress;
  String? distributorImage;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDistributorData();
    currentIndex = 0;
  }
  getDistributorData() async {
    distributorEmail = await ConstPreferences().getDistributorEmail("DistributorEmail");
    distributorName = await ConstPreferences().getDistributorName("DistributorName");
    distributorAddress = await ConstPreferences().getDistributorAddress("DistributorAdd");
    distributorImage = await ConstPreferences().getDistributorImage("DistributorImage");
    debugPrint("*****************"+distributorImage.toString());
  }



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
        // AssignOrderApiCall(orderType.toString(),distributorId);
        debugPrint("LiveOrder Successfully");
      } else {
        debugPrint("Error LiveOrder");
      }
    } else {}
  }


 AssignOrderApiCall(String type,String distributorId) async {
    String? distributorId = await ConstPreferences().getDistributorId("DistributorId");
    final response = await http.post(Uri.parse(ConstApi.assignOrder),
        body: {
         "LiveOrderType": type,
         "DistriButerId": distributorId,

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
        return assignOrderList;
      } else {
        debugPrint("Error Assign order");
      }
    } else {}
  }

  Future<void> OrderUpdateApiCall(String orderStatusId ,String orderid,String reason) async {
    String? distributorId = await ConstPreferences().getDistributorId("DistributorId");
    final response = await http.post(Uri.parse(ConstApi.updateOrderStatus),
        body: {
          "OrderID": orderid,
          "OrderStatusID": orderStatusId,
          "UserId": distributorId,
          "Remarks": reason
        });
    var data = response.body;
    debugPrint("order update : " + data);

    if (response.statusCode == 200) {
      debugPrint("order update : " + messageCode.toString());
      if (messageCode == 200) {
        debugPrint("order update Successfully");
        Utils().toastMessage("Order Updated");
      } else {
        debugPrint("Error Assign order");
      }
    } else {}
  }


}
