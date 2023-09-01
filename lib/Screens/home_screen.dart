
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/Common/appBar.dart';
import 'package:grocery_distributor/ConstFile/constColor.dart';
import 'package:grocery_distributor/ConstFile/constFonts.dart';
import 'package:grocery_distributor/Screens/godown_stock.dart';
import 'package:grocery_distributor/Screens/low_stock.dart';
import 'package:grocery_distributor/Screens/user_list.dart';

import 'live_order.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> productImage=["assets/Images/frenchbeans.png","assets/Images/beetroot.png","assets/Images/Bitmap.png","assets/Images/peas.png","assets/Images/watermelon.png",];
  List<String> productName=["French Beans","Beet Root","Banana","Peas","Watermelon",];
  List<String> Addresss=["236, Tulsi Arcade, Sudama Chowk, Surat. ","236, Tulsi Arcade, Sudama Chowk, Surat.","236, Tulsi Arcade, Sudama Chowk, Surat.","236, Tulsi Arcade, Sudama Chowk, Surat.","236, Tulsi Arcade, Sudama Chowk, Surat."];
  List<String> Price=['₹ 100.00','₹ 59.00','₹ 100.00','₹ 24.00','₹ 150.00',];
  List<String> Kg=["1 Kg","2 Kg","6 Pic","500 Gm","5 Kg"];
  List<int> color=[0xffE4EECB,0xffF0D0D8,0xffF3EDCD,0xffEEE9D8,0xffF5DBD2];
  int? selectedValueIndex = 1;
  List<int> SelectedValueIndex=[1,2,3,4,5] ;
  final GlobalKey<ScaffoldState> _globalKey=GlobalKey();
  final formkey=GlobalKey<FormState>();

  moveTohome (BuildContext context)async{
    if(formkey.currentState!.validate()) { //formkey use kri means k jo validate hase to bija page par jase baki erroe show thase
    }
  }
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        items: [
          BottomNavigationBarItem(label:"",icon: Image.asset("assets/Icons/home.png"),backgroundColor: Colors.white,),
          BottomNavigationBarItem(label:" ",icon: Image.asset("assets/Icons/document.png")),
          BottomNavigationBarItem(label:" ",icon: Image.asset("assets/Icons/walet.png")),
          BottomNavigationBarItem(label:" ",icon: Image.asset("assets/Icons/question.png")),
        ],
      ),
      key: _globalKey,
      backgroundColor: ConstColour.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Dashboard",
          style: TextStyle(color: Colors.black),),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, // Change this color to your desired color
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Image.asset("assets/Icons/notification.png"))
        ],
      ),
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
                              height: deviceHeight * 0.08,
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
                              height: deviceHeight * 0.08,
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

                          Padding(
                            padding:  EdgeInsets.only(left: deviceWidth*0.01),
                            child: ElevatedButton(
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
                          ),
                          Padding(
                            padding:  EdgeInsets.only(left: deviceWidth*0.01),
                            child: ElevatedButton(
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
                            ),
                          )
                        ],
                      ),
                    ),
                    ListView.builder(
                      controller: ScrollController(),
                      itemCount: 5,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(left: deviceWidth*0.00,right: deviceWidth*0.00),
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
                                          //mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Color(color[index].toInt()),
                                              ),
                                              height: 60,
                                              width: 72,
                                              child: Image(image: AssetImage(productImage[index].toString(),),
                                                fit: BoxFit.cover,
                                                height: 45,
                                                width: 65,
                                              ),
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
                                                        child: Text(productName[index].toString(),
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontFamily: ConstFont.popinsRegular,
                                                            color: Colors.black,
                                                            fontWeight: FontWeight.w500
                                                          ),),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          Padding(
                                                            padding:  EdgeInsets.only(left: deviceHeight*0.01,right: deviceHeight*0.01),
                                                            child: Text(Kg[index].toString(),
                                                              style: TextStyle(
                                                                fontSize: 10,
                                                                //fontWeight: FontWeight.bold,
                                                                fontFamily: ConstFont.popinsRegular,
                                                                color: Colors.black,
                                                              ),),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(padding: EdgeInsets.only(left: deviceHeight*0.01),
                                                    child: Row(
                                                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Image.asset("assets/Icons/location.png"),
                                                        Expanded(
                                                          child: Text(Addresss[index].toString(),
                                                            overflow: TextOverflow.ellipsis,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                letterSpacing: 1.0,
                                                                fontSize: 10,
                                                                fontFamily: ConstFont.popinsRegular,
                                                                color: Colors.black
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(padding: EdgeInsets.only(left: deviceWidth*0.01),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:  EdgeInsets.only(left: deviceWidth*0.01),
                                                          child: Text(Price[index].toString(),
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w500,
                                                                fontFamily: ConstFont.popinsRegular,

                                                                color: Colors.black
                                                            ),),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.only(left: deviceWidth*0.01,),
                                                          child: Row(
                                                            //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(left: deviceWidth*0.01),
                                                                child: Container(
                                                                  height:25,
                                                                  width:90,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(1),
                                                                  ),
                                                                  child: Center(
                                                                    child: ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(primary: Color(0xff6AB04C),),
                                                                        // backgroundColor:SelectedValueIndex==1
                                                                        //     ? Color(0xff6AB04C)
                                                                        //     : Color(0xff6AB04C),),
                                                                      onPressed: () {
                                                                        setState(() {
                                                                          SelectedValueIndex.toString();
                                                                          print(SelectedValueIndex);
                                                                        });
                                                                        // SelectedValueIndex.toString();
                                                                        // print(SelectedValueIndex);
                                                                        Get.to(() => LiveorderPage());
                                                                      },
                                                                      child: Text("Accept",
                                                                        style: TextStyle(
                                                                            fontFamily: ConstFont.popinsRegular,
                                                                            color: SelectedValueIndex==1
                                                                                ? Colors.black
                                                                                : Colors.black,
                                                                            //color: Colors.white
                                                                        ),),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(left: deviceWidth*0.01,right: deviceWidth*0.01),
                                                                child: Container(
                                                                  height: 25,
                                                                  width: 75,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(1),
                                                                  ),
                                                                    child: Center(
                                                                      child: ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(primary: Color(0xffF86C6B)),
                                                                         onPressed: (){},
                                                                        child: InkWell(
                                                                          onTap: ()async{
                                                                            final result=await showDialog(context: context, builder: (BuildContext context){
                                                                              return AlertDialog(
                                                                                backgroundColor: Colors.grey.shade100,
                                                                                title: Form(
                                                                                  key: formkey,
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
                                                                                      hintText: "Reason for Reject ",
                                                                                    ),
                                                                                    validator: (value){
                                                                                      if(value!.isEmpty){
                                                                                        return "Propar Reason";
                                                                                      }
                                                                                      return null;
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                                content:  Row(
                                                                                   mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    ElevatedButton(onPressed: (){
                                                                                      Navigator.pop(context,false);
                                                                                    },
                                                                                      style: ElevatedButton.styleFrom(
                                                                                          backgroundColor: Colors.grey
                                                                                      ),
                                                                                      child: Text("Submit"),),
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            });
                                                                          },
                                                                          child: Text("Reject",
                                                                            style: TextStyle(
                                                                                fontFamily: ConstFont.popinsRegular,
                                                                                color: Colors.white
                                                                            ),),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
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
                                  )
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
      drawer : Drawer(
        child: Container(
          color: Colors.white, //<-- SEE HERE
          child: Padding(
            padding: EdgeInsets.only(left: deviceWidth*0.00,right: deviceWidth*0.00,top: deviceHeight*0.04),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xffF3F4F4),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  // width: 254,
                  // height: 75,
                  margin: EdgeInsets.only(left: deviceWidth*0.05,right: deviceWidth*0.05),
                  //color: Color(0xffF3F4F4),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Image.asset("assets/Images/drawerdp.png"),
                                title: Text("Vidya Vox",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black
                                ),),
                                subtitle: Text("236, Tulsi Arcade, Sudama\nChowk, Surat.",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black
                                ),),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
                ListTile(
                  leading: Image.asset("assets/Icons/order.png"),
                  onTap: (){
                    Get.to(LiveorderPage());
                  },
                  title: Text("Live Orders",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: ConstFont.popinsRegular,
                      color: Colors.black,
                    ),),
                ),
                ListTile(
                  leading: Image.asset("assets/Icons/user.png"),
                  onTap: (){
                    Get.to(UserPage());
                  },
                  title: Text("User List",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: ConstFont.popinsRegular,
                      color: Colors.black,
                    ),),
                ),
                ListTile(
                  leading: Image.asset("assets/Icons/godowan.png"),
                  onTap: (){
                    Get.to(GodownPage());
                  },
                  title: Text("Godown Stock",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: ConstFont.popinsRegular,
                      color: Colors.black,
                    ),),
                ),
                ListTile(
                  leading: Image.asset("assets/Icons/product.png"),
                  onTap: (){},
                  title: Text("Product Info",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: ConstFont.popinsRegular,
                      color: Colors.black,
                    ),),
                ),
                ListTile(
                  leading: Image.asset("assets/Icons/low.png"),
                  onTap: (){
                    Get.to(lowstockPage());
                  },
                  title: Text("Low Stock",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: ConstFont.popinsRegular,
                      color: Colors.black,
                    ),),
                ),
                ListTile(
                  leading: Image.asset("assets/Icons/ads.png"),
                  onTap: (){},
                  title: Text("Ads",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: ConstFont.popinsRegular,
                      color: Colors.black,
                    ),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
