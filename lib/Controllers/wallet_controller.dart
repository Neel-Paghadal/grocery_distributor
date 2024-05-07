
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Common/utils.dart';
import '../ConstFile/constApi.dart';
import '../ConstFile/constPreferences.dart';


class WalletController extends GetxController{

  RxDouble? walletAmount = 0.0.obs;
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  RxDouble totalWalletAmount = 0.0.obs;
  RxBool isShowWallet = false.obs;

  void getPrefData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // Users? userData =  await ConstPreferences().getUserData();
    // totalWalletAmount.value = userData!.amount;
  }

  Future<void> addWallet(String amount,String paymentStatus)async {
    // String? User_Id = await ConstPreferences().getUserId('UserId');
    final response = await http.post(Uri.parse(ConstApi.distributorDetail),body: {
      "CustomerId" : 'User_Id',
      "Amount" : amount,
      "PyamentGetwayString" : paymentStatus
    });
    var data = response.body;
    if(response.statusCode == 200){
      var jsonResponse = json.decode(data);
      print(jsonResponse["MessageCode"].toString());
      if(jsonResponse["MessageCode"] == 200){
        Utils().toastMessage("Wallet Amount Added!!");
        Get.back();
      }else {
        Utils().toastMessage("Wallet Transaction Failed");
      }
    }else{}
  }

  Future<void> WithdrawalApi(String amount, String remark) async {
    String? distributorId = await ConstPreferences().getDistributorId("DistributorId");
    final response = await http.post(Uri.parse(ConstApi.distributorWithdrawal),
        body: {
          "DistibutorId": distributorId,
          "Amount": amount,
          "DistributorRemark": remark
        });
    var data = response.body;
    debugPrint(data.toString());

    if (response.statusCode == 200) {
      Map<dynamic, dynamic> jsonResponse = json.decode(data);
      debugPrint(jsonResponse.toString());
      int messageCode = jsonResponse['MessageCode'];
      debugPrint(messageCode.toString());

      if (messageCode == 200) {
        Utils().snackBar("Successfully", "With Draw successfully.");
        debugPrint("With Draw Successfully");
      } else {
        Utils().snackBar("Failed", "Something went wrong.");
        debugPrint("Error");
      }
    } else {}
  }
}