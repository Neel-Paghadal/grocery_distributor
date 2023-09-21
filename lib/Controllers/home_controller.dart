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

  RxList<LiveOrders> liveOrderList = <LiveOrders>[].obs;
  RxList<OrderList> assignOrderList = <OrderList>[].obs;

  Future<void> LiveOrderApiCall() async {
    final response = await http.post(Uri.parse(ConstApi.liveOrder),
        body: {
      "PageSize": "10", "PageIndex": "0"
    });
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
        // categoriesController.categoryList.addAll(responseData.data);
        debugPrint("LiveOrder Successfully");
        // Fluttertoast.showToast(
        //     msg: "Product GetList Successfully",
        //     fontSize: 18,
        //     backgroundColor: ConstColour.primaryColor,
        //     textColor: Colors.white);
      } else {
        debugPrint("Error LiveOrder");
        // ArtSweetAlert.show(
        //     context: context,
        //     artDialogArgs: ArtDialogArgs(
        //         confirmButtonColor: ConstColour.primaryColor,
        //         type: ArtSweetAlertType.danger,
        //         text: "Please Enter Address"));
      }
    } else {}
  }

  Future<void> AssignOrderApiCall(String type,String distributorId) async {
    final response = await http.post(Uri.parse(ConstApi.assignOrder),
        body: {

         "LiveOrderType": "4",
         "DistriButerId": "1"

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
        // categoriesController.categoryList.addAll(responseData.data);
        debugPrint("Assign order Successfully");
        // Fluttertoast.showToast(
        //     msg: "Product GetList Successfully",
        //     fontSize: 18,
        //     backgroundColor: ConstColour.primaryColor,
        //     textColor: Colors.white);
      } else {
        debugPrint("Error Assign order");
        // ArtSweetAlert.show(
        //     context: context,
        //     artDialogArgs: ArtDialogArgs(
        //         confirmButtonColor: ConstColour.primaryColor,
        //         type: ArtSweetAlertType.danger,
        //         text: "Please Enter Address"));
      }
    } else {}
  }

  int currentIndex = 0;
}
