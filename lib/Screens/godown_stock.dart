import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery_distributor/Screens/order_details.dart';
import 'package:grocery_distributor/Screens/user_list.dart';

import '../Common/BottomBarScreen.dart';
import '../ConstFile/constFonts.dart';
import '../ConstFile/constImage.dart';
import '../Controllers/home_controller.dart';
import 'low_stock.dart';

class GodownPage extends StatefulWidget{
  const GodownPage({Key? key,}):super(key: key);

  @override
  GodownPageState createState() => GodownPageState();
}
class GodownPageState extends State<GodownPage>{


  List<String> productName=["Onion Normal","Paprica","Savoy Cabbage","Sweet Potatoes"];
  List<String> productImage=[ConstImage.onion,ConstImage.paprica,ConstImage.cabbage,ConstImage.sweet];
  List<String> productstockin=["Stock In\n300 Kg","Stock In\n100 Kg","Stock In\n90 Pic","Stock In\n150 Kg"];
  List<String> productstockout=["Stock Out\n100 Kg","Stock Out\n50 Kg","Stock Out\n85 Pic","Stock Out\n60 Kg"];
  List<String> productstotalstock=["Total Stock\n200 Kg","Total Stock\n50 Kg","Total Stock\n5 Pic","Total Stock\n90 Kg"];

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context){
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Get.to(() => BottomBarScreen(),arguments: {homeController.currentIndex = 0});

        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,),),
        actions: [
          Image.asset("assets/Icons/notification.png")
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true ,
        title: Text("Godown Stock",
          style: TextStyle(color: Colors.black),),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                right: deviceWidth*0.02,left: deviceWidth*0.02,bottom: deviceHeight*0.01
            ),
            child: TextFormField(
              decoration: InputDecoration(
                fillColor: Color(0xffF3F4F4),
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2),
                    borderSide: BorderSide.none
                ),
                hintStyle: TextStyle(
                    fontFamily: ConstFont.popinsRegular,
                    fontSize: 15),
                hintText: "Search Product Name",
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: EdgeInsets.only(left: deviceWidth*0.02,right: deviceWidth*0.02),
                      child: Card(
                        color: Color(0xffF3F4F4),
                        child: Padding(
                          padding: EdgeInsets.only(left: deviceWidth*0.01,bottom: deviceHeight*0.01,right: deviceWidth*0.01,top: deviceHeight*0.01),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Image(image: AssetImage(productImage[index].toString()),
                                      fit: BoxFit.cover,
                                      width:60,
                                      height: 60,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:  EdgeInsets.only(left: deviceHeight*0.01),
                                                child: Expanded(
                                                  child: Text(productName[index].toString(),
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: ConstFont.popinsRegular,
                                                      color: Colors.black,
                                                    ),
                                                      overflow: TextOverflow.ellipsis,
                                                  maxLines: 1,),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: deviceHeight*0.01,right: deviceHeight*0.01),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(left: deviceWidth*0.01,right: deviceWidth*0.01),
                                                      child: Container(
                                                        height:25,
                                                        width:62,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(2),
                                                        ),
                                                        child: Center(
                                                          child: ElevatedButton(
                                                            style: ElevatedButton.styleFrom(primary: Color(0xff6AB04C)),
                                                            onPressed: () {
                                                              Get.to(()=>lowstockPage());
                                                            },
                                                            child: Text("Add",
                                                              style: TextStyle(
                                                                  fontFamily: ConstFont.popinsRegular,
                                                                  color: Colors.white
                                                              ),),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(left: deviceWidth*0.01,right: deviceWidth*0.01),
                                                      child: Container(
                                                        height: 25,
                                                        width: 60,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(2),
                                                        ),
                                                        child: Center(
                                                          child: ElevatedButton(
                                                            style: ElevatedButton.styleFrom(primary: Color(0xffF86C6B)),
                                                            onPressed: (){},
                                                            child: Text("Out",
                                                              style: TextStyle(
                                                                  fontFamily: ConstFont.popinsRegular,
                                                                  color: Colors.white
                                                              ),),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: deviceHeight*0.01,top: deviceHeight*0.01,right: deviceHeight*0.01),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(productstockin[index].toString(),
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: ConstFont.popinsRegular,
                                                      color: Colors.black
                                                  ),),
                                                Text(productstockout[index].toString(),
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: ConstFont.popinsRegular,
                                                      color: Colors.black
                                                  ),),
                                                Text(productstotalstock[index].toString(),
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontFamily: ConstFont.popinsRegular,
                                                      color: Colors.black
                                                  ),),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ]
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
          )
        ],
      ),
    );
  }
}