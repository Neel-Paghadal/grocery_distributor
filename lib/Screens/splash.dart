import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/ConstFile/constImage.dart';
import 'package:grocery_distributor/Screens/login_screen.dart';

import '../ConstFile/constColor.dart';
import '../ConstFile/constFonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () {

      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
      
    });
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
