import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/ConstFile/constColor.dart';
import 'package:grocery_distributor/ConstFile/constFonts.dart';
import 'package:grocery_distributor/Screens/loader.dart';
import 'package:grocery_distributor/Screens/product_detail.dart';

import '../Controllers/userOrderHistory_controller.dart';


class StickyColors {
  static final List colors = [
    const Color(0xffF1F7E6),
    const Color(0xffF4F5F0),
    const Color(0xffF2DAC1),
    const Color(0xffF8EEEC),
    const Color(0xffFFF7E7),
    const Color(0xffEDF4FA),
    const Color(0xffFBFBF9),
    const Color(0xffEEE8E6),
    const Color(0xffFFF2D0),
    const Color(0xffE6DBAC),
    const Color(0xffEDE8BA),
    const Color(0xffFDEFB2),
    const Color(0xffF8F8E8),
    const Color(0xffF2F7FD),
    const Color(0xffFDEFB2),
    const Color(0xffFEC5E5),
  ];
}

class UserOrderHistory extends StatefulWidget {
  const UserOrderHistory({super.key});

  @override
  State<UserOrderHistory> createState() => _UserOrderHistoryState();
}

class _UserOrderHistoryState extends State<UserOrderHistory> {

  UserOrderHistoryController userOrderHistoryController = Get.put(UserOrderHistoryController());

  final formkey = GlobalKey<FormState>();
  List<int> SelectedValueIndex = [1, 2, 3, 4, 5];



  final _random = Random();
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.black),

        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title:  const Text("Order History",
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontFamily: ConstFont.popinsMedium),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
      ),
      body: FutureBuilder<dynamic>(
        future: userOrderHistoryController.UserOrderListApiCall(userOrderHistoryController.customerId.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display shimmer while waiting for data
            return Loaders(
              items: 10,
              direction: LoaderDirection.ltr,
              builder: Padding(
                padding: EdgeInsets.only(right: deviceWidth * 0.01),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: deviceWidth * 0.018),
                              child: const Icon(
                                Icons.image,
                                size: 80,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: deviceHeight * 0.01,
                                  left: deviceWidth * 0.02),
                              child: Container(
                                color: Colors.grey,
                                width: deviceWidth * 0.6,
                                height: deviceHeight * 0.01,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: deviceHeight * 0.02,
                                  left: deviceWidth * 0.02),
                              child: Container(
                                color: Colors.grey,
                                width: deviceWidth * 0.6,
                                height: deviceHeight * 0.01,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: deviceHeight * 0.02,
                                  left: deviceWidth * 0.02,
                                  bottom: deviceHeight * 0.02),
                              child: Container(
                                color: Colors.grey,
                                width: deviceWidth * 0.6,
                                height: deviceHeight * 0.01,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            // Handle error
            return Center(child: Text('Error: ${snapshot.error}',style: TextStyle(color: Colors.black,fontFamily: ConstFont.popinsRegular,fontSize: 18,overflow: TextOverflow.ellipsis,),));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            // Display "No data available" message
            return Center(child: Text('No data available',style: TextStyle(color: Colors.black,fontFamily: ConstFont.popinsRegular,fontSize: 18,overflow: TextOverflow.ellipsis,)));
          } else if (snapshot.hasData) {
            // Display the fetched data
            return Obx(
                  () =>  ListView.builder(
                controller: ScrollController(),
                scrollDirection: Axis.vertical,
                itemCount: userOrderHistoryController.userOrderHistory.length > 10 ? 10
                    : userOrderHistoryController.userOrderHistory.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                      color: ConstColour.cardBgColor,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: deviceWidth * 0.01,
                            bottom: deviceHeight * 0.01,
                            right: deviceWidth * 0.01,
                            top: deviceHeight * 0.01),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              //mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: StickyColors
                                        .colors[_random.nextInt(15)],
                                  ),
                                  height: 60,
                                  width: 72,
                                  child: Image.network(userOrderHistoryController.userOrderHistory[index].imageName.toString()),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Padding(
                                            padding:  EdgeInsets.only(left: deviceWidth * 0.02),
                                            child: Container(
                                              width: deviceWidth * 0.45,
                                              child: Text(
                                                userOrderHistoryController.userOrderHistory[index].productName,
                                                overflow: TextOverflow
                                                    .ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: ConstFont
                                                        .popinsRegular,
                                                    color: Colors.black,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceAround,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left:
                                                    deviceHeight *
                                                        0.01,
                                                    right:
                                                    deviceHeight *
                                                        0.01),
                                                child: Row(
                                                  children: [
                                                    const Text("Quantity : "
                                                      ,
                                                      style:
                                                      TextStyle(
                                                        fontSize: 12,
                                                        //fontWeight: FontWeight.bold,
                                                        fontFamily: ConstFont
                                                            .popinsRegular,
                                                        color:
                                                        Colors.black,
                                                      ),
                                                    ),Text(
                                                      userOrderHistoryController.userOrderHistory[index].quantity.toString(),
                                                      style:
                                                      const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: ConstFont
                                                            .popinsMedium,

                                                        color:
                                                        Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: deviceWidth * 0.01),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:  EdgeInsets.only(bottom: deviceHeight * 0.005),
                                              child: Text(
                                                " ${userOrderHistoryController.userOrderHistory[index].unit}",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: ConstFont
                                                        .popinsRegular,
                                                    color:
                                                    Colors.black),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,

                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: deviceWidth *
                                                          0.01),
                                                  child: Text(
                                                    "₹ ${userOrderHistoryController.userOrderHistory[index].offerPrice}",
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                        FontWeight
                                                            .w700,
                                                        fontFamily: ConstFont
                                                            .popinsRegular,
                                                        color:
                                                        Colors.black),
                                                  ),
                                                ),

                                                // change

                                                userOrderHistoryController.userOrderHistory[index].orderStatus == 0  ?
                                                Padding(

                                                  padding: EdgeInsets.only(
                                                    left: deviceWidth * 0.01,),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            left: deviceWidth *
                                                                0.01),
                                                        child:
                                                        Container(
                                                          height:  25,
                                                          width: 90,
                                                          decoration:
                                                          BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(1),
                                                          ),
                                                          child:
                                                          Center(
                                                            child:
                                                            ElevatedButton(
                                                              style:
                                                              ElevatedButton.styleFrom(
                                                                backgroundColor: const Color(0xff6AB04C),
                                                              ),
                                                              onPressed:
                                                                  () {

                                                              },
                                                              child:
                                                              Text("Accept",style:TextStyle(
                                                                fontFamily: ConstFont.popinsRegular,
                                                                color: SelectedValueIndex == 1 ? Colors.black : Colors.white,
                                                                //color: Colors.white
                                                              ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            left: deviceWidth *
                                                                0.01,
                                                            right: deviceWidth *
                                                                0.01),
                                                        child:
                                                        Container(
                                                          height:
                                                          25,
                                                          width: 75,
                                                          decoration:
                                                          BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(1),
                                                          ),
                                                          child:
                                                          Center(
                                                            child:
                                                            ElevatedButton(
                                                              style:
                                                              ElevatedButton.styleFrom(backgroundColor: const Color(0xffF86C6B)),
                                                              onPressed:
                                                                  () {},
                                                              child:
                                                              InkWell(
                                                                onTap:
                                                                    () async {

                                                                },
                                                                child:
                                                                const Text(
                                                                  "Reject",
                                                                  style: TextStyle(fontFamily: ConstFont.popinsRegular, color: Colors.white),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                                    :
                                                (userOrderHistoryController.userOrderHistory[index].orderStatus !=  3 && userOrderHistoryController.userOrderHistory[index].orderStatus != 4)
                                                    ? Padding(
                                                  padding: EdgeInsets.only( left:deviceWidth *  0.01,),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        EdgeInsets.only(left: deviceWidth * 0.01),
                                                        child: Container(
                                                          height:25,
                                                          width: deviceWidth * 0.21,
                                                          decoration:
                                                          BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius.circular(1),
                                                          ),
                                                          child:
                                                          Center(
                                                            child:
                                                            ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                backgroundColor: const Color(0xff6AB04C),
                                                              ),
                                                              onPressed: () {

                                                              },
                                                              child: Text(
                                                                "Delivered",
                                                                style: TextStyle(
                                                                  fontFamily: ConstFont.popinsRegular,
                                                                  fontSize: 10,
                                                                  color: SelectedValueIndex == 1 ? Colors.black : Colors.white,
                                                                  //color: Colors.white
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height:
                                                        deviceHeight * 0.03,
                                                        width:
                                                        deviceWidth * 0.26,
                                                        decoration:
                                                        BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius.circular(1),
                                                        ),
                                                        child:
                                                        Center(
                                                          child:
                                                          ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                              // primary: const Color(0xffF86C6B)
                                                                backgroundColor: Colors.white
                                                            ),

                                                            onPressed: () {},
                                                            child: InkWell(
                                                              onTap: () async {

                                                              },
                                                              child: const Text(
                                                                "Not Delivered",
                                                                style: TextStyle(fontFamily: ConstFont.popinsMedium, color: Colors.red,
                                                                  fontSize: 10,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                                    : Text(
                                                  (userOrderHistoryController.userOrderHistory[index].orderStatus == 3)
                                                      ? "Delivered"
                                                      : "Not Delivered",
                                                  style: TextStyle(
                                                    color: (userOrderHistoryController.userOrderHistory[index].orderStatus == 2 || userOrderHistoryController.userOrderHistory[index].orderStatus == 4 )  ? Colors.red : Colors.green,fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ));
                },
              ),
            );
          } else {
            // This is a fallback in case something unexpected happens
            return Center(child: Text('Unexpected error',style: TextStyle(color: Colors.black,fontFamily: ConstFont.popinsRegular,fontSize: 18,overflow: TextOverflow.ellipsis,)));
          }
        },
      ),
    );
  }
}
