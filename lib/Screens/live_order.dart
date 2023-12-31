import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery_distributor/Screens/order_details.dart';
import 'package:intl/intl.dart';

import '../ConstFile/constColor.dart';
import '../ConstFile/constFonts.dart';
import 'home_screen.dart';

class LiveorderPage extends StatefulWidget {
  const LiveorderPage({Key? key}) : super(key: key);

  @override
  State<LiveorderPage> createState() => _LiveorderPageState();
}

class _LiveorderPageState extends State<LiveorderPage> {
  List<String> productImage = [
    "assets/Images/frenchbeans.png",
    "assets/Images/beetroot.png",
    "assets/Images/Bitmap.png",
    "assets/Images/peas.png",
    "assets/Images/watermelon.png",
  ];
  List<String> productName = [
    "French Beans",
    "Beet Root",
    "Banana",
    "Peas",
    "Watermelon",
  ];
  List<String> Addresss = [
    "236, Tulsi Arcade, Sudama Chowk, Surat.",
    "236, Tulsi Arcade, Sudama Chowk, Surat.",
    "236, Tulsi Arcade, Sudama Chowk, Surat.",
    "236, Tulsi Arcade, Sudama Chowk, Surat.",
    "236, Tulsi Arcade, Sudama Chowk, Surat."
  ];
  List<String> Price = [
    '₹ 100.00',
    '₹ 59.00',
    '₹ 100.00',
    '₹ 24.00',
    '₹ 150.00',
  ];
  List<String> Kg = ["1 Kg", "2 Kg", "6 Pic", "500 Gm", "5 Kg"];
  List<int> color = [
    0xffE4EECB,
    0xffF0D0D8,
    0xffF3EDCD,
    0xffEEE9D8,
    0xffF5DBD2
  ];
  int? selectedValueIndex = 1;
  DateTime _selectedDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  String? selectedDateForBackedDeveloprt;

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  var startdate = DateTime.now().add(Duration(hours: -TimeOfDay.now().hour, minutes: -TimeOfDay.now().minute))
      .millisecondsSinceEpoch
      .obs;
  DateTime now = DateTime.now();
  var enddate = DateTime.now().add(Duration(hours: 1)).millisecondsSinceEpoch.obs;


  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                                        startdate.value = pickedDate.millisecondsSinceEpoch;
                                        setState(() {
                                          _startDate = pickedDate;
                                          endDate = startDate;
                                        });
                                      }
                                      print(DateFormat('yyyy-MM-dd').format(_startDate));
                                      print("millisecond" + startDate.toString());
                                    },
                                    icon: Icon(Icons.calendar_month_rounded)),
                                Text(DateFormat('MM-dd-yyyy').format(DateTime.fromMillisecondsSinceEpoch(startdate.value))),
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
                                        enddate.value = pickedDate.add(Duration(hours: 23, minutes: 59)).millisecondsSinceEpoch;
                                        setState(() {
                                          _endDate = pickedDate;
                                        });
                                      }
                                      print(DateFormat('yyyy-MM-dd').format(_endDate));
                                      print("millisecond" + enddate.toString());
                                      // getDateFromUser();
                                    },
                                    icon: Icon(Icons.calendar_month_rounded)),
                                Text(DateFormat('MM-dd-yyyy').format(DateTime.fromMillisecondsSinceEpoch(enddate.value)))
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
                            minimumSize:
                                Size(deviceWidth * 0.18, deviceHeight * 0.03),
                            maximumSize:
                                Size(deviceWidth * 0.20, deviceHeight * 0.03),
                            elevation: 0.5),
                        onPressed: () {
                          setState(() {
                            selectedValueIndex = 1;
                            print(selectedValueIndex);
                          });
                        },
                        child: Text(
                          "All",
                          style: TextStyle(
                              fontSize: 9,
                              color: selectedValueIndex == 1
                                  ? Colors.black
                                  : Colors.black,
                              fontFamily: ConstFont.popinsRegular),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: deviceWidth * 0.01),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide.none,
                                  borderRadius: BorderRadius.circular(3)),
                              backgroundColor: selectedValueIndex == 0
                                  ? ConstColour.primaryColor
                                  : ConstColour.cardBgColor,
                              minimumSize:
                                  Size(deviceWidth * 0.18, deviceHeight * 0.03),
                              maximumSize:
                                  Size(deviceWidth * 0.20, deviceHeight * 0.03),
                              elevation: 0.5),
                          onPressed: () {
                            setState(() {
                              selectedValueIndex = 0;
                              print(selectedValueIndex);
                            });
                          },
                          child: Text(
                            "5-10 Min",
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
                        padding: EdgeInsets.only(left: deviceWidth * 0.01),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide.none,
                                  borderRadius: BorderRadius.circular(3)),
                              backgroundColor: selectedValueIndex == 2
                                  ? ConstColour.primaryColor
                                  : ConstColour.cardBgColor,
                              minimumSize:
                                  Size(deviceWidth * 0.18, deviceHeight * 0.03),
                              maximumSize:
                                  Size(deviceWidth * 0.20, deviceHeight * 0.03),
                              elevation: 0.5),
                          onPressed: () {
                            setState(() {
                              selectedValueIndex = 2;
                              print(selectedValueIndex);
                            });
                          },
                          child: Text(
                            "24-48 Hr",
                            style: TextStyle(
                                fontSize: 9,
                                color: selectedValueIndex == 2
                                    ? Colors.black
                                    : Colors.black,
                                fontFamily: ConstFont.popinsRegular),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: deviceWidth * 0.01),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide.none,
                                  borderRadius: BorderRadius.circular(3)),
                              backgroundColor: selectedValueIndex == 3
                                  ? ConstColour.primaryColor
                                  : ConstColour.cardBgColor,
                              minimumSize:
                                  Size(deviceWidth * 0.18, deviceHeight * 0.03),
                              maximumSize:
                                  Size(deviceWidth * 0.20, deviceHeight * 0.03),
                              elevation: 0.5),
                          onPressed: () {
                            setState(() {
                              selectedValueIndex = 3;
                              print(selectedValueIndex);
                            });
                          },
                          child: Text(
                            "Daily",
                            style: TextStyle(
                                fontSize: 9,
                                color: selectedValueIndex == 3
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
                      padding: EdgeInsets.only(
                          left: deviceWidth * 0.00, right: deviceWidth * 0.00),
                      child: Card(
                          color: Color(0xffF3F4F4),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: deviceWidth * 0.01,
                                bottom: deviceHeight * 0.01,
                                right: deviceWidth * 0.01,
                                top: deviceHeight * 0.01),
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
                                      child: Image(
                                        image: AssetImage(
                                          productImage[index].toString(),
                                        ),
                                        fit: BoxFit.cover,
                                        height: 45,
                                        width: 65,
                                      ),
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: deviceHeight * 0.01),
                                                child: Text(
                                                  productName[index].toString(),
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: ConstFont.popinsRegular,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: deviceHeight * 0.01,
                                                        right: deviceHeight * 0.01),
                                                    child: Text(
                                                      Kg[index].toString(),
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        //fontWeight: FontWeight.bold,
                                                        fontFamily: ConstFont.popinsRegular,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: deviceHeight * 0.01),
                                            child: Row(
                                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Image.asset("assets/Icons/location.png"),
                                                Expanded(
                                                  child: Text(
                                                    Addresss[index].toString(),
                                                    style: TextStyle(
                                                        letterSpacing: 1.0,
                                                        fontSize: 10,
                                                        fontFamily: ConstFont.popinsRegular,
                                                        color: Colors.black),
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: deviceWidth * 0.01),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: deviceWidth * 0.01),
                                                  child: Text(Price[index].toString(),
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily: ConstFont.popinsRegular,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: deviceWidth * 0.01,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            left: deviceWidth * 0.01),
                                                        child: Container(
                                                          height: 25,
                                                          width: 90,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(1),
                                                          ),
                                                          child: Center(
                                                            child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(primary: Color(0xff6AB04C)),
                                                              onPressed: () {
                                                                Get.to(() => OrderdetailsPage());
                                                              },
                                                              child: Text(
                                                                "Accept",
                                                                style: TextStyle(
                                                                    fontFamily: ConstFont.popinsRegular,
                                                                    color: Colors.white),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            left: deviceWidth * 0.01,
                                                            right: deviceWidth * 0.01),
                                                        child: Container(
                                                          height: 25,
                                                          width: 80,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(1),
                                                          ),
                                                          child: Center(
                                                            child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(primary: Color(0xffF86C6B)),
                                                              onPressed: () {},
                                                              child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  final result =
                                                                      await showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return AlertDialog(
                                                                              shape: OutlineInputBorder(
                                                                                  borderRadius: BorderRadius.circular(16.0)),
                                                                              backgroundColor: Color(0xFFECF3F9),
                                                                              title: TextFormField(
                                                                                decoration: InputDecoration(
                                                                                  fillColor: Color(0xFF0926C),
                                                                                  filled: true,
                                                                                  focusedBorder: OutlineInputBorder(
                                                                                      borderRadius: BorderRadius.circular(5),
                                                                                      borderSide: BorderSide(color: Colors.black)
                                                                                  ),
                                                                                  border: OutlineInputBorder(
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                  ),
                                                                                  enabledBorder: OutlineInputBorder(
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                  ),
                                                                                  hintStyle: TextStyle(fontFamily: ConstFont.popinsRegular, fontSize: 15),
                                                                                  hintText: "Reason for Reject ",
                                                                                ),
                                                                              ),
                                                                              content: Row(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  ElevatedButton(
                                                                                    onPressed: () {
                                                                                      Navigator.pop(context, false);
                                                                                    },
                                                                                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                                                                                    child: Text("Submit"),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          });
                                                                },
                                                                child: Text(
                                                                  "Reject",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          ConstFont
                                                                              .popinsRegular,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
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
                          )),
                    );
                  },
                ),
              ],
            ),
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
