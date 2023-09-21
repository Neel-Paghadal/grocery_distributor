import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/Common/bottom_button_widget.dart';
import 'package:grocery_distributor/ConstFile/constColor.dart';
import 'package:grocery_distributor/ConstFile/constFonts.dart';
import 'package:grocery_distributor/ConstFile/constImage.dart';
import 'package:grocery_distributor/Controllers/login_controller.dart';
import 'package:grocery_distributor/Screens/godown_stock.dart';
import 'package:grocery_distributor/Screens/home_screen.dart';
import 'package:grocery_distributor/api_services/all_services.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  LoginController loginController = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  var userId;
  var password;

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        bottomNavigationBar: BottomButton(
          onPressed: () {
            userId = loginController.emailController.text;
            password = loginController.passController.text;
            // Get.to(() => GodownPage());

            Services().DistributorLogin(userId, password,context);

          },
          btnName: "      Login",
        ),
        backgroundColor: ConstColour.bgColor,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: EdgeInsets.only(
                left: deviceWidth * 0.02, right: deviceWidth * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight * 0.1),
                  child: Center(child: SvgPicture.asset(ConstImage.login)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight * 0.08),
                  child: Text("Enter your ID and Password",
                      style: TextStyle(
                          fontFamily: ConstFont.popinsMedium,
                          fontWeight: FontWeight.w500,
                          fontSize: 20)),
                ),
                Divider(height: deviceHeight * 0.01, color: Colors.transparent),
                Text(
                    "We need to verify you. We will send you a one time verification code. ",
                    style: TextStyle(
                        fontFamily: ConstFont.popinsRegular,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: ConstColour.textPrimary)),
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight * 0.1),
                  child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: loginController.emailController,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.black)

                          ),
                          focusedBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide: BorderSide(color: Colors.black)
                          ),
                          isDense: true,
                          hintStyle: TextStyle(
                              fontFamily: ConstFont.popinsRegular,
                              fontWeight: FontWeight.w300,
                              fontSize: 15),
                          hintText: "Enter Your Email Id",
                          labelText: "Email Id"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email Id is required';
                        }
                        return null;
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight * 0.025),
                  child: TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: loginController.passController,
                      decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          isDense: true,
                          hintStyle: TextStyle(
                              fontFamily: ConstFont.popinsRegular,
                              fontWeight: FontWeight.w300,
                              fontSize: 15),
                          hintText: "Enter Your Password",
                          labelText: "Password"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
