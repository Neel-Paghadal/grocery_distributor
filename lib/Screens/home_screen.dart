import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/ConstFile/constColor.dart';
import 'package:grocery_distributor/ConstFile/constFonts.dart';
import 'package:grocery_distributor/ConstFile/constPreferences.dart';
import 'package:grocery_distributor/Controllers/home_controller.dart';
import 'package:grocery_distributor/Screens/loader.dart';
import '../Common/BottomBarScreen.dart';
import 'home_drawer.dart';
import 'live_order.dart';
import 'product_detail.dart';

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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());


  int? selectedValueIndex = 0;
  List<int> SelectedValueIndex = [1, 2, 3, 4, 5];
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  final formkey = GlobalKey<FormState>();

  moveTohome(BuildContext context) async {
    if (formkey.currentState!.validate()) {}
  }

  final _random = Random();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.LiveOrderApiCall();
    homeController.getDistributorData();
    homeController.currentIndex = 0;
    setState(() {

    });
    // homeController.AssignOrderApiCall(homeController.orderType.toString(),homeController.distributorId.toString());
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _globalKey,
      backgroundColor: ConstColour.bgColor,
      drawer: HomeDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Dashboard",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, // Change this color to your desired color
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {},
        //       icon: Image.asset("assets/Icons/notification.png"))
        // ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: deviceHeight * 0.01, /*bottom: deviceHeight * 0.01*/
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xff81ECEC)),
                        height: deviceHeight * 0.08,
                        child: Padding(
                          padding: EdgeInsets.only(left: deviceWidth * 0.04),
                          child: const Column(
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
                    SizedBox(width: deviceWidth * 0.02),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xffFEA47F)),
                        height: deviceHeight * 0.08,
                        child: Padding(
                          padding: EdgeInsets.only(left: deviceWidth * 0.04),
                          child: const Column(
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
                  const Text(
                    "Live Order",
                    style: TextStyle(
                      fontFamily: ConstFont.popinsRegular,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      homeController.orderType = 0;
                      Get.to(() => LiveorderPage());
                      Get.to(BottomBarScreen(),
                          arguments: homeController.currentIndex = 1);
                      setState(() {});
                    },
                    child: const Text(
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
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: deviceHeight * 0.03,
                  child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        homeController.liveOrderList.isEmpty ? Center(child: Text("No Data Avaliable")) :   ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          controller: ScrollController(),
                          itemCount: homeController.liveOrderList.length,
                          itemBuilder: (context, index) {
                            return homeController
                                        .liveOrderList[index].filterType ==
                                    "All"
                                ? SizedBox()
                                : Padding(
                                    padding: EdgeInsets.only(
                                        right: deviceWidth * 0.01),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          backgroundColor:
                                              selectedValueIndex == index
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
                                              homeController
                                                  .liveOrderList[index].id;
                                          selectedValueIndex = index;
                                          print(selectedValueIndex);
                                          homeController.AssignOrderApiCall(
                                              homeController.orderType
                                                  .toString(),
                                              homeController.distributorId
                                                  .toString());
                                        });
                                      },
                                      child: Text(
                                        homeController.liveOrderList[index]
                                                    .filterType ==
                                                "All"
                                            ? ""
                                            : homeController
                                                .liveOrderList[index]
                                                .filterType,
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: selectedValueIndex == index
                                                ? Colors.black
                                                : Colors.black,
                                            fontFamily:
                                                ConstFont.popinsRegular),
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

              FutureBuilder<dynamic>(
                future:  homeController.AssignOrderApiCall(homeController.orderType.toString(), homeController.distributorId.toString()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display shimmer while waiting for data
                    return Flexible(
                      child: Loaders(
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
                      ),
                    );
                  } else if (snapshot.hasError) {
                    // Handle error
                    return Padding(
                      padding:  EdgeInsets.only(top: deviceHeight * 0.3),
                      child: Center(child: Text('Error: ${snapshot.error}',style: TextStyle(color: Colors.black,fontFamily: ConstFont.popinsRegular,fontSize: 18,overflow: TextOverflow.ellipsis,),)),
                    );
                  } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                    // Display "No data available" message
                    return Padding(
                      padding:  EdgeInsets.only(top: deviceHeight * 0.3),
                      child: Center(child: Text('No data available',style: TextStyle(color: Colors.black,fontFamily: ConstFont.popinsRegular,fontSize: 18,overflow: TextOverflow.ellipsis,))),
                    );
                  } else if (snapshot.hasData) {
                    // Display the fetched data
                    return
                      Flexible(
                        child: Obx(
                              () =>  ListView.builder(
                            controller: ScrollController(),
                            scrollDirection: Axis.vertical,
                            itemCount: homeController.assignOrderList.length > 10 ? 10
                                : homeController.assignOrderList.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  Get.to(() => ProductDetailPage(productIndex: index,));
                                  print("productId" + homeController.assignOrderList[index].productId.toString());
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
                                                child:  Image(
                                                  width: deviceWidth * 0.1,
                                                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                    // Custom error widget to display when image fails to load
                                                    return Icon(Icons.image,size: 45,);
                                                  },
                                                  image:  NetworkImage(
                                                    homeController.assignOrderList[index].imageName.toString(),),
                                                ),

                                                // Image.network(homeController
                                                //     .assignOrderList[index]
                                                //     .imageName
                                                //     .toString()),
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
                                                                  right:
                                                                  deviceHeight *
                                                                      0.01),
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
                                                                  ),Text(
                                                                    homeController
                                                                        .assignOrderList[
                                                                    index]
                                                                        .quantity
                                                                        .toString(),
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
                                                          left:
                                                          deviceWidth * 0.01,bottom: deviceHeight * 0.01),
                                                      child: Row(
                                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Image.asset(
                                                              "assets/Icons/pin.png",width: deviceWidth * 0.04),
                                                          Expanded(
                                                            child: Text(
                                                              " "+homeController
                                                                  .assignOrderList[index].address.toString(),
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
                                                          left: deviceWidth * 0.01),
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

                                                              homeController.assignOrderList[index].orderStatus == 0  ?
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
                                                                              primary:
                                                                              const Color(0xff6AB04C),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              homeController.assignOrderList[index].orderStatus = 1;
                                                                              homeController.OrderUpdateApiCall("1",homeController.assignOrderList[index].orderId.toString(),"");
                                                                              setState(() {});
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
                                                                                        backgroundColor : Colors.white,
                                                                                        actions: [
                                                                                          Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              ElevatedButton(
                                                                                                onPressed: () {
                                                                                                  if(formkey.currentState!.validate()){
                                                                                                    homeController.assignOrderList[index].orderStatus = 2;
                                                                                                    homeController.OrderUpdateApiCall("2", homeController.assignOrderList[index].orderId.toString(), homeController.reasonController.text);
                                                                                                    setState(() {});
                                                                                                    Navigator.pop(context, false);
                                                                                                  }

                                                                                                },
                                                                                                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFECF3F9), elevation: 0),
                                                                                                child: const Text(
                                                                                                  "Submit",
                                                                                                  style: TextStyle(fontSize: 20, color: Colors.black),
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          )
                                                                                        ],
                                                                                        title:  Text("Enter Your Reason Why Product Not Delivered",style: TextStyle(
                                                                                            fontFamily: ConstFont.popinsRegular
                                                                                        )),
                                                                                        content:Form(
                                                                                          key: formkey,
                                                                                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                                              (homeController.assignOrderList[index].orderStatus !=  3 && homeController.assignOrderList[index].orderStatus != 4)
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
                                                                                      backgroundColor: Colors.white,

                                                                                      actions: [
                                                                                        Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: [
                                                                                            ElevatedButton(
                                                                                              onPressed: () {
                                                                                                if(formkey.currentState!.validate()){
                                                                                                  homeController.assignOrderList[index].orderStatus = 4;
                                                                                                  homeController.OrderUpdateApiCall("4", homeController.assignOrderList[index].orderId.toString(), homeController.reasonController.text);
                                                                                                  setState(() {});
                                                                                                  Navigator.pop(context, false);

                                                                                                }

                                                                                              },
                                                                                              style: ElevatedButton.styleFrom(backgroundColor : ConstColour.primaryColor, elevation: 0),
                                                                                              child: const Text(
                                                                                                "Submit",
                                                                                                style: TextStyle(fontSize: 20, color: Colors.white),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                      title   :   Text("Enter Your Reason Why Product Not Delivered",style: TextStyle(
                                                                                          fontFamily: ConstFont.popinsRegular
                                                                                      )),
                                                                                      content:     Form(
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
                      );
                  } else {
                    // This is a fallback in case something unexpected happens
                    return Padding(
                      padding:  EdgeInsets.only(top: deviceHeight * 0.3),
                      child: Center(child: Text('Unexpected error',style: TextStyle(color: Colors.black,fontFamily: ConstFont.popinsRegular,fontSize: 18,overflow: TextOverflow.ellipsis,))),
                    );
                  }
                },
              ),












            ],
          ),
        ),
      ),
    );
  }
}
