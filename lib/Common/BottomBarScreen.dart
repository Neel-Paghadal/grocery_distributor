import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/ConstFile/constColor.dart';
import 'package:grocery_distributor/ConstFile/constFonts.dart';
import 'package:grocery_distributor/Controllers/home_controller.dart';
import 'package:grocery_distributor/Controllers/user_list_controller.dart';
import 'package:grocery_distributor/Screens/home_screen.dart';
import 'package:grocery_distributor/Screens/live_order.dart';
import 'package:grocery_distributor/Screens/order_details.dart';
import 'package:grocery_distributor/Screens/user_list.dart';


class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {

  HomeController homeController = Get.put(HomeController());
  // CartController cartController = Get.put(CartController());
  UserListController userListController = Get.put(UserListController());

  final screens = [HomeScreen(),LiveorderPage(),OrderdetailsPage(),UserPage()];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(

        currentIndex: homeController.currentIndex,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.black,

        selectedLabelStyle: TextStyle(
          fontFamily: ConstFont.popinsMedium,
          color: Colors.black, ),
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
              label: "Home",
              icon: Icon(CupertinoIcons.home,
                  color: homeController.currentIndex == 0
                      ? ConstColour.primaryColor
                      : Colors.black)
          ),
          BottomNavigationBarItem(
              label: "Order",
              icon: Icon(Icons.event_note_sharp,
                  color: homeController.currentIndex == 1
                      ? ConstColour.primaryColor
                      : Colors.black)),
          BottomNavigationBarItem(
              label: "Wallet",
              icon: SvgPicture.asset("assets/Icons/wallets.svg",color:  homeController.currentIndex  == 2
              ? ConstColour.primaryColor
                  : Colors.black
                 ),
              ),
              // icon: Icon(Icons.account_balance_wallet,
              //     color: homeController.currentIndex  == 2
              //         ? ConstColour.primaryColor
              //         : Colors.black)

          // ),
          BottomNavigationBarItem(
              // label: "Help",
              label: "User",
              icon: Icon(/*CupertinoIcons.question_circle_fill*/

              Icons.person,
                  color: homeController.currentIndex == 3
                      ? ConstColour.primaryColor
                      : Colors.black)),
        ],
        onTap: (value) {
          setState(() {
            homeController.currentIndex = value;
          });

          if(value == 1){
            homeController.orderType = 0;
          }

          if (value == 0) {
             homeController.LiveOrderApiCall();
             // homeController.AssignOrderApiCall(homeController.orderType.toString(), homeController.distributorId.toString());
          }
          if(value == 3){
            // userListController.UserListApiCall();

          }
        },
      ),
      body: WillPopScope(
        onWillPop: () async{
          SystemNavigator.pop();
          return false;
        },
        child: IndexedStack(
          index: homeController.currentIndex,
          children: screens,
        ),
      ),

    );
  }
}
