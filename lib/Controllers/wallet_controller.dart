
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Common/utils.dart';
import '../ConstFile/constApi.dart';


class WalletController extends GetxController{

  RxDouble? walletAmount = 0.0.obs;
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
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

}