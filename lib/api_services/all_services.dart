import 'package:flutter/material.dart';
import 'package:grocery_distributor/Screens/home_screen.dart';
import 'package:http/http.dart' as http;
import '../ConstFile/constApi.dart';
import '../Model/login_model.dart';





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
    print(data);

    if (response.statusCode == 200) {
      final loginData = loginFromJson(response.body);
      print(loginData);
      var message = loginData.messageCode;
     
      if(message  == 200){
        print(message );
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
        // Get.to(() => HomeScreen());
      }
    } else {
      return null;
    }
  }



}