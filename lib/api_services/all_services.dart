import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/Common/BottomBarScreen.dart';
import 'package:grocery_distributor/Common/utils.dart';
import 'package:grocery_distributor/ConstFile/constPreferences.dart';
import 'package:grocery_distributor/Controllers/home_controller.dart';
import 'package:grocery_distributor/Controllers/login_controller.dart';
import 'package:grocery_distributor/Controllers/my_profile_controller.dart';
import 'package:grocery_distributor/Screens/home_screen.dart';
import 'package:grocery_distributor/Screens/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../ConstFile/constApi.dart';
import '../Model/login_model.dart';

LoginController loginController = Get.put(LoginController());
HomeController homeController = Get.put(HomeController());
MyProfileController myProfileController = Get.put(MyProfileController());


class Services{

  Future<void> DistributorLogin(String usersid,String pwd,context) async
  {

    final response = await http.post(
        Uri.parse(ConstApi.Login),
        body: {
          "UserId": usersid,
          "Password" : pwd
        });
    var data = response.body;
    debugPrint(data);

    if (response.statusCode == 200) {
      final loginData = loginFromJson(response.body);
      debugPrint(loginData.toString());
      var message = loginData.messageCode;
     
      if(message == 200){
        print(message);
        var Id = loginData.data[0].id;
        var Email = loginData.data[0].userId;
        var Name = loginData.data[0].name;
        var Address = loginData.data[0].address;
        var DImage = loginData.data[0].profileImage.toString();

        debugPrint("Distributor id"+ Id.toString());
        ConstPreferences().saveDistributorId("DistributorId",Id.toString());
        ConstPreferences().saveDistributorEmail("DistributorEmail",Email.toString());
        ConstPreferences().saveDistributorName("DistributorName",Name.toString());
        ConstPreferences().saveDistributorAddress("DistributorAdd",Address.toString());
        ConstPreferences().saveDistributorImage("DistributorImage",DImage.toString());
        myProfileController.getDistributorProfile();
        sendTokenCall();
        final SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool("login", true);
        // myProfileController.getDistributorProfile();
        Get.to(() => const HomeScreen());
        Get.to(() => BottomBarScreen(),arguments: {homeController.currentIndex = 0});

        // Get.to(()=> BottomAppBar(),arguments: 1);
      } else if(message == 202) {
        Utils().toastMessage("Company Distributor role is not yet supported");
      } else{
        Utils().toastMessage("Invalid Email & Password");
      }
    } else {
      return null;
    }
  }


  Future<void> sendTokenCall() async {
    String? distributorId = await ConstPreferences().getDistributorId('DistributorId');
    String? token = await ConstPreferences().getFcmToken();
    debugPrint("Distributor_Id  $distributorId");
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    final Map<String, dynamic> body = {
      "UserId": distributorId,
      "Token": token
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(ConstApi.sendToken),
        headers: headers,
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        debugPrint(response.body.toString());
        debugPrint('Response Token : ${response.body}');
      } else {
        // Handle unsuccessful login
        debugPrint('Response: ${response.body}');
      }
    } catch (e) {
      Utils().errorsnackBar("Error", e.toString());
      // Handle network or other errors
      debugPrint('Error during login: $e');
    }
  }




}