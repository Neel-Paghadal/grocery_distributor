import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery_distributor/Controllers/stockRequest_controller.dart';

import '../ConstFile/constColor.dart';
import '../ConstFile/constFonts.dart';
import 'loader.dart';

class StockRequestScreen extends StatefulWidget {
  const StockRequestScreen({super.key});

  @override
  State<StockRequestScreen> createState() => _StockRequestScreenState();
}

class _StockRequestScreenState extends State<StockRequestScreen> {
  StockRequestController stockRequestController =
      Get.put(StockRequestController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stockRequestController.fetchStockRequest();
  }
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Requested Stock",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Obx(() => stockRequestController.stockRequestList.isEmpty
          ? stockRequestController.isNoRequest.value == false
          ? Center(child: Text("No Data Found")) :
      Loaders(
              items: 8,
              direction: LoaderDirection.ltr,
              builder: Padding(
                padding: EdgeInsets.only(right: deviceWidth * 0.01),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        title: Container(
                            width: deviceWidth * 0.2,
                            height: deviceHeight * 0.005,
                            color: Colors.grey),
                        subtitle: Container(
                            width: deviceWidth * 0.2,
                            height: deviceHeight * 0.005,
                            color: Colors.grey),
                        tileColor: Colors.grey.shade100,
                        leading: const Icon(
                          Icons.image,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )

              : ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: stockRequestController.stockRequestList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: deviceHeight * 0.005, horizontal: deviceWidth * 0.02),
                      child: Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        child: ListTile(
                          dense: false,
                          tileColor: Colors.grey.shade50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          leading: Image.asset('assets/Images/BakeryDairy.png',width: deviceWidth * 0.1,),
                          /*CachedNetworkImage(
                            width: deviceWidth * 0.1,
                            imageUrl: stockRequestController.stockRequestList[index].productImage.toString(),
                            placeholder: (context, url) =>
                            const Icon(Icons.image, size: 45),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error, size: 45),
                          ),*/
                          trailing: Text(stockRequestController.stockRequestList[index].request == 0 ? "Requested" : "Accept" ,style: TextStyle(
                            color: stockRequestController.stockRequestList[index].request == 0 ? Colors.red : Colors.black,
                            fontWeight: FontWeight.w500
                          ),),
                          title: Text(stockRequestController.stockRequestList[index].productName,
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: ConstFont.popinsMedium,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2),
                        ),
                      ),
                    );
                  },
                )),
    );
  }
}
