
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/Model/stockRequestList_model.dart';
import '../ConstFile/constApi.dart';
import '../ConstFile/constPreferences.dart';
import 'package:http/http.dart' as http;

class StockRequestController extends GetxController {
  RxList<RequestList> stockRequestList = <RequestList>[].obs;
  int? messageCode;
  RxBool isNoRequest = true.obs;

  void fetchStockRequest() async {
    stockRequestList.clear();
    String? distributorId =
        await ConstPreferences().getDistributorId("DistributorId");
    final response =
        await http.post(Uri.parse(ConstApi.stockRequestListApi), body: {
      "PageIndex": "0",
      "PageSize": "10",
      "Keyword": "",
      "DistributorId": distributorId
    });
    var data = response.body;
    debugPrint("stockRequest List : $data");

    if (response.statusCode == 200) {
      final responseData = stockRequestListModelFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint("stockRequest : $messageCode");

      if (messageCode == 200) {
        if (responseData.data.isNotEmpty) {
          isNoRequest.value = true;
          stockRequestList.addAll(responseData.data);
        } else {
          isNoRequest.value = false;
        }

        debugPrint("stockRequest get Successfully ");
      } else {
        debugPrint("Error in stockRequest");
      }
    } else {}
  }
}
