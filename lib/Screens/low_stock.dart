import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ConstFile/constFonts.dart';
import '../ConstFile/constImage.dart';

class lowstockPage extends StatefulWidget {
  const lowstockPage({Key? key}) : super(key: key);

  @override
  State<lowstockPage> createState() => _lowstockPageState();
}

class _lowstockPageState extends State<lowstockPage> {

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Image.asset("assets/Icons/drwar.png"),
        actions: [
          Image.asset("assets/Icons/notification.png")
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true ,
        title: Text("Low Stock",
          style: TextStyle(color: Colors.black),),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                right: deviceWidth*0.02,left: deviceWidth*0.02,bottom: deviceHeight*0.01),
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
          Padding(
            padding: EdgeInsets.only(left: deviceWidth*0.02,right: deviceWidth*0.02),
            child: Card(
              color: Color(0xffFFE4E3),
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
                        Image(image: AssetImage("assets/Images/cabbage.png"),
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
                                    child: Text("Savoy Cabbage",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: ConstFont.popinsRegular,
                                        color: Colors.black,
                                      ),),
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
                                                onPressed: () {},
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
                                    Text("Stock In\n90 Pic",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: ConstFont.popinsRegular,
                                          color: Colors.black
                                      ),),
                                    Text("Stock Out\n85 Pic",
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: ConstFont.popinsRegular,
                                          color: Colors.black
                                      ),),
                                    Text("Total Stock\n5 Pic",
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
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}
