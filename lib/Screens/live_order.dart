import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery_distributor/Screens/order_details.dart';
import 'package:intl/intl.dart';

import '../Common/BottomBarScreen.dart';
import '../ConstFile/constColor.dart';
import '../ConstFile/constFonts.dart';
import '../Controllers/home_controller.dart';
import 'home_screen.dart';
import 'loader.dart';

class LiveorderPage extends StatefulWidget {
  const LiveorderPage({Key? key}) : super(key: key);

  @override
  State<LiveorderPage> createState() => _LiveorderPageState();
}

class _LiveorderPageState extends State<LiveorderPage> {


  int? selectedValueIndex = 0;
  DateTime _selectedDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  String? selectedDateForBackedDeveloprt;

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  var startdate = DateTime.now()
      .add(Duration(
          hours: -TimeOfDay.now().hour, minutes: -TimeOfDay.now().minute))
      .millisecondsSinceEpoch
      .obs;
  DateTime now = DateTime.now();
  var enddate =
      DateTime.now().add(Duration(hours: 1)).millisecondsSinceEpoch.obs;

  HomeController homeController = Get.put(HomeController());
  final _random = Random();
  final formkey = GlobalKey<FormState>();
  List<int> SelectedValueIndex = [1, 2, 3, 4, 5];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.orderType = 0;
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context)
        //         .push(MaterialPageRoute(builder: (context) => HomeScreen()));
        //   },
        //   icon: Icon(
        //     Icons.arrow_back_ios,
        //     color: Colors.black,
        //   ),
        // ),
        automaticallyImplyLeading: false,
        actions: [Image.asset("assets/Icons/notification.png")],
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Live Order",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Color(0xffF3F4F4),
                    borderRadius: BorderRadius.circular(5)),
                margin: EdgeInsets.only(
                    left: deviceWidth * 0.02, right: deviceWidth * 0.02),
                child: Row(
                  children: [
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.only(
                          left: deviceWidth * 0.03,
                          top: deviceWidth * 0.02,
                          bottom: deviceWidth * 0.02),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Date Range",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    final DateTime? pickedDate =
                                        await showDatePicker(
                                      context: Get.context!,
                                      initialDate: _startDate,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime.now(),
                                    );
                                    if (pickedDate != null) {
                                      startdate.value =
                                          pickedDate.millisecondsSinceEpoch;
                                      setState(() {
                                        _startDate = pickedDate;
                                        endDate = startDate;
                                      });
                                    }
                                    print(DateFormat('yyyy-MM-dd')
                                        .format(_startDate));
                                    print("millisecond" + startDate.toString());
                                  },
                                  icon: Icon(Icons.calendar_month_rounded)),
                              Text(DateFormat('MM-dd-yyyy').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      startdate.value))),
                              IconButton(
                                  onPressed: () async {
                                    final DateTime? pickedDate =
                                        await showDatePicker(
                                      context: Get.context!,
                                      initialDate: _endDate,
                                      firstDate: _startDate,
                                      lastDate: DateTime.now(),
                                    );
                                    if (pickedDate != null) {
                                      enddate.value = pickedDate
                                          .add(Duration(hours: 23, minutes: 59))
                                          .millisecondsSinceEpoch;
                                      setState(() {
                                        _endDate = pickedDate;
                                      });
                                    }
                                    print(DateFormat('yyyy-MM-dd')
                                        .format(_endDate));
                                    print("millisecond" + enddate.toString());
                                    // getDateFromUser();
                                  },
                                  icon: Icon(Icons.calendar_month_rounded)),
                              Text(DateFormat('MM-dd-yyyy').format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      enddate.value)))
                            ],
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: deviceHeight * 0.01, left: deviceWidth * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Time Filter",
                      style: TextStyle(
                          fontFamily: ConstFont.popinsRegular,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: deviceHeight * 0.03,
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                       ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          controller: ScrollController(),
                          itemCount: homeController.liveOrderList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(right: deviceWidth * 0.01),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide.none,
                                        borderRadius: BorderRadius.circular(3)),
                                    backgroundColor: selectedValueIndex == index
                                        ? ConstColour.primaryColor
                                        : ConstColour.cardBgColor,
                                    minimumSize: Size(deviceWidth * 0.18,
                                        deviceHeight * 0.01),
                                    maximumSize: Size(deviceWidth * 0.25,
                                        deviceHeight * 0.02),
                                    elevation: 0.5),
                                onPressed: () {
                                  setState(() {
                                    homeController.orderType =
                                        homeController.liveOrderList[index].id;
                                    selectedValueIndex = index;
                                    print(selectedValueIndex);
                                    homeController.AssignOrderApiCall(
                                        homeController.orderType.toString(),
                                        homeController.distributorId
                                            .toString());
                                  });
                                },
                                child: Text(
                                  homeController
                                      .liveOrderList[index].filterType,
                                  style: TextStyle(
                                      fontSize: 9,
                                      color: selectedValueIndex == index
                                          ? Colors.black
                                          : Colors.black,
                                      fontFamily: ConstFont.popinsRegular),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Obx(
                  () => homeController.assignOrderList.isEmpty
                      // ? Center(child: Text("Order is not Avaliable."))
                      ?  Loaders(
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
                  )
                      : ListView.builder(
                          controller: ScrollController(),
                          scrollDirection: Axis.vertical,
                          itemCount: homeController.assignOrderList.length,
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
                                            child: Image.network(homeController
                                                .assignOrderList[index]
                                                .imageName
                                                .toString()),
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
                                                        width: deviceWidth * 0.5,
                                                        child: Text(
                                                          homeController
                                                              .assignOrderList[
                                                                  index]
                                                              .productName,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
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
                                                            ),
                                                          child: Row(
                                                            children: [
                                                              Text("Quantity : "
                                                                ,
                                                                style:
                                                                const TextStyle(
                                                                  fontSize: 12,
                                                                  //fontWeight: FontWeight.bold,
                                                                  fontFamily: ConstFont
                                                                      .popinsRegular,
                                                                  color:
                                                                  Colors.black,
                                                                ),
                                                              ),
                                                              Text(
                                                                homeController
                                                                    .assignOrderList[
                                                                        index]
                                                                    .quantity
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 12,
                                                                  //fontWeight: FontWeight.bold,
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
                                                      left:
                                                          deviceHeight * 0.01),
                                                  child: Row(
                                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Image.asset(
                                                          "assets/Icons/pin.png",width: deviceWidth * 0.04),
                                                      Expanded(
                                                        child: Text(
                                                          " "+homeController
                                                              .assignOrderList[
                                                                  index]
                                                              .address
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2,
                                                          style: const TextStyle(
                                                              letterSpacing:
                                                                  1.0,
                                                              fontSize: 10,
                                                              fontFamily: ConstFont
                                                                  .popinsRegular,
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: deviceWidth * 0.01,top: deviceHeight * 0.005),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,

                                                    children: [
                                                      Padding(
                                                        padding:  EdgeInsets.only(bottom: deviceHeight * 0.005),
                                                        child: Text(
                                                          " "+homeController
                                                              .assignOrderList[index]
                                                              .unitType
                                                              .toString(),
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
                                                              "₹ "+ homeController
                                                                  .assignOrderList[
                                                              index]
                                                                  .totalAmount
                                                                  .toString(),
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

                                                          homeController.assignOrderList[index].orderStatus == 0
                                                              ?
                                                          Padding(padding: EdgeInsets.only(
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
                                                                          primary:
                                                                          const Color(0xff6AB04C),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          homeController.assignOrderList[index].orderStatus =
                                                                          1;
                                                                          homeController.OrderUpdateApiCall(
                                                                              "1",
                                                                              homeController.assignOrderList[index].orderId.toString(),
                                                                              "");
                                                                          setState(() {});
                                                                        },
                                                                        child:
                                                                        Text(
                                                                          "Accept",
                                                                          style:
                                                                          TextStyle(
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
                                                                        ElevatedButton.styleFrom(primary: const Color(0xffF86C6B)),
                                                                        onPressed:
                                                                            () {},
                                                                        child:
                                                                        InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            homeController.reasonController.clear();
                                                                            final result = await showDialog(
                                                                                context: context,
                                                                                builder: (BuildContextcontext) {
                                                                                  return AlertDialog(
                                                                                    shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
                                                                                    backgroundColor: const Color(0xFFECF3F9),
                                                                                    title: Form(
                                                                                      key: formkey,
                                                                                      child: TextFormField(
                                                                                        controller: homeController.reasonController,
                                                                                        decoration: InputDecoration(
                                                                                          fillColor: const Color(0xFF0926C),
                                                                                          filled: true,
                                                                                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.black)),
                                                                                          border: OutlineInputBorder(
                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                          ),
                                                                                          enabledBorder: OutlineInputBorder(
                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                          ),
                                                                                          hintStyle: const TextStyle(fontFamily: ConstFont.popinsRegular, fontSize: 15),
                                                                                          hintText: "Reason for Reject ",
                                                                                        ),
                                                                                        validator: (value) {
                                                                                          if (value!.isEmpty) {
                                                                                            return "Propar Reason";
                                                                                          }
                                                                                          return null;
                                                                                        },
                                                                                      ),
                                                                                    ),
                                                                                    content: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        ElevatedButton(
                                                                                          onPressed: () {
                                                                                            homeController.assignOrderList[index].orderStatus = 2;
                                                                                            homeController.OrderUpdateApiCall("2", homeController.assignOrderList[index].orderId.toString(), homeController.reasonController.text);
                                                                                            setState(() {});
                                                                                            Navigator.pop(context, false);
                                                                                          },
                                                                                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFECF3F9), elevation: 0),
                                                                                          child: const Text(
                                                                                            "Submit",
                                                                                            style: TextStyle(fontSize: 20, color: Colors.black),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  );
                                                                                });
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
                                                          (homeController
                                                              .assignOrderList[
                                                          index]
                                                              .orderStatus !=
                                                              3 &&
                                                              homeController
                                                                  .assignOrderList[
                                                              index]
                                                                  .orderStatus !=
                                                                  4)
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
                                                                          primary: const Color(0xff6AB04C),
                                                                        ),
                                                                        onPressed: () {
                                                                          homeController.assignOrderList[index].orderStatus = 3;
                                                                          homeController.OrderUpdateApiCall("3", homeController.assignOrderList[index].orderId.toString(), "");
                                                                          setState(() {});
                                                                          print("Delivered ");
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
                                                                          primary: Colors.white
                                                                      ),

                                                                      onPressed: () {},
                                                                      child: InkWell(
                                                                        onTap: () async {
                                                                          homeController.reasonController.clear();
                                                                          final result = await showDialog(
                                                                              context: context,
                                                                              builder: (BuildContextcontext) {
                                                                                return AlertDialog(
                                                                                  shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
                                                                                  backgroundColor: const Color(0xFFECF3F9),
                                                                                  title: Form(
                                                                                    key: formkey,
                                                                                    child: TextFormField(
                                                                                      controller: homeController.reasonController,
                                                                                      decoration: InputDecoration(
                                                                                        fillColor: const Color(0xFF0926C),
                                                                                        filled: true,
                                                                                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.black)),
                                                                                        border: OutlineInputBorder(
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                        ),
                                                                                        enabledBorder: OutlineInputBorder(
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                        ),
                                                                                        hintStyle: const TextStyle(fontFamily: ConstFont.popinsRegular, fontSize: 15),
                                                                                        hintText: "Reason for Not Deliver",
                                                                                      ),
                                                                                      validator: (value) {
                                                                                        if (value!.isEmpty) {
                                                                                          return "Why Not Deliver";
                                                                                        }
                                                                                        return null;
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                  content: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      ElevatedButton(
                                                                                        onPressed: () {
                                                                                          homeController.assignOrderList[index].orderStatus = 4;
                                                                                          homeController.OrderUpdateApiCall("4", homeController.assignOrderList[index].orderId.toString(), homeController.reasonController.text);
                                                                                          setState(() {});
                                                                                          Navigator.pop(context, false);
                                                                                        },
                                                                                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFECF3F9), elevation: 0),
                                                                                        child: const Text(
                                                                                          "Submit",
                                                                                          style: TextStyle(fontSize: 20, color: Colors.black),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                );
                                                                              });
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
                                                            (homeController.assignOrderList[index].orderStatus == 3)
                                                                ? "Delivered"
                                                                : "Not Delivered",
                                                            style: TextStyle(
                                                              color: (homeController.assignOrderList[index].orderStatus == 2 || homeController.assignOrderList[index].orderStatus == 4 )  ? Colors.red : Colors.green,fontSize: 12,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      // Row(
                                                      //   mainAxisAlignment:
                                                      //       MainAxisAlignment
                                                      //           .spaceBetween,
                                                      //   children: [
                                                      //     Padding(
                                                      //       padding: EdgeInsets.only(
                                                      //           left: deviceWidth *
                                                      //               0.01),
                                                      //       child: Text(
                                                      //         homeController
                                                      //             .assignOrderList[
                                                      //                 index]
                                                      //             .totalAmount
                                                      //             .toString(),
                                                      //         style: const TextStyle(
                                                      //             fontSize: 12,
                                                      //             fontFamily: ConstFont
                                                      //                 .popinsMedium,
                                                      //             color:
                                                      //                 Colors.black),
                                                      //       ),
                                                      //     ),
                                                      //     homeController.assignOrderList[index].orderStatus == 0
                                                      //         ?
                                                      //     Padding(
                                                      //             padding:
                                                      //                 EdgeInsets.only(
                                                      //               left: deviceWidth * 0.01,
                                                      //             ),
                                                      //             child: Row(
                                                      //               //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                      //               children: [
                                                      //                 Padding(
                                                      //                   padding: EdgeInsets.only(
                                                      //                       left: deviceWidth * 0.01),
                                                      //                   child:
                                                      //                       Container(
                                                      //                     height: 25,
                                                      //                     width: 90,
                                                      //                     decoration: BoxDecoration(
                                                      //                       borderRadius: BorderRadius.circular(1),
                                                      //                     ),
                                                      //                     child: Center(
                                                      //                       child: ElevatedButton(
                                                      //                         style: ElevatedButton.styleFrom(
                                                      //                           primary: const Color(0xff6AB04C),
                                                      //                         ),
                                                      //                         onPressed: () {
                                                      //                           homeController.OrderUpdateApiCall("1", homeController.assignOrderList[index].orderId.toString(), "");
                                                      //                         },
                                                      //                         child:
                                                      //                             Text(
                                                      //                           "Accept",
                                                      //                           style:
                                                      //                               TextStyle(
                                                      //                             fontFamily: ConstFont.popinsRegular,
                                                      //                             color: SelectedValueIndex == 1 ? Colors.black : Colors.white,
                                                      //                             //color: Colors.white
                                                      //                           ),
                                                      //                         ),
                                                      //                       ),
                                                      //                     ),
                                                      //                   ),
                                                      //                 ),
                                                      //                 Padding(
                                                      //                   padding: EdgeInsets.only(
                                                      //                       left: deviceWidth * 0.01,
                                                      //                       right: deviceWidth * 0.01),
                                                      //                   child:
                                                      //                       Container(
                                                      //                     height: 25,
                                                      //                     width: 75,
                                                      //                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(1),
                                                      //                     ),
                                                      //                     child: Center(
                                                      //                       child:
                                                      //                       ElevatedButton(
                                                      //                         style: ElevatedButton.styleFrom(primary: const Color(0xffF86C6B)),
                                                      //                         onPressed: () {},
                                                      //                         child: InkWell(
                                                      //                           onTap: () async {
                                                      //                             homeController.reasonController.clear();
                                                      //                             final result = await showDialog(
                                                      //                                 context: context,
                                                      //                                 builder: (BuildContextcontext) {
                                                      //                                   return AlertDialog(
                                                      //                                     shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
                                                      //                                     backgroundColor: const Color(0xFFECF3F9),
                                                      //                                     title: Form(
                                                      //                                       key: formkey,
                                                      //                                       child: TextFormField(
                                                      //                                         controller: homeController.reasonController,
                                                      //                                         decoration: InputDecoration(
                                                      //                                           fillColor: const Color(0xFF0926C),
                                                      //                                           filled: true,
                                                      //                                           focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.black)),
                                                      //                                           border: OutlineInputBorder(
                                                      //                                             borderRadius: BorderRadius.circular(10),
                                                      //                                           ),
                                                      //                                           enabledBorder: OutlineInputBorder(
                                                      //                                             borderRadius: BorderRadius.circular(10),
                                                      //                                           ),
                                                      //                                           hintStyle: const TextStyle(fontFamily: ConstFont.popinsRegular, fontSize: 15),
                                                      //                                           hintText: "Reason for Reject ",
                                                      //                                         ),
                                                      //                                         validator: (value) {
                                                      //                                           if (value!.isEmpty) {
                                                      //                                             return "Propar Reason";
                                                      //                                           }
                                                      //                                           return null;
                                                      //                                         },
                                                      //                                       ),
                                                      //                                     ),
                                                      //                                     content: Row(
                                                      //                                       mainAxisAlignment: MainAxisAlignment.center,
                                                      //                                       children: [
                                                      //                                         ElevatedButton(
                                                      //                                           onPressed: () {
                                                      //                                             homeController.OrderUpdateApiCall("2", homeController.assignOrderList[index].orderId.toString(), homeController.reasonController.text);
                                                      //                                             Navigator.pop(context, false);
                                                      //                                           },
                                                      //                                           style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFECF3F9), elevation: 0),
                                                      //                                           child: const Text(
                                                      //                                             "Submit",
                                                      //                                             style: TextStyle(fontSize: 20, color: Colors.black),
                                                      //                                           ),
                                                      //                                         ),
                                                      //                                       ],
                                                      //                                     ),
                                                      //                                   );
                                                      //                                 });
                                                      //                           },
                                                      //                           child: const Text(
                                                      //                             "Reject",
                                                      //                             style: TextStyle(fontFamily: ConstFont.popinsRegular, color: Colors.white),
                                                      //                           ),
                                                      //                         ),
                                                      //                       ),
                                                      //                     ),
                                                      //                   ),
                                                      //                 ),
                                                      //               ],
                                                      //             ),
                                                      //           )
                                                      //         : (homeController.assignOrderList[index].orderStatus == 3 &&
                                                      //                 homeController.assignOrderList[index].orderStatus == 4)
                                                      //             ? Padding(
                                                      //                 padding: EdgeInsets.only(
                                                      //                   left: deviceWidth * 0.01,
                                                      //                 ),
                                                      //                 child: Row(
                                                      //                   children: [
                                                      //                     Padding(
                                                      //                       padding: EdgeInsets.only(left: deviceWidth * 0.01),
                                                      //                       child: Container(
                                                      //                         height: 25,
                                                      //                         width: 90,
                                                      //                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(1),),
                                                      //                         child: Center(
                                                      //                           child: ElevatedButton(
                                                      //                             style: ElevatedButton.styleFrom(
                                                      //                               primary: const Color(0xff6AB04C),
                                                      //                             ),
                                                      //                             onPressed: () {
                                                      //                               homeController.isChange = true.obs;
                                                      //                               homeController.OrderUpdateApiCall("3", homeController.assignOrderList[index].orderId.toString(), "");
                                                      //                               print("Delivered ");
                                                      //                             },
                                                      //                             child: Text(
                                                      //                               "Delivered",
                                                      //                               style: TextStyle(
                                                      //                                 fontFamily: ConstFont.popinsRegular,
                                                      //                                 color: SelectedValueIndex == 1 ? Colors.black : Colors.white,
                                                      //                                 //color: Colors.white
                                                      //                               ),
                                                      //                             ),
                                                      //                           ),
                                                      //                         ),
                                                      //                       ),
                                                      //                     ),
                                                      //                     Padding(
                                                      //                       padding: EdgeInsets.only(
                                                      //                           left: deviceWidth * 0.01,
                                                      //                           right: deviceWidth * 0.01),
                                                      //                       child: Container(
                                                      //                             height: 25,
                                                      //                             width: 75,
                                                      //                         decoration: BoxDecoration(
                                                      //                           borderRadius: BorderRadius.circular(1),
                                                      //                         ),
                                                      //                         child: Center(
                                                      //                           child: ElevatedButton(
                                                      //                             style: ElevatedButton.styleFrom(primary: const Color(0xffF86C6B)),
                                                      //                             onPressed: () {},
                                                      //                             child: InkWell(
                                                      //                               onTap: () async {
                                                      //                                 homeController.reasonController.clear();
                                                      //                                 final result = await showDialog(
                                                      //                                     context: context,
                                                      //                                     builder: (BuildContextcontext) {
                                                      //                                       return AlertDialog(
                                                      //                                         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
                                                      //                                         backgroundColor: const Color(0xFFECF3F9),
                                                      //                                         title: Form(
                                                      //                                           key: formkey,
                                                      //                                           child: TextFormField(
                                                      //                                             controller: homeController.reasonController,
                                                      //                                             decoration: InputDecoration(
                                                      //                                               fillColor: const Color(0xFF0926C),
                                                      //                                               filled: true,
                                                      //                                               focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.black)),
                                                      //                                               border: OutlineInputBorder(
                                                      //                                                 borderRadius: BorderRadius.circular(10),
                                                      //                                               ),
                                                      //                                               enabledBorder: OutlineInputBorder(
                                                      //                                                 borderRadius: BorderRadius.circular(10),
                                                      //                                               ),
                                                      //                                               hintStyle: const TextStyle(fontFamily: ConstFont.popinsRegular, fontSize: 15),
                                                      //                                               hintText: "Reason for Not Deliver ",
                                                      //                                             ),
                                                      //                                             validator: (value) {
                                                      //                                               if (value!.isEmpty) {
                                                      //                                                 return "Why Not Deliver";
                                                      //                                               }
                                                      //                                               return null;
                                                      //                                             },
                                                      //                                           ),
                                                      //                                         ),
                                                      //                                         content: Row(
                                                      //                                           mainAxisAlignment: MainAxisAlignment.center,
                                                      //                                           children: [
                                                      //                                             ElevatedButton(
                                                      //                                               onPressed: () {
                                                      //                                                 homeController.OrderUpdateApiCall("4", homeController.assignOrderList[index].orderId.toString(), homeController.reasonController.text);
                                                      //                                                 Navigator.pop(context, false);
                                                      //                                               },
                                                      //                                               style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFECF3F9), elevation: 0),
                                                      //                                               child: const Text(
                                                      //                                                 "Submit",
                                                      //                                                 style: TextStyle(fontSize: 20, color: Colors.black),
                                                      //                                               ),
                                                      //                                             ),
                                                      //                                           ],
                                                      //                                         ),
                                                      //                                       );
                                                      //                                     });
                                                      //                               },
                                                      //                               child: const Text(
                                                      //                                 "Not Delivered",
                                                      //                                 style: TextStyle(fontFamily: ConstFont.popinsRegular, color: Colors.white),
                                                      //                               ),
                                                      //                             ),
                                                      //                           ),
                                                      //                         ),
                                                      //                       ),
                                                      //                     ),
                                                      //                   ],
                                                      //                 ),
                                                      //               )
                                                      //             : Text(
                                                      //                 (homeController.assignOrderList[index].orderStatus == 3)
                                                      //                     ? "Deliverd"
                                                      //                     : "Not Delivered",
                                                      //                 style: TextStyle(
                                                      //                     color: (homeController.assignOrderList[index].orderStatus == 2 || homeController.assignOrderList[index].orderStatus == 4 )  ? Colors.red : Colors.green,fontSize: 12,
                                                      //
                                                      //                     fontWeight: homeController.assignOrderList[index].orderStatus == 3
                                                      //                         ? FontWeight.bold
                                                      //                         : FontWeight.w500),
                                                      //               ),
                                                      //   ],
                                                      // ),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime(2025));
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    }
  }

  getDateFromUser() async {
    DateTime? PickerDate = await showDatePicker(
        //enablePastDates: false,
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        // firstDate: DateTime.now(),
        lastDate: DateTime(3000));
    if (PickerDate != null) {
      setState(() {
        selectedDate = PickerDate;
      });
    }
    // if (_PickerDate != null) {
    //   return;
    // }else{
    //   setState(() {
    //     selectedDate=_PickerDate;
    //     selectedDateForBackedDeveloprt="${selectedDate.year}/${selectedDate.month}/${selectedDate.day}";
    //   });
    // }
  }
}
