import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/Common/appBar.dart';
import 'package:grocery_distributor/ConstFile/constColor.dart';
import 'package:grocery_distributor/ConstFile/constFonts.dart';
import 'package:grocery_distributor/Controllers/home_controller.dart';

class ProductDetailPage extends StatefulWidget {
   int productIndex;
   ProductDetailPage({required this.productIndex});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  HomeController homeController = Get.put(HomeController());
  List<int> SelectedValueIndex = [1, 2, 3, 4, 5];
  final formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    debugPrint("rebuild");
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(deviceWidth, deviceHeight),
          child: DetailsAppbar(
            title: 'All Categories',
            onPressed: () {
              Get.back();

            },
            onTap: () {},
          )),
      body: SingleChildScrollView(
        controller: ScrollController(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
              ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                controller: ScrollController(),
                itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment:  CrossAxisAlignment.start,
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: ConstColour.cardBgColor,
                      ),
                      height: deviceHeight * 0.25,
                       child:   Image(
                         width: deviceWidth * 2.0,
                         errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                           // Custom error widget to display when image fails to load
                           return Icon(Icons.image,size: 45,);
                         },
                         image:  NetworkImage(
                           homeController.assignOrderList[widget.productIndex].imageName,),
                       ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width:  deviceWidth * 0.6,
                          child: Text( homeController.assignOrderList[widget.productIndex].productName,style: TextStyle(fontSize: 16,color: Colors.black,fontFamily: ConstFont.popinsMedium),maxLines: 1,overflow: TextOverflow.ellipsis)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text("Quantity : ",style: TextStyle(fontSize: 16,color: Colors.black,fontFamily: ConstFont.popinsRegular),maxLines: 1,overflow: TextOverflow.ellipsis),
                            Text( homeController.assignOrderList[widget.productIndex].quantity.toString(),style: TextStyle(fontSize: 16,color: Colors.black,fontFamily: ConstFont.popinsMedium),maxLines: 1,overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("₹ ${homeController.assignOrderList[widget.productIndex].totalAmount.toString()}",style: TextStyle(fontSize: 16,color: Colors.black,fontFamily: ConstFont.popinsRegular),maxLines: 1,overflow: TextOverflow.ellipsis),
                        Text( homeController.assignOrderList[widget.productIndex].unitType,style: TextStyle(fontSize: 16,color: Colors.black,fontFamily: ConstFont.popinsRegular),maxLines: 1,overflow: TextOverflow.ellipsis),

                      ],
                    ),
                  ),
                    Padding(
                      padding:
                      EdgeInsets.only(top: deviceHeight * 0.01),
                      child: Container(
                        color: ConstColour.cardBgColor,
                        child: ExpandablePanel(
                          theme: ExpandableThemeData(
                            // alignment: Alignment.center,
                              hasIcon: true,
                              iconSize: 24,
                              fadeCurve: Curves.slowMiddle,
                              iconPadding: EdgeInsets.only(
                                  top: deviceHeight * 0.02,
                                  right: deviceWidth * 0.02)),
                          header: Padding(
                            padding: EdgeInsets.only(
                                top: deviceHeight * 0.025,
                                left: deviceWidth * 0.04),
                            child: const Text("Product Description",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily:
                                    ConstFont.popinsRegular)),
                          ),
                          collapsed: const Text(
                            "",
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          expanded: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              homeController
                                  .assignOrderList[widget.productIndex].discription
                                  .toString(),
                              softWrap: true,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily:
                                  ConstFont.popinsRegular),
                            ),
                          ),
                        ),
                      ),
                    ),
                    homeController.assignOrderList[widget.productIndex].orderStatus == 0
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
                  maximumSize: Size(deviceWidth * 0.4, deviceHeight * 0.06),
                  minimumSize: Size(deviceWidth * 0.4, deviceHeight * 0.05),
                                    backgroundColor: const Color(0xff6AB04C),
                                  ),
                                  onPressed:
                                      () {
                                    homeController.assignOrderList[widget.productIndex].orderStatus = 1;
                                    homeController.OrderUpdateApiCall("1", homeController.assignOrderList[widget.productIndex].orderId.toString(), "");
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
                                  ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xffF86C6B),
                                      maximumSize: Size(deviceWidth * 0.4, deviceHeight * 0.06),
                                      minimumSize: Size(deviceWidth * 0.4, deviceHeight * 0.05)
                                  ),

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
                                              backgroundColor: Colors.white,
                                               actions: [
                                                 Row(
                                                   mainAxisAlignment: MainAxisAlignment.center,
                                                   children: [
                                                     ElevatedButton(
                                                       onPressed: () {
                                                         if(formkey.currentState!.validate()){
                                                           homeController.assignOrderList[widget.productIndex].orderStatus = 2;
                                                           homeController.OrderUpdateApiCall("2", homeController.assignOrderList[widget.productIndex].orderId.toString(), homeController.reasonController.text);
                                                           setState(() {});
                                                           Navigator.pop(context, false);
                                                         }

                                                       },
                                                       style: ElevatedButton.styleFrom(backgroundColor: ConstColour.primaryColor, elevation: 0),
                                                       child: const Text( "Submit", style: TextStyle(fontSize: 20, color: Colors.white,fontFamily: ConstFont.popinsRegular,),),
                                                     ),
                                                   ],
                                                 )
                                               ],
                                              title   :   Text("Enter Your Reason Why Product Not Delivered",style: TextStyle(
                                                  fontFamily: ConstFont.popinsRegular
                                              )),

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
                                                      return "Enter Propar Reason";
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
                    (homeController.assignOrderList[widget.productIndex].orderStatus !=  3 &&
                        homeController.assignOrderList[widget.productIndex].orderStatus != 4)
                        ? Padding(
                      padding: EdgeInsets.only( left:deviceWidth *  0.01,top: deviceHeight * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding:
                            EdgeInsets.only(left: deviceWidth * 0.01),
                            child: Center(
                              child:
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff6AB04C),
                                  maximumSize: Size(deviceWidth * 0.4, deviceHeight * 0.06),
                                  minimumSize: Size(deviceWidth * 0.4, deviceHeight * 0.05)
                                ),
                                onPressed: () {
                                  homeController.assignOrderList[widget.productIndex].orderStatus = 3;
                                  homeController.OrderUpdateApiCall("3", homeController.assignOrderList[widget.productIndex].orderId.toString(), "");
                                  setState(() {});
                                  print("Delivered ");
                                },
                                child: Text(
                                  "Delivered",
                                  style: TextStyle(
                                    fontFamily: ConstFont.popinsRegular,
                                    fontSize: 16,
                                    color: SelectedValueIndex == 1 ? Colors.black : Colors.white,
                                    //color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child:
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                // primary: const Color(0xffF86C6B)
                                  backgroundColor: Colors.white,
                                  maximumSize: Size(deviceWidth * 0.4, deviceHeight * 0.06),
                                  minimumSize: Size(deviceWidth * 0.4, deviceHeight * 0.05)
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
                                          // backgroundColor: const Color(0xFFECF3F9),
                                          backgroundColor: Colors.white,
                                          actions: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                ElevatedButton(

                                                  onPressed: () {
                                                    if(formkey.currentState!.validate()){
                                                      homeController.assignOrderList[widget.productIndex].orderStatus = 4;
                                                      homeController.OrderUpdateApiCall("4", homeController.assignOrderList[widget.productIndex].orderId.toString(), homeController.reasonController.text);
                                                      setState(() {});
                                                      Navigator.pop(context, false);
                                                    }

                                                  },
                                                  style: ElevatedButton.styleFrom(backgroundColor: ConstColour.primaryColor, elevation: 0),
                                                  child: const Text( "Submit", style: TextStyle(fontSize: 20, color: Colors.white,fontFamily: ConstFont.popinsRegular,),),
                                                ),
                                              ],
                                            ),
                                          ],
                                         title   :   Text("Enter Your Reason Why Product Not Delivered",style: TextStyle(
                                           fontFamily: ConstFont.popinsRegular
                                         )),

                                            content :    Form(
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
                                                    return "Enter Your Reason Why Product Not Delivered";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            )

                                        );
                                      });
                                },
                                child: const Text(
                                  "Not Delivered",
                                  style: TextStyle(fontFamily: ConstFont.popinsMedium, color: Colors.red,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                        : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                      (homeController.assignOrderList[widget.productIndex].orderStatus == 3)
                              ? "Delivered"
                              : "Not Delivered",
                      style: TextStyle(
                            color: (homeController.assignOrderList[index].orderStatus == 2 || homeController.assignOrderList[widget.productIndex].orderStatus == 4 )  ? Colors.red : Colors.green,fontSize: 20,
                      ),
                    ),
                          ),
                        ),
                ],);
              },)
          ],
        ),
      ),
    );
  }
}
