import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../ConstFile/constApi.dart';
import 'package:http/http.dart' as http;

import '../ConstFile/constPreferences.dart';
import '../Model/lowStock_model.dart';

class LowStockController extends GetxController {
  RxList<LowStockList> lowStockList = <LowStockList>[].obs;
  int? messageCode;
  RxBool isNoDataInStock = false.obs;
  lowStockApiCall() async {
    lowStockList.clear();
    String? distributorId =
        await ConstPreferences().getDistributorId("DistributorId");
    final response = await http.post(Uri.parse(ConstApi.lowStockApi), body: {
      "PageIndex": "0",
      "PageSize": "1115",
      "Keyword": "",
      "DistributorId": distributorId
    });
    var data = response.body;
    debugPrint("low stock List : $data");

    if (response.statusCode == 200) {
      final responseData = lowStockModelFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint("LiveOrder : $messageCode");

      if (messageCode == 200) {
        if (responseData.data.isNotEmpty) {
          isNoDataInStock.value = true;
          lowStockList.addAll(responseData.data);
        } else {
          isNoDataInStock.value = false;
        }

        debugPrint("low stock get Successfully ");
      } else {
        debugPrint("Error in low stock");
      }
    } else {}
  }
}
