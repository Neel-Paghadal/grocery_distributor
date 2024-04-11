import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/Model/godwonStock_model.dart';
import 'package:http/http.dart' as http;
import '../ConstFile/constApi.dart';
import '../ConstFile/constPreferences.dart';

class GodownStockController extends GetxController {
  RxList<GodownStockList> godownStockList = <GodownStockList>[].obs;
  int? messageCode;
  RxBool isNoDataInGodown = false.obs;

  void godownStockApiCall() async {
    godownStockList.clear();
    String? distributorId =
        await ConstPreferences().getDistributorId("DistributorId");
    final response = await http.post(Uri.parse(ConstApi.godwonStockApi), body: {
      "PageSize": "20",
      "PageIndex": "0",
      "SortCol": "0",
      "SortDir": "ASC",
      "DistriButerId": distributorId
    });
    var data = response.body;
    debugPrint("low stock List : $data");

    if (response.statusCode == 200) {
      final responseData = godwonStockModelFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint("LiveOrder : $messageCode");

      if (messageCode == 200) {
        if (responseData.data.isNotEmpty) {
          isNoDataInGodown.value = true;
          godownStockList.addAll(responseData.data);
        } else {
          isNoDataInGodown.value = false;
        }

        debugPrint("low stock get Successfully ");
      } else {
        debugPrint("Error in low stock");
      }
    } else {}
  }
}
