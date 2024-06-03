import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grocery_distributor/Common/BottomBarScreen.dart';
import 'package:grocery_distributor/Common/utils.dart';
import 'package:grocery_distributor/Controllers/my_profile_controller.dart';
import 'package:grocery_distributor/Model/assignorder_model.dart';
import 'package:grocery_distributor/Model/liveorder_model.dart';
import 'package:grocery_distributor/Screens/home_screen.dart';
import 'package:grocery_distributor/api_services/all_services.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../ConstFile/constApi.dart';
import '../ConstFile/constColor.dart';
import '../ConstFile/constFonts.dart';
import '../ConstFile/constPreferences.dart';

MyProfileController myProfileController = Get.put(MyProfileController());

class HomeController extends GetxController {
  int? messageCode;
  int? orderType = 1;
  String distributorId = "1";
  int currentIndex = 0;
  int? OrderStatus;
  TextEditingController reasonController = TextEditingController();
  RxList<LiveOrders> liveOrderList = <LiveOrders>[].obs;
  RxList<OrderList> assignOrderList = <OrderList>[].obs;
  RxBool isChange = false.obs;
  RxBool isFilterApplyed = false.obs;
  RxBool isListEmplty = false.obs;

  String? distributorEmail;
  String? distributorName;
  String? distributorAddress;
  String? distributorImage;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDistributorData();
    myProfileController.UserDetailApi();
    myProfileController.getPrefData();
    currentIndex = 0;
  }

  getDistributorData() async {
    distributorEmail =
        await ConstPreferences().getDistributorEmail("DistributorEmail");
    distributorName =
        await ConstPreferences().getDistributorName("DistributorName");
    distributorAddress =
        await ConstPreferences().getDistributorAddress("DistributorAdd");
    distributorImage =
        await ConstPreferences().getDistributorImage("DistributorImage");
    debugPrint("*****************" + distributorImage.toString());
  }

  String formatPrice(double price) {
    if (price % 1 == 0) {
      return price.toStringAsFixed(0);
    } else {
      return price.toStringAsFixed(2);
    }
  }

  String removeDecimalValue(String input) {
    List<String> parts = input.split(", ");
    for (int i = 0; i < parts.length; i++) {
      if (parts[i].contains(".")) {
        parts[i] = parts[i].split(".")[0] + " " + parts[i].split(" ")[1];
      }
    }
    return parts.join(", ");
  }

  Future<void> LiveOrderApiCall() async {
    final response = await http.get(
      Uri.parse(ConstApi.liveOrderFilter),
    );
    var data = response.body;
    debugPrint("filter List : " + data);

    if (response.statusCode == 200) {
      final responseData = liveOrderFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint("LiveOrder : " + messageCode.toString());

      if (messageCode == 200) {
        liveOrderList.clear();
        liveOrderList.addAll(responseData.data);
        // AssignOrderApiCall(orderType.toString(),distributorId);
        debugPrint("LiveOrder Successfully");
      } else {
        debugPrint("Error LiveOrder");
      }
    } else {}
  }

  AssignOrderApiCall(String type, String distributorId) async {
    String? distributorId =
        await ConstPreferences().getDistributorId("DistributorId");
    final response = await http.post(Uri.parse(ConstApi.assignOrder), body: {
      "LiveOrderType": type,
      "DistriButerId": distributorId,
    });
    var data = response.body;
    debugPrint("Assign order List : " + data);

    if (response.statusCode == 200) {
      final responseData = assignOrderFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint("LiveOrder : " + messageCode.toString());

      if (messageCode == 200) {
        assignOrderList.clear();
        assignOrderList.addAll(responseData.data);
        if (assignOrderList.isEmpty) {
          isListEmplty = true.obs;
        } else {
          isListEmplty = false.obs;
        }
        debugPrint("Assign order Successfully");
        // showAlarmDialog("context", 0);
        return assignOrderList;
      } else {
        debugPrint("Error Assign order");
      }
    } else {}
  }

  Future<void> OrderUpdateApiCall(
      String orderStatusId, String orderid, String reason) async {
    String? distributorId =
        await ConstPreferences().getDistributorId("DistributorId");
    final response =
        await http.post(Uri.parse(ConstApi.updateOrderStatus), body: {
      "OrderID": orderid,
      "OrderStatusID": orderStatusId,
      "UserId": distributorId,
      "Remarks": reason
    });
    var data = response.body;
    debugPrint("order update : " + data);

    if (response.statusCode == 200) {
      debugPrint("order update : " + messageCode.toString());
      if (messageCode == 200) {
        debugPrint("order update Successfully");
        Utils().toastMessage("Order Updated");
      } else {
        debugPrint("Error Assign order");
      }
    } else {}
  }

  Future<void> getProductFilterApiCall(
      int orderType, String toDate, String fromDate, String type) async {
    String? distributorId =
        await ConstPreferences().getDistributorId("DistributorId");
    debugPrint(distributorId);
    final response =
        await http.post(Uri.parse(ConstApi.getProdectFilterWise), body: {
      "PageSize": "100",
      "PageIndex": "0",
      "Keyword": "",
      "FromDate": fromDate.toString(),
      "ToDate": toDate.toString(),
      "OrderStatus": orderType.toString(),
      "DistriButerId": distributorId,
      "LiveOrderType": type
    });
    var data = response.body;
    debugPrint("Assign order List : " + data);

    if (response.statusCode == 200) {
      final responseData = assignOrderFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint("LiveOrder Filter Product : " + messageCode.toString());

      if (messageCode == 200) {
        assignOrderList.clear();
        assignOrderList.addAll(responseData.data);
        if (assignOrderList.isEmpty) {
          isListEmplty = true.obs;
        } else {
          isListEmplty = false.obs;
        }

        debugPrint("Filter Product Successfully");
        // return assignOrderList;
      } else {
        debugPrint("Error Filter Product order");
      }
    } else {}
  }


  final AudioPlayer audioPlayer = AudioPlayer();
  Future<void> playAlarmTone() async {
    await audioPlayer.play(AssetSource('sounds/ringtone.mp3'));
    // audioPlayer = await audioCache.play('sounds/ringtone.mp3');
  }
  final _random = Random();

  Future<void> showAlarmDialog(
      /*String title, String body, *//*int index*/
      {required String title, required String body, required int index}) async {
    await playAlarmTone();
    Timer(Duration(seconds: 30), () {
      audioPlayer.stop();
      Get.back();
    });

    var deviceHeight = MediaQuery.of(Get.context!).size.height;
    var deviceWidth = MediaQuery.of(Get.context!).size.width;

    // AudioPlayer player = AudioPlayer();
    // await audioPlayer.play(AssetSource('assets/sounds/ringtone.mp3'));
    Get.dialog(
      useSafeArea: true,
      barrierDismissible: false,
        Dialog(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
                side: BorderSide(color: ConstColour.primaryColor,width: 3)
            ),
            backgroundColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight * 0.02),
                  child: Container(
                    decoration: BoxDecoration(
                      color: StickyColors.colors[_random.nextInt(15)],
                    ),
                    height: deviceHeight * 0.15,
                    width: deviceWidth * 0.4,
                    child: CachedNetworkImage(
                      width: deviceWidth * 0.1,
                      imageUrl: homeController.assignOrderList[index].imageName.toString(),
                      placeholder: (context, url) => const Icon(Icons.image, size: 45),
                      errorWidget: (context, url, error) => const Icon(Icons.error, size: 45),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight * 0.03),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: deviceWidth * 0.02),
                        child: Text(/*title,*/
                          homeController.assignOrderList[index].productName,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: ConstFont.popinsRegular,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: deviceWidth * 0.02,),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                                "assets/Icons/pin.png",
                                width: deviceWidth * 0.04),
                            Expanded(
                              child: Text(
                                " " +
                                    homeController.assignOrderList[index].address.toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: const TextStyle(
                                    letterSpacing: 1.0,
                                    fontSize: 10,
                                    fontFamily: ConstFont.popinsRegular,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: deviceWidth * 0.02,top: deviceHeight * 0.01),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Quantity : ",
                              style: const TextStyle(
                                fontSize: 14,
                                //fontWeight: FontWeight.bold,
                                fontFamily: ConstFont.popinsRegular,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              homeController.assignOrderList[index].quantity.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                // fontWeight: FontWeight.bold,
                                fontFamily: ConstFont.popinsMedium,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: deviceWidth * 0.02),
                        child: Text(
                          " " +
                              homeController.removeDecimalValue(homeController.assignOrderList[index].unitType.toString()),
                          style: const TextStyle(
                              fontSize: 12,
                              fontFamily: ConstFont.popinsRegular,
                              color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: deviceWidth * 0.02),
                        child: Text(
                          "₹ " +
                              homeController.formatPrice(homeController.assignOrderList[index].totalAmount),
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              fontFamily: ConstFont.popinsRegular,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.005),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff6AB04C)),
                        onPressed: () {
                          // assignOrderList[index].orderStatus = 1;
                          // OrderUpdateApiCall("1", assignOrderList[index].detailId.toString(), "");
                          // Navigator.pop(context);
                          // player.stop();
                          audioPlayer.stop();
                          Get.back();
                          // Get.to(() => HomeScreen());
                          // Get.to(() => BottomBarScreen(), arguments: homeController.currentIndex = 0);
                          // Get.back();
                        },
                        child: const Text(
                          "Accept",
                          style: TextStyle(color: ConstColour.bgColor),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffF86C6B)),
                          onPressed: () {
                            // Navigator.pop(context);
                            // player.stop();
                            audioPlayer.stop();
                            Get.back();
                          },
                          child: const Text(
                            "Reject",
                            style: TextStyle(color: ConstColour.bgColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
        )
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.dispose();
  }

    /*showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title ?? ""),
          content: Text(body ?? ""),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff6AB04C)),
              onPressed: () {
                *//*assignOrderList[index].orderStatus = 1;
                OrderUpdateApiCall("1", assignOrderList[index].detailId.toString(), "");*//*
                Navigator.pop(context);
                // player.stop();
              },
              child: const Text(
                "Accept",
                style: TextStyle(color: ConstColour.bgColor),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffF86C6B)),
              onPressed: () {
                Navigator.pop(context);
                // player.stop();
              },
              child: const Text(
                "Reject",
                style: TextStyle(color: ConstColour.bgColor),
              ),
            ),
          ],
        );
      },
    );
    Future.delayed(Duration(seconds: 30), () {
      // player.stop();
      // if (Navigator.canPop(context)) {
      //   audioPlayer.stop(); // Stop the ringtone
      //   Navigator.pop(context); // Dismiss the dialog
      // }
    });
  }*/
}
