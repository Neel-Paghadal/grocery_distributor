import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/ConstFile/constColor.dart';
import 'package:grocery_distributor/ConstFile/constFonts.dart';
import 'package:grocery_distributor/ConstFile/constPreferences.dart';
import 'package:grocery_distributor/Controllers/home_controller.dart';
import 'package:grocery_distributor/Controllers/my_profile_controller.dart';
import 'package:grocery_distributor/Screens/order_genrate.dart';
import '../Common/BottomBarScreen.dart';
import 'godown_stock.dart';
import 'live_order.dart';
import 'login_screen.dart';
import 'low_stock.dart';
import 'myProfile_screen.dart';
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
  MyProfileController myProfileController = Get.put(MyProfileController());

  String? distributorId;
  String? distributorEmail;
  String? distributorName;

  getDistributorData() async {
   distributorId = await ConstPreferences().getDistributorId("DistributorId");
   distributorEmail = await ConstPreferences().getDistributorEmail("DistributorEmail");
   distributorName = await ConstPreferences().getDistributorName("DistributorName");
 }

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.getDistributorData();

 }

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
                      child: InkWell(
                        onTap: () {
                        Get.to(()=>const MyProfileScreen() );
                        },
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
                                        minVerticalPadding: deviceHeight * 0.03,
                                        // leading: Image.asset("assets/Images/man.png"),
                                        leading: (myProfileController.userProfileImage == null ||
                                            myProfileController.userProfileImage!.isEmpty)
                                            ? Image.asset(
                                          'assets/Images/mans.png',
                                          width: deviceWidth * 0.2,
                                        )
                                            : CircleAvatar(
                                          radius: 25,
                                          backgroundImage: NetworkImage(
                                              myProfileController.userProfileImage!.toString()),
                                        ),
                                        // leading: Image.network(homeController.distributorImage.toString(),width: deviceWidth * 0.1,height: deviceHeight * 0.05),
                                        title: Padding(
                                          padding:  EdgeInsets.only(bottom: deviceHeight * 0.005),
                                          child:  Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                homeController.distributorName.toString(),
                                                style:
                                                const TextStyle(fontSize: 14, color: Colors.black),
                                                overflow: TextOverflow.ellipsis,
                                              ),Text(
                                                homeController.distributorEmail.toString(),
                                                style:
                                                const TextStyle(fontSize: 14, color: Colors.black),maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),

                                        subtitle:  Text(homeController.distributorAddress.toString(),
                                          style: const TextStyle(fontSize: 12, color: Colors.black),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: deviceHeight * 0.02),
                    ListTile(
                      splashColor: Colors.black,
                      leading: SvgPicture.asset("assets/Icons/orders.svg"),
                      onTap: () {
                        setState(() {
                          Get.to(() => const LiveorderPage());
                          Get.to(() => const BottomBarScreen(),arguments: {homeController.currentIndex = 1});
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

                      leading: SvgPicture.asset("assets/Icons/userlist.svg"),
                      onTap: () {
                        Get.to(() => const UserPage());
                        Get.to(() => const BottomBarScreen(),arguments: {homeController.currentIndex = 3});

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

                      leading: SvgPicture.asset("assets/Icons/stock.svg"),
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

                      leading: SvgPicture.asset("assets/Icons/product.svg"),
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

            leading: const Icon(Icons.shopping_cart_outlined, color: ConstColour.primaryColor),
            onTap: () {

        Get.to(() => const OrderGenrate());
            },
            title: const Text(
              "Genrate Order",
              style: TextStyle(
                fontSize: 15,
                fontFamily: ConstFont.popinsRegular,
                color: Colors.black,
              ),
            ),
          ),
                    ListTile(
                      splashColor: ConstColour.btnHowerColor,

                      leading: SvgPicture.asset("assets/Icons/lowstock.svg"),
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

                      leading: SvgPicture.asset("assets/Icons/ads.svg"),
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
                      leading: const Icon(
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
  }
}