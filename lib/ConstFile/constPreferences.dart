
import 'dart:convert';

import 'package:get/get.dart';
import 'package:grocery_distributor/Model/distributordeatil_model.dart';
import 'package:grocery_distributor/Model/get_notification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConstPreferences {

  var ADDRESS = "ADDRESS";
  var FLOOR = "FLOOR";
  var BUILDING = "BUILDING";
  var FLATE = "FLATE";
  var LANDMARK = "LANDMARK";
  var USERDATA = "USERDATA";
  var NAME = "NAME";
  var EMAIL = "EMAIL";
  var INDEX = "INDEX";
  var PINCODE = "PINCODE";
  var DISCOUNT = "DISCOUNT";
  var DIALOG = "DIALOG";

  Future<void> setFcmToken(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('FCMTOKEN', value);
  }

  Future<String?> getFcmToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('FCMTOKEN');
  }


  // Future<void> setDialogData(String value) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(DIALOG, value);
  // }
  //
  // Future<String?> getDialogData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(DIALOG);
  // }

  Future<void> saveDistributorId(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getDistributorId(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }


  Future<void> saveDistributorEmail(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getDistributorEmail(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> saveDistributorName(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getDistributorName(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
  Future<void> saveDistributorAddress(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getDistributorAddress(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
  Future<void> saveDistributorImage(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getDistributorImage(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> setDistributorWalletAmount(double value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble("USERWALLETAMOUNT", value);
  }

  Future<double?> getDistributorWalletAmount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble("USERWALLETAMOUNT");
  }

  Future<void> setUserData(DistibutorData user) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = user.toJson();
    prefs.setString(USERDATA, json.encode(userJson));
  }

  Future<DistibutorData?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(USERDATA);
    if (userJson != null) {
      return DistibutorData.fromJson(json.decode(userJson));
    } else {
      return null;
    }
  }

  Future<void> saveProductList(RxList<GetNotificationData> productList) async {
    final prefs = await SharedPreferences.getInstance();
    String productListJson = getNotificationDataToJson(productList);
    await prefs.setString('productList', productListJson);
  }

  Future<RxList<GetNotificationData>> getProductList() async {
    final prefs = await SharedPreferences.getInstance();
    String? productListJson = prefs.getString('productList');
    if (productListJson != null) {
      List<GetNotificationData> productList = getNotificationDataFromJson(productListJson);
      return RxList<GetNotificationData>.from(productList);
    }
    return <GetNotificationData>[].obs;
  }


  void clearPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  Future<void> removePreference(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
