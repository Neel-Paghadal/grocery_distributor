import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:grocery_distributor/Model/notification_model.dart';
import '../ConstFile/constApi.dart';
import '../ConstFile/constPreferences.dart';
import 'package:http/http.dart' as http;

class NotificationController extends GetxController {
  RxList<NotificationList> notificationList = <NotificationList>[].obs;
  RxBool isNoNewNotification = false.obs;
  int? messageCode;


  Future<void> getNotification() async {
    String? distributorId =
        await ConstPreferences().getDistributorId("DistributorId");

    final response = await http.post(Uri.parse(ConstApi.notificationList),
        body: {"DistibutorId": distributorId});
    var data = response.body;
    debugPrint(data.toString());

    if (response.statusCode == 200) {
      final responseData = notificationModelFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint(messageCode.toString());
      if (messageCode == 200) {
        if (responseData.data.isNotEmpty) {
          notificationList.addAll(responseData.data);
          isNoNewNotification.value = true;
        } else {
          isNoNewNotification.value = false;
        }
        debugPrint("user data Get Successfully");
      } else {
        debugPrint("Error");
      }
    } else {
      print("Something Went wrong");
    }
  }
}
