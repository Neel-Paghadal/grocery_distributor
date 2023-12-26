import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/ConstFile/constApi.dart';
import 'package:grocery_distributor/ConstFile/constFonts.dart';
import 'package:grocery_distributor/Model/orderGenrate_model.dart';
import 'package:grocery_distributor/Screens/order_genrate.dart';
import 'package:http/http.dart' as http;

import '../ConstFile/constColor.dart';
import '../Model/procutPrice_model.dart';

class OrderGenrateController extends GetxController{

  TextEditingController allSearchController = TextEditingController();
  TextEditingController quntityController = TextEditingController();

  RxList<GenrateOrder> ordergenrateList = <GenrateOrder>[].obs;
  RxList<ProductPriceDetail> orderPriceList = <ProductPriceDetail>[].obs;

  void showDialogs(context) {
    var deviceHeight = MediaQuery
        .of(context)
        .size
        .height;
    var deviceWidth = MediaQuery
        .of(context)
        .size
        .width;

    showDialog(
      useSafeArea: true,
      barrierDismissible: true,
      context: context,
      builder: (context) =>
          StatefulBuilder(
            builder: (context, setState) =>
                Dialog(
                  backgroundColor: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          autofocus: true,
                          controller: quntityController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelStyle:  const TextStyle(color: Colors.black),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                              ),
                              border: InputBorder.none,
                              filled: true,
                              isDense: true,
                              hintText: "Enter Products Quantity",
                              hintStyle: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: ConstFont.popinsRegular,
                                  fontSize: 16,
                                  overflow: TextOverflow.ellipsis),
                              prefixIcon: Icon( CupertinoIcons.search,size: 24,color: ConstColour.primaryColor,)
                          ),

                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ConstColour.primaryColor,
                                maximumSize: Size(
                                    deviceWidth * 0.4, deviceHeight * 0.055),
                                minimumSize: Size(
                                    deviceWidth * 0.3, deviceHeight * 0.05),
                                // backgroundColor: Colors.white
                              ),
                              onPressed: () {
                                Get.back();
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
                        ),
                      ],
                    )),
          ),
    ).whenComplete(() {
    });
  }

  int? messageCode;


  Future<void> productPriceCall(int id) async {
    final response = await http.post(Uri.parse(ConstApi.productWisePriceList),
        body: {
          "ProductId" : id.toString()
        });
    var data = response.body;
    debugPrint("Product Price List : " +data);

    if (response.statusCode == 200) {
      final responseData = priceDetailFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint(messageCode.toString());

      if (messageCode == 200) {
        orderPriceList.clear();
        orderPriceList.addAll(responseData.data);

        debugPrint("Product Price Successfully");

      } else {
        debugPrint("Error Price Get");
      }
    } else {}
  }



    orderGenrateApiCall(int pageIndex, int pageSize,)async {
    final response = await http.post(Uri.parse(ConstApi.orderGenrate),

        body: {
          "PageIndex" :pageIndex.toString(),
          "PageSize" :pageSize.toString(),
          "Keyword" :   ""
        }
    );
    var data = response.body;
    debugPrint("order genrate List : $data");


    if (response.statusCode == 200) {
      final responseData = orderGenrateFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint("LiveOrder : $messageCode");

      if (messageCode == 200) {
        // ordergenrateList.clear();
        ordergenrateList.addAll(responseData.data);
        debugPrint("order genrate Successfully ");
        // ordergenrateList =  responseData.data;
        //  return ordergenrateList;
        debugPrint("order genrate Successfully");
      } else {
        debugPrint("Error order genrate");
      }
    } else {

    }


  }

}