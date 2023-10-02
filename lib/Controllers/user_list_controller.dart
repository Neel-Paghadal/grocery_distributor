import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/ConstFile/constPreferences.dart';
import 'package:http/http.dart' as http;
import '../ConstFile/constApi.dart';
import '../Model/user_list_model.dart';

class UserListController extends GetxController{

  int? messageCode;
  RxList<Users> allUser = <Users>[].obs;

  Future<void> UserListApiCall() async {
    String? distributorId = await ConstPreferences().getDistributorId("DistributorId");
    debugPrint("Pref distributorId" + distributorId.toString());
    final response = await http.post(Uri.parse(ConstApi.userList),
        body: {
          "DistriButerId": "1"
        });
    var data = response.body;
    debugPrint(data.toString());

    if (response.statusCode == 200) {
      final responseData = allUserFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint("LiveOrder : " + messageCode.toString());

      if (messageCode == 200) {
        allUser.addAll(responseData.data);
        debugPrint("User fetched Succefully");
      } else {
        debugPrint("Error in User fetched");
      }
    } else {}
  }
}