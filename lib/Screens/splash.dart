import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/Common/BottomBarScreen.dart';
import 'package:grocery_distributor/ConstFile/constImage.dart';
import 'package:grocery_distributor/Screens/home_screen.dart';
import 'package:grocery_distributor/Screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ConstFile/constColor.dart';
import '../ConstFile/constFonts.dart';
import '../Controllers/home_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  HomeController homeController = Get.put(HomeController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4), () {
      checkPref();
      // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
      
    });
  }

  checkPref() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool("login") == true) {

      Get.to(() => BottomBarScreen(),arguments: {homeController.currentIndex = 0});
      // Get.to(() => const HomeScreen());
      setState(() {
      });

    } else {
      Get.to(() =>  LoginScreen());
    }
  }




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: ConstColour.bgColor,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Center(child: SvgPicture.asset(ConstImage.splash)),
        ],
      ),
    );
  }
}
