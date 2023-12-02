import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../ConstFile/constColor.dart';
import '../ConstFile/constFonts.dart';
import '../Controllers/home_controller.dart';
import 'home_screen.dart';
import 'loader.dart';
import 'product_detail.dart';

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

  var startdate = DateTime.now().add(Duration(hours: -TimeOfDay.now().hour, minutes: -TimeOfDay.now().minute)).millisecondsSinceEpoch.obs;
  DateTime now = DateTime.now();
  var enddate = DateTime.now().add(const Duration(hours: 1)).millisecondsSinceEpoch.obs;

  HomeController homeController = Get.put(HomeController());
  final _random = Random();
  final formkey = GlobalKey<FormState>();
  List<int> SelectedValueIndex = [1, 2, 3, 4, 5];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.orderType = 1;
    status = 0;
    enddate = DateTime.now().add(const Duration(hours: 1)).millisecondsSinceEpoch.obs;
    startdate = DateTime.now().add(Duration(hours: -TimeOfDay.now().hour, minutes: -TimeOfDay.now().minute)).millisecondsSinceEpoch.obs;
    homeController.isFilterApplyed = false.obs;
  }

  int dates = 0;
  int remianDates = 0;



  selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.fromMillisecondsSinceEpoch(dates),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (pickedDate != null && pickedDate != selectDate) {
      setState(() {
        // incomeController.dateUp.value = pickedDate.add(Duration(hours: TimeOfDay.now().hour,minutes: TimeOfDay.now().minute)).millisecondsSinceEpoch;
        // print(incomeController.timeUp.toString());
      });
      setState(() {
      });
    }
  }

  selectDates() async {
    final DateTime? pickedDates = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.fromMillisecondsSinceEpoch(remianDates),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (pickedDates != null && pickedDates != selectDates) {
      setState(() {
        // incomeController.remianDateUp.value = pickedDates.add(Duration(hours: TimeOfDay.now().hour,minutes: TimeOfDay.now().minute)).millisecondsSinceEpoch;
        // print(incomeController.timesUp.toString());
      });
    }
  }

  int status = 0;

  void _showDialog(context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    showDialog(
      useSafeArea: true,
      barrierDismissible: true,
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
            child: Column(
              mainAxisSize: MainAxisSize.min,
          children: [
            Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("   Select Filter",style: TextStyle(fontSize: 16,color: Colors.black,fontFamily: ConstFont.popinsMedium)),
              IconButton(onPressed: () {
                Get.back();
              }, icon: const Icon(Icons.cancel,color: Colors.black,size: 24,))
              ],
            ),
            Divider(height: deviceHeight * 0.01,color: Colors.grey.shade200),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:  EdgeInsets.only(left: deviceWidth * 0.05,right: deviceWidth * 0.12),
                  child: Text(
                    "From Date :     ",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: ConstFont.popinsMedium,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                Text(
                  "To Date :     ",
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: ConstFont.popinsMedium,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                Card(
                  color: ConstColour.cardBgColor,
                  child: Padding(
                    padding:  EdgeInsets.only(right: deviceWidth * 0.02,),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,

                      children: [

                        IconButton(
                            onPressed: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: Get.context!,
                                initialDate: _startDate,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2050),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                        primary: ConstColour.primaryColor, // header background color
                                        onPrimary: Colors.black, // header text color
                                        onSurface: Colors.black, // body text color
                                      ),
                                      // textButtonTheme: TextButtonThemeData(
                                      //   style: TextButton.styleFrom(
                                      //     foregroundColor: Colors.red, // button text color
                                      //   ),
                                      // ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (pickedDate != null) {
                                startdate.value = pickedDate.millisecondsSinceEpoch;
                                setState(() {
                                  _startDate = pickedDate;
                                  endDate = startDate;
                                });
                              }
                              debugPrint(DateFormat('yyyy-MM-dd').format(_startDate));
                              debugPrint("millisecond$startDate");
                            },
                            icon: const Icon(Icons.calendar_month_rounded)),
                        Text(DateFormat('dd-MM-yyyy').format(
                            DateTime.fromMillisecondsSinceEpoch(startdate.value))),
                      ],
                    ),
                  ),
                ),
                Card(
                  color: ConstColour.cardBgColor,
                  child: Padding(
                    padding:  EdgeInsets.only(right: deviceWidth * 0.02,),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        IconButton(
                            onPressed: () async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: Get.context!,
                                initialDate: _endDate,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2050),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                        primary: ConstColour.primaryColor, // header background color
                                        onPrimary: Colors.black, // header text color
                                        onSurface: Colors.black, // body text color
                                      ),
                                      // textButtonTheme: TextButtonThemeData(
                                      //   style: TextButton.styleFrom(
                                      //     foregroundColor: Colors.red, // button text color
                                      //   ),
                                      // ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );
                              if (pickedDate != null) {
                                enddate.value = pickedDate
                                    .add(const Duration(hours: 23, minutes: 59))
                                    .millisecondsSinceEpoch;
                                setState(() {
                                  _endDate = pickedDate;
                                });
                              }
                              debugPrint(DateFormat('yyyy-MM-dd').format(_endDate));
                              debugPrint("millisecond$enddate");
                              // getDateFromUser();
                            },
                            icon: const Icon(Icons.calendar_month_rounded)),
                        Text(DateFormat('dd-MM-yyyy').format(
                            DateTime.fromMillisecondsSinceEpoch(enddate.value)))
                      ],
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: deviceHeight * 0.01,),

            Padding(
              padding: EdgeInsets.only(left: deviceWidth * 0.02,right: deviceWidth * 0.02),
              child: Column(
                children: [
                  RadioListTile(
                    dense: true,
                    shape: RoundedRectangleBorder(
                        borderRadius:  BorderRadius.circular(11),
                        side: const BorderSide(color: Colors.black)
                    ),
                    activeColor: ConstColour.primaryColor,
                    title: const Text("Accept",  style: TextStyle(
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                        fontFamily: ConstFont.popinsRegular,
                        fontSize: 14
                    ),maxLines: 2,textAlign: TextAlign.center),
                    value: 1,
                    groupValue: status,
                    onChanged: (value) {
                      setState(() {
                        status = value!.toInt();
                      });
                    },
                  ),
                  SizedBox(height: deviceHeight * 0.01,),

                  RadioListTile(
                    dense: true,

                    activeColor: ConstColour.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius:  BorderRadius.circular(11),
                        side: const BorderSide(color: Colors.black)
                    ),
                    title: const Text("Reject",  style: TextStyle(
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                        fontFamily: ConstFont.popinsRegular,
                        fontSize: 14
                    ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    value: 2,
                    groupValue: status,
                    onChanged: (value) {
                      setState(() {
                        status = value!.toInt();
                      });
                    },
                  ),
                  SizedBox(height: deviceHeight * 0.01,),

                  RadioListTile(
                    dense: true,

                    shape: RoundedRectangleBorder(
                        borderRadius:  BorderRadius.circular(11),
                        side: const BorderSide(color: Colors.black)
                    ),
                    activeColor: ConstColour.primaryColor,
                    title: const Text("Delivered"  ,style: TextStyle(
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                        fontFamily: ConstFont.popinsRegular,
                        fontSize: 14
                    ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    value: 3,
                    groupValue: status,
                    onChanged: (value) {
                      setState(() {
                        status = value!.toInt();
                      });
                    },
                  ),
                  SizedBox(height: deviceHeight * 0.01,),

                  RadioListTile(
                    dense: true,
                    shape: RoundedRectangleBorder(
                        borderRadius:  BorderRadius.circular(11),
                        side: const BorderSide(color: Colors.black)
                    ),
                    activeColor: ConstColour.primaryColor,
                    title: const Text("Not Delivered",  style: TextStyle(
                      color: Colors.black,
                      overflow: TextOverflow.ellipsis,
                      fontFamily: ConstFont.popinsRegular,
                      fontSize: 14,
                    ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                    value: 4,
                    groupValue: status,
                    onChanged: (value) {
                      setState(() {
                        status = value!.toInt();
                      });
                    },
                  ),
                ],
              ),
            ),

            SizedBox(height: deviceHeight * 0.01,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ConstColour.primaryColor,
                      maximumSize: Size(deviceWidth * 0.4, deviceHeight * 0.055),
                      minimumSize: Size(deviceWidth * 0.3, deviceHeight * 0.05),
                      // backgroundColor: Colors.white
                    ),
                    onPressed: () {
                      homeController.getProductFilterApiCall(status, DateFormat('yyyy-MM-dd').format(_endDate), DateFormat('yyyy-MM-dd').format(_startDate),homeController.orderType.toString(),);
                      Get.back();
                     homeController.isFilterApplyed = true.obs;
                    },
                    child: const Text(
                      "Apply",
                      style: TextStyle(
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                        fontFamily: ConstFont.popinsMedium,
                        fontSize: 17
                      ),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ConstColour.primaryColor,
                      maximumSize:
                          Size(deviceWidth * 0.4, deviceHeight * 0.055),
                      minimumSize: Size(deviceWidth * 0.3, deviceHeight * 0.05),
                      // backgroundColor: Colors.white
                    ),
                    onPressed: () {

                       status = 0;
                       enddate = DateTime.now().add(const Duration(hours: 1)).millisecondsSinceEpoch.obs;
                       startdate = DateTime.now().add(Duration(hours: -TimeOfDay.now().hour, minutes: -TimeOfDay.now().minute)).millisecondsSinceEpoch.obs;
                        homeController.isFilterApplyed = false.obs;
                       // _startDate = DateTime.now();
                       // _endDate = DateTime.now();
                       setState(() {
                       });
                       Get.back();
                    },
                    child: const Text(
                      "Clear All",
                      style: TextStyle(
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                        fontFamily: ConstFont.popinsMedium,
                        fontSize: 17
                      ),
                    ))
              ],
            ),
            SizedBox(height: deviceHeight * 0.01,),

          ],
        )),
      ),
    );
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
        actions: [
          Obx(
            () => IconButton(
                onPressed: () async {

                    _showDialog(context);

                },
                // icon: homeController.isFilterApplyed == true ? Icon(Icons.filter_alt_off_rounded,color: Colors.black,size: 24,) : Icon(
                //   Icons.filter_alt_rounded,
                //   color: Colors.black,
                //   size: 24,
                // )
              icon: Icon(homeController.isFilterApplyed == true ? Icons.filter_alt_off_rounded : Icons.filter_alt_rounded,color: Colors.black),
            ),
          )
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Live Order",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02),
          child: Column(
            children: [

              Padding(
                padding: EdgeInsets.only(
                    top: deviceHeight * 0.01, left: deviceWidth * 0.02),
                child: const Row(
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
                child: SizedBox(
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
                                    maximumSize: Size(
                                        deviceWidth * 0.3, deviceHeight * 0.02),
                                    elevation: 0.5),
                                onPressed: () {
                                  setState(() {
                                    homeController.orderType = homeController.liveOrderList[index].id;
                                    selectedValueIndex = index;
                                    debugPrint(selectedValueIndex.toString());
                                    if(homeController.isFilterApplyed.value == true){
                                      homeController.getProductFilterApiCall(status, DateFormat('yyyy-MM-dd').format(_endDate), DateFormat('yyyy-MM-dd').format(_startDate),homeController.orderType.toString(),);
                                    }else{
                                      homeController.AssignOrderApiCall( homeController.orderType.toString(),homeController.distributorId.toString());
                                    }
                                  });
                                },
                                child: Text(
                                  homeController
                                      .liveOrderList[index].filterType,
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: selectedValueIndex == index
                                          ? Colors.black
                                          : Colors.black,
                                      fontFamily: ConstFont.popinsMedium),
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
                      ?  (homeController.isListEmplty.value == true) ? Center(child: Text('No data available',style: TextStyle(color: Colors.black,fontFamily: ConstFont.popinsRegular,fontSize: 18,overflow: TextOverflow.ellipsis,))) : Loaders(
                    items: 10,
                    direction: LoaderDirection.ltr,
                    builder:  Padding(
                      padding: EdgeInsets.only(
                          right: deviceWidth * 0.01),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            mainAxisAlignment:
                            MainAxisAlignment.start,
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
                                        bottom:
                                        deviceHeight * 0.02),
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
                    itemCount:
                    homeController.assignOrderList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(() => ProductDetailPage(
                            productIndex: index,
                          ));
                          debugPrint(
                              "productId${homeController.assignOrderList[index].productId}");
                        },
                        child: Card(
                            color: ConstColour.cardBgColor,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: deviceWidth * 0.01,
                                  bottom: deviceHeight * 0.01,
                                  right: deviceWidth * 0.01,
                                  top: deviceHeight * 0.01),
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
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
                                              .colors[
                                          _random.nextInt(15)],
                                        ),
                                        height: 60,
                                        width: 72,
                                        child: Image(
                                          width: deviceWidth * 0.1,
                                          errorBuilder:
                                              (BuildContext context,
                                              Object exception,
                                              StackTrace?
                                              stackTrace) {
                                            // Custom error widget to display when image fails to load
                                            return const Icon(
                                              Icons.image,
                                              size: 45,
                                            );
                                          },
                                          image: NetworkImage(
                                            homeController
                                                .assignOrderList[
                                            index]
                                                .imageName
                                                .toString(),
                                          ),
                                        ),
                                        // child: Image.network(
                                        //     homeController
                                        //         .assignOrderList[index]
                                        //         .imageName
                                        //         .toString()),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left:
                                                      deviceWidth *
                                                          0.02),
                                                  child: SizedBox(
                                                    width:
                                                    deviceWidth *
                                                        0.45,
                                                    child: Text(
                                                      homeController
                                                          .assignOrderList[
                                                      index]
                                                          .productName,
                                                      overflow:
                                                      TextOverflow
                                                          .ellipsis,
                                                      style: const TextStyle(
                                                          fontSize:
                                                          14,
                                                          fontFamily:
                                                          ConstFont
                                                              .popinsRegular,
                                                          color: Colors
                                                              .black,
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
                                                      padding:
                                                      EdgeInsets
                                                          .only(
                                                        left:
                                                        deviceHeight *
                                                            0.01,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            "Quantity : ",
                                                            style:
                                                            TextStyle(
                                                              fontSize:
                                                              12,
                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily:
                                                              ConstFont.popinsRegular,
                                                              color:
                                                              Colors.black,
                                                            ),
                                                          ),
                                                          Text(
                                                            homeController
                                                                .assignOrderList[index]
                                                                .quantity
                                                                .toString(),
                                                            style:
                                                            const TextStyle(
                                                              fontSize:
                                                              12,
                                                              //fontWeight: FontWeight.bold,
                                                              fontFamily:
                                                              ConstFont.popinsMedium,
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
                                                  deviceHeight *
                                                      0.01),
                                              child: Row(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Image.asset(
                                                      "assets/Icons/pin.png",
                                                      width:
                                                      deviceWidth *
                                                          0.04),
                                                  Expanded(
                                                    child: Text(
                                                      " ${homeController.assignOrderList[index].address}",
                                                      overflow:
                                                      TextOverflow
                                                          .ellipsis,
                                                      maxLines: 2,
                                                      style: const TextStyle(
                                                          letterSpacing:
                                                          1.0,
                                                          fontSize:
                                                          10,
                                                          fontFamily:
                                                          ConstFont
                                                              .popinsRegular,
                                                          color: Colors
                                                              .black),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left:
                                                  deviceWidth *
                                                      0.01,
                                                  top:
                                                  deviceHeight *
                                                      0.005),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom:
                                                        deviceHeight *
                                                            0.005),
                                                    child: Text(
                                                      " ${homeController.assignOrderList[index].unitType}",
                                                      style: const TextStyle(
                                                          fontSize:
                                                          12,
                                                          fontFamily:
                                                          ConstFont
                                                              .popinsRegular,
                                                          color: Colors
                                                              .black),
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
                                                          "₹ ${homeController.assignOrderList[index].totalAmount}",
                                                          style: const TextStyle(
                                                              fontSize:
                                                              12,
                                                              fontWeight: FontWeight
                                                                  .w700,
                                                              fontFamily: ConstFont
                                                                  .popinsRegular,
                                                              color:
                                                              Colors.black),
                                                        ),
                                                      ),

                                                      // change

                                                      homeController
                                                          .assignOrderList[
                                                      index]
                                                          .orderStatus ==
                                                          0
                                                          ? Padding(
                                                        padding:
                                                        EdgeInsets.only(
                                                          left:
                                                          deviceWidth * 0.01,
                                                        ),
                                                        child:
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(left: deviceWidth * 0.01),
                                                              child: Container(
                                                                height: 25,
                                                                width: 90,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(1),
                                                                ),
                                                                child: Center(
                                                                  child: ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                      backgroundColor: const Color(0xff6AB04C),
                                                                    ),
                                                                    onPressed: () {
                                                                      homeController.assignOrderList[index].orderStatus = 1;
                                                                      homeController.OrderUpdateApiCall("1", homeController.assignOrderList[index].orderId.toString(), "");
                                                                      setState(() {});
                                                                    },
                                                                    child: Text(
                                                                      "Accept",
                                                                      style: TextStyle(
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
                                                              padding: EdgeInsets.only(left: deviceWidth * 0.01, right: deviceWidth * 0.01),
                                                              child: Container(
                                                                height: 25,
                                                                width: 75,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(1),
                                                                ),
                                                                child: Center(
                                                                  child: ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xffF86C6B)),
                                                                    onPressed: () {},
                                                                    child: InkWell(
                                                                      onTap: () async {
                                                                        homeController.reasonController.clear();
                                                                        final result = await showDialog(
                                                                            context: context,
                                                                            builder: (BuildContextcontext) {
                                                                              return AlertDialog(
                                                                                shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
                                                                                backgroundColor: Colors.white,
                                                                                content: Form(
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
                                                                                        return "Enter Proper Reason";
                                                                                      }
                                                                                      return null;
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                title: const Text("Enter Your Reason Why Product Not Delivered", style: TextStyle(fontFamily: ConstFont.popinsRegular)),
                                                                                actions: [
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      ElevatedButton(
                                                                                        onPressed: () {
                                                                                          homeController.assignOrderList[index].orderStatus = 2;
                                                                                          homeController.OrderUpdateApiCall("2", homeController.assignOrderList[index].orderId.toString(), homeController.reasonController.text);
                                                                                          setState(() {});
                                                                                          Navigator.pop(context, false);
                                                                                        },
                                                                                        style: ElevatedButton.styleFrom(backgroundColor: ConstColour.primaryColor, elevation: 0),
                                                                                        child: const Text(
                                                                                          "Submit",
                                                                                          style: TextStyle(fontSize: 20, color: Colors.white),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            });
                                                                      },
                                                                      child: const Text(
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
                                                          : (homeController.assignOrderList[index].orderStatus != 3 &&
                                                          homeController.assignOrderList[index].orderStatus != 4)
                                                          ? Padding(
                                                        padding: EdgeInsets.only(
                                                          left: deviceWidth * 0.01,
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(left: deviceWidth * 0.01, right: deviceWidth * 0.01),
                                                              child: Container(
                                                                height: 25,
                                                                width: deviceWidth * 0.21,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(1),
                                                                ),
                                                                child: Center(
                                                                  child: ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                      backgroundColor: const Color(0xff6AB04C),
                                                                    ),
                                                                    onPressed: () {
                                                                      homeController.assignOrderList[index].orderStatus = 3;
                                                                      homeController.OrderUpdateApiCall("3", homeController.assignOrderList[index].orderId.toString(), "");
                                                                      setState(() {});
                                                                      debugPrint("Delivered ");
                                                                    },
                                                                    child: Text(
                                                                      "Delivered",
                                                                      style: TextStyle(
                                                                        fontFamily: ConstFont.popinsRegular,
                                                                        fontSize: 9,
                                                                        color: SelectedValueIndex == 1 ? Colors.black : Colors.white,
                                                                        //color: Colors.white
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              height: deviceHeight * 0.035,
                                                              width: deviceWidth * 0.26,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(1),
                                                              ),
                                                              child: Center(
                                                                child: ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                    // primary: const Color(0xffF86C6B)
                                                                      maximumSize: Size(deviceWidth * 0.25, deviceHeight * 0.035),
                                                                      minimumSize: Size(deviceWidth * 0.2, deviceHeight * 0.03),
                                                                      backgroundColor: Colors.white),
                                                                  onPressed: () {},
                                                                  child: InkWell(
                                                                    onTap: () async {
                                                                      homeController.reasonController.clear();
                                                                      final result = await showDialog(
                                                                          context: context,
                                                                          builder: (BuildContext context) {
                                                                            return AlertDialog(
                                                                              shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
                                                                              backgroundColor: Colors.white,
                                                                              content: Form(
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
                                                                              title: const Text("Enter Your Reason Why Product Not Delivered", style: TextStyle(fontFamily: ConstFont.popinsRegular)),
                                                                              actions: [
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    ElevatedButton(
                                                                                      onPressed: () {
                                                                                        if (formkey.currentState!.validate()) {
                                                                                          homeController.assignOrderList[index].orderStatus = 4;
                                                                                          homeController.OrderUpdateApiCall("4", homeController.assignOrderList[index].orderId.toString(), homeController.reasonController.text);
                                                                                          setState(() {});
                                                                                          Navigator.pop(context, false);
                                                                                        }
                                                                                      },
                                                                                      style: ElevatedButton.styleFrom(
                                                                                        backgroundColor: ConstColour.primaryColor,
                                                                                      ),
                                                                                      child: const Text(
                                                                                        "Submit",
                                                                                        style: TextStyle(fontSize: 20, color: Colors.white),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            );
                                                                          });
                                                                    },
                                                                    child: const Text(
                                                                      "Not Delivered",
                                                                      style: TextStyle(
                                                                        fontFamily: ConstFont.popinsMedium,
                                                                        color: Colors.red,
                                                                        fontSize: 9,
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
                                                        (homeController.assignOrderList[index].orderStatus == 3) ? "Delivered" : "Not Delivered",
                                                        style: TextStyle(
                                                          color: (homeController.assignOrderList[index].orderStatus == 2 || homeController.assignOrderList[index].orderStatus == 4) ? Colors.red : Colors.green,
                                                          fontSize: 12,
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
                                                  //                               debugPrint("Delivered ");
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
                            )),
                      );
                    },
                  ),
                ),
              )



              // FutureBuilder<dynamic>(
              //   future:  homeController.AssignOrderApiCall(homeController.orderType.toString(),homeController.distributorId.toString()),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       // Display shimmer while waiting for data
              //       return Flexible(
              //         child: Loaders(
              //           items: 10,
              //           direction: LoaderDirection.ltr,
              //           builder: Padding(
              //             padding: EdgeInsets.only(right: deviceWidth * 0.01),
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               crossAxisAlignment: CrossAxisAlignment.start,
              //               children: [
              //                 Row(
              //                   crossAxisAlignment: CrossAxisAlignment.start,
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   children: [
              //                     Column(
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.start,
              //                       mainAxisAlignment: MainAxisAlignment.start,
              //                       children: [
              //                         Padding(
              //                           padding: EdgeInsets.only(
              //                               left: deviceWidth * 0.018),
              //                           child: const Icon(
              //                             Icons.image,
              //                             size: 80,
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                     Column(
              //                       mainAxisAlignment: MainAxisAlignment.start,
              //                       children: [
              //                         Padding(
              //                           padding: EdgeInsets.only(
              //                               top: deviceHeight * 0.01,
              //                               left: deviceWidth * 0.02),
              //                           child: Container(
              //                             color: Colors.grey,
              //                             width: deviceWidth * 0.6,
              //                             height: deviceHeight * 0.01,
              //                           ),
              //                         ),
              //                         Padding(
              //                           padding: EdgeInsets.only(
              //                               top: deviceHeight * 0.02,
              //                               left: deviceWidth * 0.02),
              //                           child: Container(
              //                             color: Colors.grey,
              //                             width: deviceWidth * 0.6,
              //                             height: deviceHeight * 0.01,
              //                           ),
              //                         ),
              //                         Padding(
              //                           padding: EdgeInsets.only(
              //                               top: deviceHeight * 0.02,
              //                               left: deviceWidth * 0.02,
              //                               bottom: deviceHeight * 0.02),
              //                           child: Container(
              //                             color: Colors.grey,
              //                             width: deviceWidth * 0.6,
              //                             height: deviceHeight * 0.01,
              //                           ),
              //                         ),
              //                       ],
              //                     )
              //                   ],
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       );
              //     } else if (snapshot.hasError) {
              //       // Handle error
              //       return Padding(
              //         padding: EdgeInsets.only(top: deviceHeight * 0.3),
              //         child: Center(
              //             child: Text(
              //           'Error: ${snapshot.error}',
              //           style: const TextStyle(
              //             color: Colors.black,
              //             fontFamily: ConstFont.popinsRegular,
              //             fontSize: 18,
              //             overflow: TextOverflow.ellipsis,
              //           ),
              //         )),
              //       );
              //     } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              //       // Display "No data available" message
              //       return Padding(
              //         padding: EdgeInsets.only(top: deviceHeight * 0.3),
              //         child: const Center(
              //             child: Text('No data available',
              //                 style: TextStyle(
              //                   color: Colors.black,
              //                   fontFamily: ConstFont.popinsRegular,
              //                   fontSize: 18,
              //                   overflow: TextOverflow.ellipsis,
              //                 ))),
              //       );
              //     } else if (snapshot.hasData) {
              //       // Display the fetched data
              //       return Flexible(
              //         child: Obx(
              //           () => homeController.assignOrderList.isEmpty
              //               // ? Center(child: Text("Order is not Avaliable."))
              //               ? Loaders(
              //                   items: 10,
              //                   direction: LoaderDirection.ltr,
              //                   builder: Padding(
              //                     padding: EdgeInsets.only(
              //                         right: deviceWidth * 0.01),
              //                     child: Column(
              //                       mainAxisAlignment: MainAxisAlignment.start,
              //                       crossAxisAlignment:
              //                           CrossAxisAlignment.start,
              //                       children: [
              //                         Row(
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.start,
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.start,
              //                           children: [
              //                             Column(
              //                               crossAxisAlignment:
              //                                   CrossAxisAlignment.start,
              //                               mainAxisAlignment:
              //                                   MainAxisAlignment.start,
              //                               children: [
              //                                 Padding(
              //                                   padding: EdgeInsets.only(
              //                                       left: deviceWidth * 0.018),
              //                                   child: const Icon(
              //                                     Icons.image,
              //                                     size: 80,
              //                                   ),
              //                                 ),
              //                               ],
              //                             ),
              //                             Column(
              //                               mainAxisAlignment:
              //                                   MainAxisAlignment.start,
              //                               children: [
              //                                 Padding(
              //                                   padding: EdgeInsets.only(
              //                                       top: deviceHeight * 0.01,
              //                                       left: deviceWidth * 0.02),
              //                                   child: Container(
              //                                     color: Colors.grey,
              //                                     width: deviceWidth * 0.6,
              //                                     height: deviceHeight * 0.01,
              //                                   ),
              //                                 ),
              //                                 Padding(
              //                                   padding: EdgeInsets.only(
              //                                       top: deviceHeight * 0.02,
              //                                       left: deviceWidth * 0.02),
              //                                   child: Container(
              //                                     color: Colors.grey,
              //                                     width: deviceWidth * 0.6,
              //                                     height: deviceHeight * 0.01,
              //                                   ),
              //                                 ),
              //                                 Padding(
              //                                   padding: EdgeInsets.only(
              //                                       top: deviceHeight * 0.02,
              //                                       left: deviceWidth * 0.02,
              //                                       bottom:
              //                                           deviceHeight * 0.02),
              //                                   child: Container(
              //                                     color: Colors.grey,
              //                                     width: deviceWidth * 0.6,
              //                                     height: deviceHeight * 0.01,
              //                                   ),
              //                                 ),
              //                               ],
              //                             )
              //                           ],
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 )
              //               : ListView.builder(
              //                   controller: ScrollController(),
              //                   scrollDirection: Axis.vertical,
              //                   itemCount:
              //                       homeController.assignOrderList.length,
              //                   shrinkWrap: true,
              //                   itemBuilder: (context, index) {
              //                     return InkWell(
              //                       onTap: () {
              //                         Get.to(() => ProductDetailPage(
              //                               productIndex: index,
              //                             ));
              //                         debugPrint(
              //                             "productId${homeController.assignOrderList[index].productId}");
              //                       },
              //                       child: Card(
              //                           color: ConstColour.cardBgColor,
              //                           child: Padding(
              //                             padding: EdgeInsets.only(
              //                                 left: deviceWidth * 0.01,
              //                                 bottom: deviceHeight * 0.01,
              //                                 right: deviceWidth * 0.01,
              //                                 top: deviceHeight * 0.01),
              //                             child: Column(
              //                               mainAxisAlignment:
              //                                   MainAxisAlignment.center,
              //                               crossAxisAlignment:
              //                                   CrossAxisAlignment.start,
              //                               children: [
              //                                 Row(
              //                                   mainAxisAlignment:
              //                                       MainAxisAlignment.start,
              //                                   crossAxisAlignment:
              //                                       CrossAxisAlignment.center,
              //                                   //mainAxisSize: MainAxisSize.max,
              //                                   children: [
              //                                     Container(
              //                                       decoration: BoxDecoration(
              //                                         color: StickyColors
              //                                                 .colors[
              //                                             _random.nextInt(15)],
              //                                       ),
              //                                       height: 60,
              //                                       width: 72,
              //                                       child: Image(
              //                                         width: deviceWidth * 0.1,
              //                                         errorBuilder:
              //                                             (BuildContext context,
              //                                                 Object exception,
              //                                                 StackTrace?
              //                                                     stackTrace) {
              //                                           // Custom error widget to display when image fails to load
              //                                           return const Icon(
              //                                             Icons.image,
              //                                             size: 45,
              //                                           );
              //                                         },
              //                                         image: NetworkImage(
              //                                           homeController
              //                                               .assignOrderList[
              //                                                   index]
              //                                               .imageName
              //                                               .toString(),
              //                                         ),
              //                                       ),
              //                                       // child: Image.network(
              //                                       //     homeController
              //                                       //         .assignOrderList[index]
              //                                       //         .imageName
              //                                       //         .toString()),
              //                                     ),
              //                                     Expanded(
              //                                       child: Column(
              //                                         mainAxisAlignment:
              //                                             MainAxisAlignment
              //                                                 .start,
              //                                         crossAxisAlignment:
              //                                             CrossAxisAlignment
              //                                                 .start,
              //                                         children: [
              //                                           Row(
              //                                             mainAxisAlignment:
              //                                                 MainAxisAlignment
              //                                                     .spaceBetween,
              //                                             children: [
              //                                               Padding(
              //                                                 padding: EdgeInsets.only(
              //                                                     left:
              //                                                         deviceWidth *
              //                                                             0.02),
              //                                                 child: SizedBox(
              //                                                   width:
              //                                                       deviceWidth *
              //                                                           0.45,
              //                                                   child: Text(
              //                                                     homeController
              //                                                         .assignOrderList[
              //                                                             index]
              //                                                         .productName,
              //                                                     overflow:
              //                                                         TextOverflow
              //                                                             .ellipsis,
              //                                                     style: const TextStyle(
              //                                                         fontSize:
              //                                                             14,
              //                                                         fontFamily:
              //                                                             ConstFont
              //                                                                 .popinsRegular,
              //                                                         color: Colors
              //                                                             .black,
              //                                                         fontWeight:
              //                                                             FontWeight
              //                                                                 .bold),
              //                                                   ),
              //                                                 ),
              //                                               ),
              //                                               Row(
              //                                                 mainAxisAlignment:
              //                                                     MainAxisAlignment
              //                                                         .spaceAround,
              //                                                 children: [
              //                                                   Padding(
              //                                                     padding:
              //                                                         EdgeInsets
              //                                                             .only(
              //                                                       left:
              //                                                           deviceHeight *
              //                                                               0.01,
              //                                                     ),
              //                                                     child: Row(
              //                                                       children: [
              //                                                         const Text(
              //                                                           "Quantity : ",
              //                                                           style:
              //                                                               TextStyle(
              //                                                             fontSize:
              //                                                                 12,
              //                                                             //fontWeight: FontWeight.bold,
              //                                                             fontFamily:
              //                                                                 ConstFont.popinsRegular,
              //                                                             color:
              //                                                                 Colors.black,
              //                                                           ),
              //                                                         ),
              //                                                         Text(
              //                                                           homeController
              //                                                               .assignOrderList[index]
              //                                                               .quantity
              //                                                               .toString(),
              //                                                           style:
              //                                                               const TextStyle(
              //                                                             fontSize:
              //                                                                 12,
              //                                                             //fontWeight: FontWeight.bold,
              //                                                             fontFamily:
              //                                                                 ConstFont.popinsMedium,
              //                                                             color:
              //                                                                 Colors.black,
              //                                                           ),
              //                                                         ),
              //                                                       ],
              //                                                     ),
              //                                                   )
              //                                                 ],
              //                                               ),
              //                                             ],
              //                                           ),
              //                                           Padding(
              //                                             padding: EdgeInsets.only(
              //                                                 left:
              //                                                     deviceHeight *
              //                                                         0.01),
              //                                             child: Row(
              //                                               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                                               children: [
              //                                                 Image.asset(
              //                                                     "assets/Icons/pin.png",
              //                                                     width:
              //                                                         deviceWidth *
              //                                                             0.04),
              //                                                 Expanded(
              //                                                   child: Text(
              //                                                     " ${homeController.assignOrderList[index].address}",
              //                                                     overflow:
              //                                                         TextOverflow
              //                                                             .ellipsis,
              //                                                     maxLines: 2,
              //                                                     style: const TextStyle(
              //                                                         letterSpacing:
              //                                                             1.0,
              //                                                         fontSize:
              //                                                             10,
              //                                                         fontFamily:
              //                                                             ConstFont
              //                                                                 .popinsRegular,
              //                                                         color: Colors
              //                                                             .black),
              //                                                   ),
              //                                                 ),
              //                                               ],
              //                                             ),
              //                                           ),
              //                                           Padding(
              //                                             padding: EdgeInsets.only(
              //                                                 left:
              //                                                     deviceWidth *
              //                                                         0.01,
              //                                                 top:
              //                                                     deviceHeight *
              //                                                         0.005),
              //                                             child: Column(
              //                                               crossAxisAlignment:
              //                                                   CrossAxisAlignment
              //                                                       .start,
              //                                               children: [
              //                                                 Padding(
              //                                                   padding: EdgeInsets.only(
              //                                                       bottom:
              //                                                           deviceHeight *
              //                                                               0.005),
              //                                                   child: Text(
              //                                                     " ${homeController.assignOrderList[index].unitType}",
              //                                                     style: const TextStyle(
              //                                                         fontSize:
              //                                                             12,
              //                                                         fontFamily:
              //                                                             ConstFont
              //                                                                 .popinsRegular,
              //                                                         color: Colors
              //                                                             .black),
              //                                                   ),
              //                                                 ),
              //                                                 Row(
              //                                                   mainAxisAlignment:
              //                                                       MainAxisAlignment
              //                                                           .spaceBetween,
              //                                                   children: [
              //                                                     Padding(
              //                                                       padding: EdgeInsets.only(
              //                                                           left: deviceWidth *
              //                                                               0.01),
              //                                                       child: Text(
              //                                                         "₹ ${homeController.assignOrderList[index].totalAmount}",
              //                                                         style: const TextStyle(
              //                                                             fontSize:
              //                                                                 12,
              //                                                             fontWeight: FontWeight
              //                                                                 .w700,
              //                                                             fontFamily: ConstFont
              //                                                                 .popinsRegular,
              //                                                             color:
              //                                                                 Colors.black),
              //                                                       ),
              //                                                     ),
              //
              //                                                     // change
              //
              //                                                     homeController
              //                                                                 .assignOrderList[
              //                                                                     index]
              //                                                                 .orderStatus ==
              //                                                             0
              //                                                         ? Padding(
              //                                                             padding:
              //                                                                 EdgeInsets.only(
              //                                                               left:
              //                                                                   deviceWidth * 0.01,
              //                                                             ),
              //                                                             child:
              //                                                                 Row(
              //                                                               children: [
              //                                                                 Padding(
              //                                                                   padding: EdgeInsets.only(left: deviceWidth * 0.01),
              //                                                                   child: Container(
              //                                                                     height: 25,
              //                                                                     width: 90,
              //                                                                     decoration: BoxDecoration(
              //                                                                       borderRadius: BorderRadius.circular(1),
              //                                                                     ),
              //                                                                     child: Center(
              //                                                                       child: ElevatedButton(
              //                                                                         style: ElevatedButton.styleFrom(
              //                                                                           backgroundColor: const Color(0xff6AB04C),
              //                                                                         ),
              //                                                                         onPressed: () {
              //                                                                           homeController.assignOrderList[index].orderStatus = 1;
              //                                                                           homeController.OrderUpdateApiCall("1", homeController.assignOrderList[index].orderId.toString(), "");
              //                                                                           setState(() {});
              //                                                                         },
              //                                                                         child: Text(
              //                                                                           "Accept",
              //                                                                           style: TextStyle(
              //                                                                             fontFamily: ConstFont.popinsRegular,
              //                                                                             color: SelectedValueIndex == 1 ? Colors.black : Colors.white,
              //                                                                             //color: Colors.white
              //                                                                           ),
              //                                                                         ),
              //                                                                       ),
              //                                                                     ),
              //                                                                   ),
              //                                                                 ),
              //                                                                 Padding(
              //                                                                   padding: EdgeInsets.only(left: deviceWidth * 0.01, right: deviceWidth * 0.01),
              //                                                                   child: Container(
              //                                                                     height: 25,
              //                                                                     width: 75,
              //                                                                     decoration: BoxDecoration(
              //                                                                       borderRadius: BorderRadius.circular(1),
              //                                                                     ),
              //                                                                     child: Center(
              //                                                                       child: ElevatedButton(
              //                                                                         style: ElevatedButton.styleFrom(backgroundColor: const Color(0xffF86C6B)),
              //                                                                         onPressed: () {},
              //                                                                         child: InkWell(
              //                                                                           onTap: () async {
              //                                                                             homeController.reasonController.clear();
              //                                                                             final result = await showDialog(
              //                                                                                 context: context,
              //                                                                                 builder: (BuildContextcontext) {
              //                                                                                   return AlertDialog(
              //                                                                                     shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              //                                                                                     backgroundColor: Colors.white,
              //                                                                                     content: Form(
              //                                                                                       key: formkey,
              //                                                                                       child: TextFormField(
              //                                                                                         controller: homeController.reasonController,
              //                                                                                         decoration: InputDecoration(
              //                                                                                           fillColor: const Color(0xFF0926C),
              //                                                                                           filled: true,
              //                                                                                           focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.black)),
              //                                                                                           border: OutlineInputBorder(
              //                                                                                             borderRadius: BorderRadius.circular(10),
              //                                                                                           ),
              //                                                                                           enabledBorder: OutlineInputBorder(
              //                                                                                             borderRadius: BorderRadius.circular(10),
              //                                                                                           ),
              //                                                                                           hintStyle: const TextStyle(fontFamily: ConstFont.popinsRegular, fontSize: 15),
              //                                                                                           hintText: "Reason for Reject ",
              //                                                                                         ),
              //                                                                                         validator: (value) {
              //                                                                                           if (value!.isEmpty) {
              //                                                                                             return "Enter Proper Reason";
              //                                                                                           }
              //                                                                                           return null;
              //                                                                                         },
              //                                                                                       ),
              //                                                                                     ),
              //                                                                                     title: const Text("Enter Your Reason Why Product Not Delivered", style: TextStyle(fontFamily: ConstFont.popinsRegular)),
              //                                                                                     actions: [
              //                                                                                       Row(
              //                                                                                         mainAxisAlignment: MainAxisAlignment.center,
              //                                                                                         children: [
              //                                                                                           ElevatedButton(
              //                                                                                             onPressed: () {
              //                                                                                               homeController.assignOrderList[index].orderStatus = 2;
              //                                                                                               homeController.OrderUpdateApiCall("2", homeController.assignOrderList[index].orderId.toString(), homeController.reasonController.text);
              //                                                                                               setState(() {});
              //                                                                                               Navigator.pop(context, false);
              //                                                                                             },
              //                                                                                             style: ElevatedButton.styleFrom(backgroundColor: ConstColour.primaryColor, elevation: 0),
              //                                                                                             child: const Text(
              //                                                                                               "Submit",
              //                                                                                               style: TextStyle(fontSize: 20, color: Colors.white),
              //                                                                                             ),
              //                                                                                           ),
              //                                                                                         ],
              //                                                                                       ),
              //                                                                                     ],
              //                                                                                   );
              //                                                                                 });
              //                                                                           },
              //                                                                           child: const Text(
              //                                                                             "Reject",
              //                                                                             style: TextStyle(fontFamily: ConstFont.popinsRegular, color: Colors.white),
              //                                                                           ),
              //                                                                         ),
              //                                                                       ),
              //                                                                     ),
              //                                                                   ),
              //                                                                 ),
              //                                                               ],
              //                                                             ),
              //                                                           )
              //                                                         : (homeController.assignOrderList[index].orderStatus != 3 &&
              //                                                                 homeController.assignOrderList[index].orderStatus != 4)
              //                                                             ? Padding(
              //                                                                 padding: EdgeInsets.only(
              //                                                                   left: deviceWidth * 0.01,
              //                                                                 ),
              //                                                                 child: Row(
              //                                                                   children: [
              //                                                                     Padding(
              //                                                                       padding: EdgeInsets.only(left: deviceWidth * 0.01, right: deviceWidth * 0.01),
              //                                                                       child: Container(
              //                                                                         height: 25,
              //                                                                         width: deviceWidth * 0.21,
              //                                                                         decoration: BoxDecoration(
              //                                                                           borderRadius: BorderRadius.circular(1),
              //                                                                         ),
              //                                                                         child: Center(
              //                                                                           child: ElevatedButton(
              //                                                                             style: ElevatedButton.styleFrom(
              //                                                                               backgroundColor: const Color(0xff6AB04C),
              //                                                                             ),
              //                                                                             onPressed: () {
              //                                                                               homeController.assignOrderList[index].orderStatus = 3;
              //                                                                               homeController.OrderUpdateApiCall("3", homeController.assignOrderList[index].orderId.toString(), "");
              //                                                                               setState(() {});
              //                                                                               debugPrint("Delivered ");
              //                                                                             },
              //                                                                             child: Text(
              //                                                                               "Delivered",
              //                                                                               style: TextStyle(
              //                                                                                 fontFamily: ConstFont.popinsRegular,
              //                                                                                 fontSize: 9,
              //                                                                                 color: SelectedValueIndex == 1 ? Colors.black : Colors.white,
              //                                                                                 //color: Colors.white
              //                                                                               ),
              //                                                                             ),
              //                                                                           ),
              //                                                                         ),
              //                                                                       ),
              //                                                                     ),
              //                                                                     Container(
              //                                                                       height: deviceHeight * 0.035,
              //                                                                       width: deviceWidth * 0.26,
              //                                                                       decoration: BoxDecoration(
              //                                                                         borderRadius: BorderRadius.circular(1),
              //                                                                       ),
              //                                                                       child: Center(
              //                                                                         child: ElevatedButton(
              //                                                                           style: ElevatedButton.styleFrom(
              //                                                                               // primary: const Color(0xffF86C6B)
              //                                                                               maximumSize: Size(deviceWidth * 0.25, deviceHeight * 0.035),
              //                                                                               minimumSize: Size(deviceWidth * 0.2, deviceHeight * 0.03),
              //                                                                               backgroundColor: Colors.white),
              //                                                                           onPressed: () {},
              //                                                                           child: InkWell(
              //                                                                             onTap: () async {
              //                                                                               homeController.reasonController.clear();
              //                                                                               final result = await showDialog(
              //                                                                                   context: context,
              //                                                                                   builder: (BuildContext context) {
              //                                                                                     return AlertDialog(
              //                                                                                       shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              //                                                                                       backgroundColor: Colors.white,
              //                                                                                       content: Form(
              //                                                                                         key: formkey,
              //                                                                                         child: TextFormField(
              //                                                                                           controller: homeController.reasonController,
              //                                                                                           decoration: InputDecoration(
              //                                                                                             fillColor: const Color(0xFF0926C),
              //                                                                                             filled: true,
              //                                                                                             focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.black)),
              //                                                                                             border: OutlineInputBorder(
              //                                                                                               borderRadius: BorderRadius.circular(10),
              //                                                                                             ),
              //                                                                                             enabledBorder: OutlineInputBorder(
              //                                                                                               borderRadius: BorderRadius.circular(10),
              //                                                                                             ),
              //                                                                                             hintStyle: const TextStyle(fontFamily: ConstFont.popinsRegular, fontSize: 15),
              //                                                                                             hintText: "Reason for Not Deliver",
              //                                                                                           ),
              //                                                                                           validator: (value) {
              //                                                                                             if (value!.isEmpty) {
              //                                                                                               return "Why Not Deliver";
              //                                                                                             }
              //                                                                                             return null;
              //                                                                                           },
              //                                                                                         ),
              //                                                                                       ),
              //                                                                                       title: const Text("Enter Your Reason Why Product Not Delivered", style: TextStyle(fontFamily: ConstFont.popinsRegular)),
              //                                                                                       actions: [
              //                                                                                         Row(
              //                                                                                           mainAxisAlignment: MainAxisAlignment.center,
              //                                                                                           children: [
              //                                                                                             ElevatedButton(
              //                                                                                               onPressed: () {
              //                                                                                                 if (formkey.currentState!.validate()) {
              //                                                                                                   homeController.assignOrderList[index].orderStatus = 4;
              //                                                                                                   homeController.OrderUpdateApiCall("4", homeController.assignOrderList[index].orderId.toString(), homeController.reasonController.text);
              //                                                                                                   setState(() {});
              //                                                                                                   Navigator.pop(context, false);
              //                                                                                                 }
              //                                                                                               },
              //                                                                                               style: ElevatedButton.styleFrom(
              //                                                                                                 backgroundColor: ConstColour.primaryColor,
              //                                                                                               ),
              //                                                                                               child: const Text(
              //                                                                                                 "Submit",
              //                                                                                                 style: TextStyle(fontSize: 20, color: Colors.white),
              //                                                                                               ),
              //                                                                                             ),
              //                                                                                           ],
              //                                                                                         ),
              //                                                                                       ],
              //                                                                                     );
              //                                                                                   });
              //                                                                             },
              //                                                                             child: const Text(
              //                                                                               "Not Delivered",
              //                                                                               style: TextStyle(
              //                                                                                 fontFamily: ConstFont.popinsMedium,
              //                                                                                 color: Colors.red,
              //                                                                                 fontSize: 9,
              //                                                                               ),
              //                                                                             ),
              //                                                                           ),
              //                                                                         ),
              //                                                                       ),
              //                                                                     ),
              //                                                                   ],
              //                                                                 ),
              //                                                               )
              //                                                             : Text(
              //                                                                 (homeController.assignOrderList[index].orderStatus == 3) ? "Delivered" : "Not Delivered",
              //                                                                 style: TextStyle(
              //                                                                   color: (homeController.assignOrderList[index].orderStatus == 2 || homeController.assignOrderList[index].orderStatus == 4) ? Colors.red : Colors.green,
              //                                                                   fontSize: 12,
              //                                                                 ),
              //                                                               ),
              //                                                   ],
              //                                                 ),
              //                                                 // Row(
              //                                                 //   mainAxisAlignment:
              //                                                 //       MainAxisAlignment
              //                                                 //           .spaceBetween,
              //                                                 //   children: [
              //                                                 //     Padding(
              //                                                 //       padding: EdgeInsets.only(
              //                                                 //           left: deviceWidth *
              //                                                 //               0.01),
              //                                                 //       child: Text(
              //                                                 //         homeController
              //                                                 //             .assignOrderList[
              //                                                 //                 index]
              //                                                 //             .totalAmount
              //                                                 //             .toString(),
              //                                                 //         style: const TextStyle(
              //                                                 //             fontSize: 12,
              //                                                 //             fontFamily: ConstFont
              //                                                 //                 .popinsMedium,
              //                                                 //             color:
              //                                                 //                 Colors.black),
              //                                                 //       ),
              //                                                 //     ),
              //                                                 //     homeController.assignOrderList[index].orderStatus == 0
              //                                                 //         ?
              //                                                 //     Padding(
              //                                                 //             padding:
              //                                                 //                 EdgeInsets.only(
              //                                                 //               left: deviceWidth * 0.01,
              //                                                 //             ),
              //                                                 //             child: Row(
              //                                                 //               //mainAxisAlignment: MainAxisAlignment.spaceAround,
              //                                                 //               children: [
              //                                                 //                 Padding(
              //                                                 //                   padding: EdgeInsets.only(
              //                                                 //                       left: deviceWidth * 0.01),
              //                                                 //                   child:
              //                                                 //                       Container(
              //                                                 //                     height: 25,
              //                                                 //                     width: 90,
              //                                                 //                     decoration: BoxDecoration(
              //                                                 //                       borderRadius: BorderRadius.circular(1),
              //                                                 //                     ),
              //                                                 //                     child: Center(
              //                                                 //                       child: ElevatedButton(
              //                                                 //                         style: ElevatedButton.styleFrom(
              //                                                 //                           primary: const Color(0xff6AB04C),
              //                                                 //                         ),
              //                                                 //                         onPressed: () {
              //                                                 //                           homeController.OrderUpdateApiCall("1", homeController.assignOrderList[index].orderId.toString(), "");
              //                                                 //                         },
              //                                                 //                         child:
              //                                                 //                             Text(
              //                                                 //                           "Accept",
              //                                                 //                           style:
              //                                                 //                               TextStyle(
              //                                                 //                             fontFamily: ConstFont.popinsRegular,
              //                                                 //                             color: SelectedValueIndex == 1 ? Colors.black : Colors.white,
              //                                                 //                             //color: Colors.white
              //                                                 //                           ),
              //                                                 //                         ),
              //                                                 //                       ),
              //                                                 //                     ),
              //                                                 //                   ),
              //                                                 //                 ),
              //                                                 //                 Padding(
              //                                                 //                   padding: EdgeInsets.only(
              //                                                 //                       left: deviceWidth * 0.01,
              //                                                 //                       right: deviceWidth * 0.01),
              //                                                 //                   child:
              //                                                 //                       Container(
              //                                                 //                     height: 25,
              //                                                 //                     width: 75,
              //                                                 //                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(1),
              //                                                 //                     ),
              //                                                 //                     child: Center(
              //                                                 //                       child:
              //                                                 //                       ElevatedButton(
              //                                                 //                         style: ElevatedButton.styleFrom(primary: const Color(0xffF86C6B)),
              //                                                 //                         onPressed: () {},
              //                                                 //                         child: InkWell(
              //                                                 //                           onTap: () async {
              //                                                 //                             homeController.reasonController.clear();
              //                                                 //                             final result = await showDialog(
              //                                                 //                                 context: context,
              //                                                 //                                 builder: (BuildContextcontext) {
              //                                                 //                                   return AlertDialog(
              //                                                 //                                     shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              //                                                 //                                     backgroundColor: const Color(0xFFECF3F9),
              //                                                 //                                     title: Form(
              //                                                 //                                       key: formkey,
              //                                                 //                                       child: TextFormField(
              //                                                 //                                         controller: homeController.reasonController,
              //                                                 //                                         decoration: InputDecoration(
              //                                                 //                                           fillColor: const Color(0xFF0926C),
              //                                                 //                                           filled: true,
              //                                                 //                                           focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.black)),
              //                                                 //                                           border: OutlineInputBorder(
              //                                                 //                                             borderRadius: BorderRadius.circular(10),
              //                                                 //                                           ),
              //                                                 //                                           enabledBorder: OutlineInputBorder(
              //                                                 //                                             borderRadius: BorderRadius.circular(10),
              //                                                 //                                           ),
              //                                                 //                                           hintStyle: const TextStyle(fontFamily: ConstFont.popinsRegular, fontSize: 15),
              //                                                 //                                           hintText: "Reason for Reject ",
              //                                                 //                                         ),
              //                                                 //                                         validator: (value) {
              //                                                 //                                           if (value!.isEmpty) {
              //                                                 //                                             return "Propar Reason";
              //                                                 //                                           }
              //                                                 //                                           return null;
              //                                                 //                                         },
              //                                                 //                                       ),
              //                                                 //                                     ),
              //                                                 //                                     content: Row(
              //                                                 //                                       mainAxisAlignment: MainAxisAlignment.center,
              //                                                 //                                       children: [
              //                                                 //                                         ElevatedButton(
              //                                                 //                                           onPressed: () {
              //                                                 //                                             homeController.OrderUpdateApiCall("2", homeController.assignOrderList[index].orderId.toString(), homeController.reasonController.text);
              //                                                 //                                             Navigator.pop(context, false);
              //                                                 //                                           },
              //                                                 //                                           style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFECF3F9), elevation: 0),
              //                                                 //                                           child: const Text(
              //                                                 //                                             "Submit",
              //                                                 //                                             style: TextStyle(fontSize: 20, color: Colors.black),
              //                                                 //                                           ),
              //                                                 //                                         ),
              //                                                 //                                       ],
              //                                                 //                                     ),
              //                                                 //                                   );
              //                                                 //                                 });
              //                                                 //                           },
              //                                                 //                           child: const Text(
              //                                                 //                             "Reject",
              //                                                 //                             style: TextStyle(fontFamily: ConstFont.popinsRegular, color: Colors.white),
              //                                                 //                           ),
              //                                                 //                         ),
              //                                                 //                       ),
              //                                                 //                     ),
              //                                                 //                   ),
              //                                                 //                 ),
              //                                                 //               ],
              //                                                 //             ),
              //                                                 //           )
              //                                                 //         : (homeController.assignOrderList[index].orderStatus == 3 &&
              //                                                 //                 homeController.assignOrderList[index].orderStatus == 4)
              //                                                 //             ? Padding(
              //                                                 //                 padding: EdgeInsets.only(
              //                                                 //                   left: deviceWidth * 0.01,
              //                                                 //                 ),
              //                                                 //                 child: Row(
              //                                                 //                   children: [
              //                                                 //                     Padding(
              //                                                 //                       padding: EdgeInsets.only(left: deviceWidth * 0.01),
              //                                                 //                       child: Container(
              //                                                 //                         height: 25,
              //                                                 //                         width: 90,
              //                                                 //                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(1),),
              //                                                 //                         child: Center(
              //                                                 //                           child: ElevatedButton(
              //                                                 //                             style: ElevatedButton.styleFrom(
              //                                                 //                               primary: const Color(0xff6AB04C),
              //                                                 //                             ),
              //                                                 //                             onPressed: () {
              //                                                 //                               homeController.isChange = true.obs;
              //                                                 //                               homeController.OrderUpdateApiCall("3", homeController.assignOrderList[index].orderId.toString(), "");
              //                                                 //                               debugPrint("Delivered ");
              //                                                 //                             },
              //                                                 //                             child: Text(
              //                                                 //                               "Delivered",
              //                                                 //                               style: TextStyle(
              //                                                 //                                 fontFamily: ConstFont.popinsRegular,
              //                                                 //                                 color: SelectedValueIndex == 1 ? Colors.black : Colors.white,
              //                                                 //                                 //color: Colors.white
              //                                                 //                               ),
              //                                                 //                             ),
              //                                                 //                           ),
              //                                                 //                         ),
              //                                                 //                       ),
              //                                                 //                     ),
              //                                                 //                     Padding(
              //                                                 //                       padding: EdgeInsets.only(
              //                                                 //                           left: deviceWidth * 0.01,
              //                                                 //                           right: deviceWidth * 0.01),
              //                                                 //                       child: Container(
              //                                                 //                             height: 25,
              //                                                 //                             width: 75,
              //                                                 //                         decoration: BoxDecoration(
              //                                                 //                           borderRadius: BorderRadius.circular(1),
              //                                                 //                         ),
              //                                                 //                         child: Center(
              //                                                 //                           child: ElevatedButton(
              //                                                 //                             style: ElevatedButton.styleFrom(primary: const Color(0xffF86C6B)),
              //                                                 //                             onPressed: () {},
              //                                                 //                             child: InkWell(
              //                                                 //                               onTap: () async {
              //                                                 //                                 homeController.reasonController.clear();
              //                                                 //                                 final result = await showDialog(
              //                                                 //                                     context: context,
              //                                                 //                                     builder: (BuildContextcontext) {
              //                                                 //                                       return AlertDialog(
              //                                                 //                                         shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
              //                                                 //                                         backgroundColor: const Color(0xFFECF3F9),
              //                                                 //                                         title: Form(
              //                                                 //                                           key: formkey,
              //                                                 //                                           child: TextFormField(
              //                                                 //                                             controller: homeController.reasonController,
              //                                                 //                                             decoration: InputDecoration(
              //                                                 //                                               fillColor: const Color(0xFF0926C),
              //                                                 //                                               filled: true,
              //                                                 //                                               focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(5), borderSide: const BorderSide(color: Colors.black)),
              //                                                 //                                               border: OutlineInputBorder(
              //                                                 //                                                 borderRadius: BorderRadius.circular(10),
              //                                                 //                                               ),
              //                                                 //                                               enabledBorder: OutlineInputBorder(
              //                                                 //                                                 borderRadius: BorderRadius.circular(10),
              //                                                 //                                               ),
              //                                                 //                                               hintStyle: const TextStyle(fontFamily: ConstFont.popinsRegular, fontSize: 15),
              //                                                 //                                               hintText: "Reason for Not Deliver ",
              //                                                 //                                             ),
              //                                                 //                                             validator: (value) {
              //                                                 //                                               if (value!.isEmpty) {
              //                                                 //                                                 return "Why Not Deliver";
              //                                                 //                                               }
              //                                                 //                                               return null;
              //                                                 //                                             },
              //                                                 //                                           ),
              //                                                 //                                         ),
              //                                                 //                                         content: Row(
              //                                                 //                                           mainAxisAlignment: MainAxisAlignment.center,
              //                                                 //                                           children: [
              //                                                 //                                             ElevatedButton(
              //                                                 //                                               onPressed: () {
              //                                                 //                                                 homeController.OrderUpdateApiCall("4", homeController.assignOrderList[index].orderId.toString(), homeController.reasonController.text);
              //                                                 //                                                 Navigator.pop(context, false);
              //                                                 //                                               },
              //                                                 //                                               style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFECF3F9), elevation: 0),
              //                                                 //                                               child: const Text(
              //                                                 //                                                 "Submit",
              //                                                 //                                                 style: TextStyle(fontSize: 20, color: Colors.black),
              //                                                 //                                               ),
              //                                                 //                                             ),
              //                                                 //                                           ],
              //                                                 //                                         ),
              //                                                 //                                       );
              //                                                 //                                     });
              //                                                 //                               },
              //                                                 //                               child: const Text(
              //                                                 //                                 "Not Delivered",
              //                                                 //                                 style: TextStyle(fontFamily: ConstFont.popinsRegular, color: Colors.white),
              //                                                 //                               ),
              //                                                 //                             ),
              //                                                 //                           ),
              //                                                 //                         ),
              //                                                 //                       ),
              //                                                 //                     ),
              //                                                 //                   ],
              //                                                 //                 ),
              //                                                 //               )
              //                                                 //             : Text(
              //                                                 //                 (homeController.assignOrderList[index].orderStatus == 3)
              //                                                 //                     ? "Deliverd"
              //                                                 //                     : "Not Delivered",
              //                                                 //                 style: TextStyle(
              //                                                 //                     color: (homeController.assignOrderList[index].orderStatus == 2 || homeController.assignOrderList[index].orderStatus == 4 )  ? Colors.red : Colors.green,fontSize: 12,
              //                                                 //
              //                                                 //                     fontWeight: homeController.assignOrderList[index].orderStatus == 3
              //                                                 //                         ? FontWeight.bold
              //                                                 //                         : FontWeight.w500),
              //                                                 //               ),
              //                                                 //   ],
              //                                                 // ),
              //                                               ],
              //                                             ),
              //                                           )
              //                                         ],
              //                                       ),
              //                                     )
              //                                   ],
              //                                 )
              //                               ],
              //                             ),
              //                           )),
              //                     );
              //                   },
              //                 ),
              //         ),
              //       );
              //     } else {
              //       // This is a fallback in case something unexpected happens
              //       return Padding(
              //         padding: EdgeInsets.only(top: deviceHeight * 0.3),
              //         child: const Center(
              //             child: Text('Unexpected error',
              //                 style: TextStyle(
              //                   color: Colors.black,
              //                   fontFamily: ConstFont.popinsRegular,
              //                   fontSize: 18,
              //                   overflow: TextOverflow.ellipsis,
              //                 ))),
              //       );
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

}
