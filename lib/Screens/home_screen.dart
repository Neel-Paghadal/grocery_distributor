import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/Common/appBar.dart';
import 'package:grocery_distributor/ConstFile/constColor.dart';
import 'package:grocery_distributor/ConstFile/constFonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? selectedValueIndex = 1;

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ConstColour.bgColor,
      appBar: PreferredSize(
          preferredSize: Size(deviceWidth, deviceHeight),
          child: DetailsAppbar(
            title: "Dashboard",
            onTap: () {
              Get.back();
            },
          )),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  controller: ScrollController(),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: ConstColour.primaryColor),
                      width: deviceWidth * 1.0,
                      height: deviceHeight * 0.06,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: deviceWidth * 0.03,
                            right: deviceWidth * 0.03),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Wallet Balance",
                              style: TextStyle(
                                  fontFamily: ConstFont.popinsRegular,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                            Text(
                              "₹800",
                              style: TextStyle(
                                  fontFamily: ConstFont.popinsRegular,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top:
                            deviceHeight * 0.01, /*bottom: deviceHeight * 0.01*/
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Color(0xff81ECEC)),
                              height: deviceHeight * 0.06,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: deviceWidth * 0.04),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "15",
                                      style: TextStyle(
                                          fontFamily: ConstFont.popinsRegular,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      "Products",
                                      style: TextStyle(
                                          fontFamily: ConstFont.popinsRegular,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Color(0xffFEA47F)),
                              height: deviceHeight * 0.06,
                              child: Padding(
                                padding:
                                    EdgeInsets.only(left: deviceWidth * 0.04),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "2",
                                      style: TextStyle(
                                          fontFamily: ConstFont.popinsRegular,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      "Low Stock",
                                      style: TextStyle(
                                          fontFamily: ConstFont.popinsRegular,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Live Order",
                          style: TextStyle(
                            fontFamily: ConstFont.popinsRegular,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Show all",
                            style: TextStyle(
                              fontFamily: ConstFont.popinsRegular,
                              fontWeight: FontWeight.w600,
                              color: ConstColour.primaryColor,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: deviceWidth * 0.02, right: deviceWidth * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide.none,
                                    borderRadius: BorderRadius.circular(3)),
                                backgroundColor: selectedValueIndex == 1
                                    ? ConstColour.primaryColor
                                    : ConstColour.cardBgColor,
                                minimumSize: Size(
                                    deviceWidth * 0.18, deviceHeight * 0.03),
                                maximumSize: Size(
                                    deviceWidth * 0.20, deviceHeight * 0.03),
                                elevation: 0.5),
                            onPressed: () {
                              setState(() {
                                selectedValueIndex = 1;
                                print(selectedValueIndex);
                              });
                            },
                            child: Text(
                              "5-10 Min",
                              style: TextStyle(
                                  fontSize: 9,
                                  color: selectedValueIndex == 1
                                      ? Colors.black
                                      : Colors.black,
                                  fontFamily: ConstFont.popinsRegular),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide.none,
                                    borderRadius: BorderRadius.circular(3)),
                                backgroundColor: selectedValueIndex == 0
                                    ? ConstColour.primaryColor
                                    : ConstColour.cardBgColor,
                                minimumSize: Size(
                                    deviceWidth * 0.18, deviceHeight * 0.03),
                                maximumSize: Size(
                                    deviceWidth * 0.20, deviceHeight * 0.03),
                                elevation: 0.5),
                            onPressed: () {
                              setState(() {
                                selectedValueIndex = 0;
                                print(selectedValueIndex);
                              });
                            },
                            child: Text(
                              "24-48 Hr",
                              style: TextStyle(
                                  fontSize: 9,
                                  color: selectedValueIndex == 0
                                      ? Colors.black
                                      : Colors.black,
                                  fontFamily: ConstFont.popinsRegular),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide.none,
                                    borderRadius: BorderRadius.circular(3)),
                                backgroundColor: selectedValueIndex == 2
                                    ? ConstColour.primaryColor
                                    : ConstColour.cardBgColor,
                                minimumSize: Size(
                                    deviceWidth * 0.18, deviceHeight * 0.03),
                                maximumSize: Size(
                                    deviceWidth * 0.20, deviceHeight * 0.03),
                                elevation: 0.5),
                            onPressed: () {
                              setState(() {
                                selectedValueIndex = 2;
                                print(selectedValueIndex);
                              });
                            },
                            child: Text(
                              "Daily",
                              style: TextStyle(
                                  fontSize: 9,
                                  color: selectedValueIndex == 2
                                      ? Colors.black
                                      : Colors.black,
                                  fontFamily: ConstFont.popinsRegular),
                            ),
                          )
                        ],
                      ),
                    ),
                    ListView.builder(
                      controller: ScrollController(),
                      itemCount: 3,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            tileColor: ConstColour.cardBgColor,
                            leading: Container(
                              height: deviceHeight * 0.1,
                              width: deviceWidth * 0.2,
                              decoration: BoxDecoration(
                                color: ConstColour.primaryColor,
                                borderRadius: BorderRadius.circular(11)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Image.asset("assets/Images/FrenchBeans.png"),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
