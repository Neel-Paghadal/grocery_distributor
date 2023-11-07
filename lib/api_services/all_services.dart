import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/Common/utils.dart';
import 'package:grocery_distributor/ConstFile/constPreferences.dart';
import 'package:grocery_distributor/Controllers/login_controller.dart';
import 'package:grocery_distributor/Screens/home_screen.dart';
import 'package:grocery_distributor/Screens/login_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../ConstFile/constApi.dart';
import '../Model/login_model.dart';

LoginController loginController = Get.put(LoginController());

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
        print(message );
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
        final SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool("login", true);
        Get.to(() => HomeScreen());
        // Get.to(()=> BottomAppBar(),arguments: 1);
      }else{
        Utils().toastMessage("Invalid Email & Password");

      }
    } else {
      return null;
    }
  }





}