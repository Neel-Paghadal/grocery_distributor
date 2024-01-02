import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/Model/orderGenrate_model.dart';
import 'package:http/http.dart' as http;

import '../ConstFile/constApi.dart';




class SearchScreenController extends GetxController{


  TextEditingController allSearchController = TextEditingController();
  RxList<GenrateOrder> searchList = <GenrateOrder>[].obs;
  RxString inputValue = ''.obs;

  int? messageCode;


  Future<void> SearchProduct(String searchKeyword) async {
    final response = await http.post(Uri.parse(ConstApi.orderGenrate),
        body: {
          "PageIndex": "0",
          "PageSize": "100",
          "Keyword": searchKeyword

        });
    var data = response.body;
    debugPrint("Search List : " +data);

    if (response.statusCode == 200) {
      final responseData = orderGenrateFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint(messageCode.toString());

      if (messageCode == 200) {
        searchList.clear();
        searchList.addAll(responseData.data);
        // categoriesController.categoryList.addAll(responseData.data);
        debugPrint("Search Successfully");
        // Fluttertoast.showToast(
        //     msg: "Product GetList Successfully",
        //     fontSize: 18,
        //     backgroundColor: ConstColour.primaryColor,
        //     textColor: Colors.white);

      } else {
        debugPrint("Error Search Get");
        // ArtSweetAlert.show(
        //     context: context,
        //     artDialogArgs: ArtDialogArgs(
        //         confirmButtonColor: ConstColour.primaryColor,
        //         type: ArtSweetAlertType.danger,
        //         text: "Please Enter Address"));
      }
    } else {}
  }





}