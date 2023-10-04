
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/ConstFile/constColor.dart';
import 'package:grocery_distributor/ConstFile/constFonts.dart';
import 'package:grocery_distributor/ConstFile/constPreferences.dart';
import 'package:grocery_distributor/Controllers/home_controller.dart';
import 'package:grocery_distributor/Model/liveorder_model.dart';

import '../Common/BottomBarScreen.dart';
import 'godown_stock.dart';
import 'live_order.dart';
import 'login_screen.dart';
import 'low_stock.dart';
import 'user_list.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({
    super.key,
  });

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  HomeController homeController = Get.put(HomeController());



  @override
  Widget build(BuildContext context) {

    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

   return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
                    Padding(
                      padding:  EdgeInsets.only(top: deviceHeight * 0.06,bottom: deviceHeight * 0.02),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffF3F4F4),
                            borderRadius: BorderRadius.circular(5)),
                        // width: 254,
                        // height: 75,
                        margin: EdgeInsets.only(
                            left: deviceWidth * 0.05, right: deviceWidth * 0.05),
                        //color: Color(0xffF3F4F4),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Image.asset("assets/Images/drawerdp.png"),
                                      title: const Text(
                                        "Vidya Vox",
                                        style:
                                        TextStyle(fontSize: 14, color: Colors.black),
                                      ),
                                      subtitle: const Text(
                                        "236, Tulsi Arcade, Sudama\nChowk, Surat.",
                                        style:
                                        TextStyle(fontSize: 10, color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: deviceHeight * 0.02),
                    ListTile(
                      splashColor: Colors.black,
                      leading: Image.asset("assets/Icons/order.png"),
                      onTap: () {
                        setState(() {
                          Get.to(() => LiveorderPage());
                          Get.to(() => BottomBarScreen(),arguments: {homeController.currentIndex = 1});
                        });
                      },
                      title: const Text(
                        "Live Orders",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: ConstFont.popinsRegular,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ListTile(
                      splashColor: ConstColour.btnHowerColor,

                      leading: Image.asset("assets/Icons/user.png"),
                      onTap: () {
                        Get.to(() => UserPage());
                        Get.to(() => BottomBarScreen(),arguments: {homeController.currentIndex = 3});

                      },
                      title: const Text(
                        "User List",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: ConstFont.popinsRegular,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ListTile(
                      splashColor: ConstColour.btnHowerColor,

                      leading: Image.asset("assets/Icons/godowan.png"),
                      onTap: () {
                        Get.to(const GodownPage());
                      },
                      title: const Text(
                        "Godown Stock",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: ConstFont.popinsRegular,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ListTile(
                      splashColor: ConstColour.btnHowerColor,

                      leading: Image.asset("assets/Icons/product.png"),
                      onTap: () {},
                      title: const Text(
                        "Product Info",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: ConstFont.popinsRegular,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ListTile(
                      splashColor: ConstColour.btnHowerColor,

                      leading: Image.asset("assets/Icons/low.png"),
                      onTap: () {
                        Get.to(const lowstockPage());
                      },
                      title: const Text(
                        "Low Stock",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: ConstFont.popinsRegular,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ListTile(
                      splashColor: ConstColour.btnHowerColor,

                      leading: Image.asset("assets/Icons/ads.png"),
                      onTap: () {},
                      title: const Text(
                        "Ads",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: ConstFont.popinsRegular,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ListTile(
                      splashColor: ConstColour.btnHowerColor,
                      leading: Icon(
                        Icons.login_outlined,
                        color: ConstColour.primaryColor,
                      ),
                      onTap: () {
                        ConstPreferences().clearPreferences();
                        Get.to(() => LoginScreen());
                      },
                      title: const Text(
                        "Log Out",
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: ConstFont.popinsRegular,
                          color: Colors.black,
                        ),
                      ),
                    ),
        ],
      ),
    );
    //
    // return Dra/**/wer(
    //   child: Container(
    //     color: Colors.white,
    //     child: Padding(
    //       padding: EdgeInsets.only(
    //           left: deviceWidth * 0.00,
    //           right: deviceWidth * 0.00,
    //           top: deviceHeight * 0.04),
    //       child: Column(
    //         children: [
    //           Container(
    //             decoration: BoxDecoration(
    //                 color: const Color(0xffF3F4F4),
    //                 borderRadius: BorderRadius.circular(5)),
    //             // width: 254,
    //             // height: 75,
    //             margin: EdgeInsets.only(
    //                 left: deviceWidth * 0.05, right: deviceWidth * 0.05),
    //             //color: Color(0xffF3F4F4),
    //             child: Row(
    //               children: [
    //                 Expanded(
    //                     child: Column(
    //                       children: [
    //                         ListTile(
    //                           leading: Image.asset("assets/Images/drawerdp.png"),
    //                           title: const Text(
    //                             "Vidya Vox",
    //                             style:
    //                             TextStyle(fontSize: 14, color: Colors.black),
    //                           ),
    //                           subtitle: const Text(
    //                             "236, Tulsi Arcade, Sudama\nChowk, Surat.",
    //                             style:
    //                             TextStyle(fontSize: 10, color: Colors.black),
    //                           ),
    //                         ),
    //                       ],
    //                     ))
    //               ],
    //             ),
    //           ),
    //           SizedBox(height: deviceHeight * 0.02),
    //           ListTile(
    //             splashColor: Colors.black,
    //             leading: Image.asset("assets/Icons/order.png"),
    //             onTap: () {
    //               setState(() {
    //                 Get.to(() => BottomBarScreen(),arguments: {homeController.currentIndex = 1});
    //               });
    //             },
    //             title: const Text(
    //               "Live Orders",
    //               style: TextStyle(
    //                 fontSize: 15,
    //                 fontFamily: ConstFont.popinsRegular,
    //                 color: Colors.black,
    //               ),
    //             ),
    //           ),
    //           ListTile(
    //             splashColor: ConstColour.btnHowerColor,
    //
    //             leading: Image.asset("assets/Icons/user.png"),
    //             onTap: () {
    //               Get.to(() => BottomBarScreen(),arguments: {homeController.currentIndex = 3});
    //
    //             },
    //             title: const Text(
    //               "User List",
    //               style: TextStyle(
    //                 fontSize: 15,
    //                 fontFamily: ConstFont.popinsRegular,
    //                 color: Colors.black,
    //               ),
    //             ),
    //           ),
    //           ListTile(
    //             splashColor: ConstColour.btnHowerColor,
    //
    //             leading: Image.asset("assets/Icons/godowan.png"),
    //             onTap: () {
    //               Get.to(const GodownPage());
    //             },
    //             title: const Text(
    //               "Godown Stock",
    //               style: TextStyle(
    //                 fontSize: 15,
    //                 fontFamily: ConstFont.popinsRegular,
    //                 color: Colors.black,
    //               ),
    //             ),
    //           ),
    //           ListTile(
    //             splashColor: ConstColour.btnHowerColor,
    //
    //             leading: Image.asset("assets/Icons/product.png"),
    //             onTap: () {},
    //             title: const Text(
    //               "Product Info",
    //               style: TextStyle(
    //                 fontSize: 15,
    //                 fontFamily: ConstFont.popinsRegular,
    //                 color: Colors.black,
    //               ),
    //             ),
    //           ),
    //           ListTile(
    //             splashColor: ConstColour.btnHowerColor,
    //
    //             leading: Image.asset("assets/Icons/low.png"),
    //             onTap: () {
    //               Get.to(const lowstockPage());
    //             },
    //             title: const Text(
    //               "Low Stock",
    //               style: TextStyle(
    //                 fontSize: 15,
    //                 fontFamily: ConstFont.popinsRegular,
    //                 color: Colors.black,
    //               ),
    //             ),
    //           ),
    //           ListTile(
    //             splashColor: ConstColour.btnHowerColor,
    //
    //             leading: Image.asset("assets/Icons/ads.png"),
    //             onTap: () {},
    //             title: const Text(
    //               "Ads",
    //               style: TextStyle(
    //                 fontSize: 15,
    //                 fontFamily: ConstFont.popinsRegular,
    //                 color: Colors.black,
    //               ),
    //             ),
    //           ),
    //           ListTile(
    //             splashColor: ConstColour.btnHowerColor,
    //             leading: Icon(
    //               Icons.login_outlined,
    //               color: ConstColour.primaryColor,
    //             ),
    //             onTap: () {
    //               ConstPreferences().clearPreferences();
    //               Get.to(() => LoginScreen());
    //             },
    //             title: const Text(
    //               "Log Out",
    //               style: TextStyle(
    //                 fontSize: 15,
    //                 fontFamily: ConstFont.popinsRegular,
    //                 color: Colors.black,
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}