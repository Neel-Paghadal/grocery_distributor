import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grocery_distributor/Common/BottomBarScreen.dart';
import 'package:grocery_distributor/Common/utils.dart';
import 'package:grocery_distributor/Controllers/my_profile_controller.dart';
import 'package:grocery_distributor/Model/assignorder_model.dart';
import 'package:grocery_distributor/Model/liveorder_model.dart';
import 'package:grocery_distributor/Screens/home_screen.dart';
import 'package:grocery_distributor/api_services/all_services.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../ConstFile/constApi.dart';
import '../ConstFile/constColor.dart';
import '../ConstFile/constFonts.dart';
import '../ConstFile/constPreferences.dart';
import '../Model/get_notification_model.dart';

MyProfileController myProfileController = Get.put(MyProfileController());

class HomeController extends GetxController {
  int? messageCode;
  int? orderType = 1;
  String distributorId = "1";
  int currentIndex = 0;
  int? OrderStatus;
  TextEditingController reasonController = TextEditingController();
  RxList<LiveOrders> liveOrderList = <LiveOrders>[].obs;
  RxList<OrderList> assignOrderList = <OrderList>[].obs;
  // RxList<GetNotificationData> productList = <GetNotificationData>[].obs;
  RxBool isChange = false.obs;
  RxBool isFilterApplyed = false.obs;
  RxBool isListEmplty = false.obs;


  String? distributorEmail;
  String? distributorName;
  String? distributorAddress;
  String? distributorImage;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDistributorData();
    myProfileController.UserDetailApi();
    myProfileController.getPrefData();
    currentIndex = 0;
  }

  getDistributorData() async {
    distributorEmail =
        await ConstPreferences().getDistributorEmail("DistributorEmail");
    distributorName =
        await ConstPreferences().getDistributorName("DistributorName");
    distributorAddress =
        await ConstPreferences().getDistributorAddress("DistributorAdd");
    distributorImage =
        await ConstPreferences().getDistributorImage("DistributorImage");
    debugPrint("*****************" + distributorImage.toString());
  }

  String formatPrice(double price) {
    if (price % 1 == 0) {
      return price.toStringAsFixed(0);
    } else {
      return price.toStringAsFixed(2);
    }
  }

  String removeDecimalValue(String input) {
    List<String> parts = input.split(", ");
    for (int i = 0; i < parts.length; i++) {
      if (parts[i].contains(".")) {
        parts[i] = parts[i].split(".")[0] + " " + parts[i].split(" ")[1];
      }
    }
    return parts.join(", ");
  }

  Future<void> LiveOrderApiCall() async {
    final response = await http.get(
      Uri.parse(ConstApi.liveOrderFilter),
    );
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

  AssignOrderApiCall(String type, String distributorId) async {
    String? distributorId = await ConstPreferences().getDistributorId("DistributorId");
    final response = await http.post(Uri.parse(ConstApi.assignOrder), body: {
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
        if (assignOrderList.isEmpty) {
          isListEmplty = true.obs;
        } else {
          isListEmplty = false.obs;
        }
        debugPrint("Assign order Successfully");
        // showAlarmDialog("context", 0);
        return assignOrderList;
      } else {
        debugPrint("Error Assign order");
      }
    } else {}
  }

  Future<void> OrderUpdateApiCall(
      String orderStatusId, String orderid, String reason) async {
    String? distributorId =
        await ConstPreferences().getDistributorId("DistributorId");
    final response =
        await http.post(Uri.parse(ConstApi.updateOrderStatus), body: {
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

  Future<void> getProductFilterApiCall(
      int orderType, String toDate, String fromDate, String type) async {
    String? distributorId =
        await ConstPreferences().getDistributorId("DistributorId");
    debugPrint(distributorId);
    final response =
        await http.post(Uri.parse(ConstApi.getProdectFilterWise), body: {
      "PageSize": "100",
      "PageIndex": "0",
      "Keyword": "",
      "FromDate": fromDate.toString(),
      "ToDate": toDate.toString(),
      "OrderStatus": orderType.toString(),
      "DistriButerId": distributorId,
      "LiveOrderType": type
    });
    var data = response.body;
    debugPrint("Assign order List : " + data);

    if (response.statusCode == 200) {
      final responseData = assignOrderFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint("LiveOrder Filter Product : " + messageCode.toString());

      if (messageCode == 200) {
        assignOrderList.clear();
        assignOrderList.addAll(responseData.data);
        if (assignOrderList.isEmpty) {
          isListEmplty = true.obs;
        } else {
          isListEmplty = false.obs;
        }

        debugPrint("Filter Product Successfully");
        // return assignOrderList;
      } else {
        debugPrint("Error Filter Product order");
      }
    } else {}
  }

  showExitAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: const Text("Confirm Exit..!!!"),
      content: const Text("Are You Want to Exit This App?"),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: ConstColour.primaryColor),
          onPressed: () {
            SystemNavigator.pop();
          },
          child: const Text(
            "Yes",
            style: TextStyle(color: Colors.black),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: ConstColour.bgColor),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "No",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
