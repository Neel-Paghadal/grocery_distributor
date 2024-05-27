import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery_distributor/Controllers/stockRequest_controller.dart';
import 'package:grocery_distributor/api_services/all_services.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../ConstFile/constColor.dart';
import '../ConstFile/constFonts.dart';
import '../Controllers/orderGenrate_controller.dart';
import 'loader.dart';

class StockRequestScreen extends StatefulWidget {
  const StockRequestScreen({super.key});

  @override
  State<StockRequestScreen> createState() => _StockRequestScreenState();
}

class _StockRequestScreenState extends State<StockRequestScreen> {
  StockRequestController stockRequestController = Get.put(StockRequestController());
  OrderGenrateController orderGenrateController = Get.put(OrderGenrateController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    stockRequestController.fetchStockRequest();
  }

  Future<void> _handleRefresh() async {
    debugPrint("ScreenRefresh");
    stockRequestController.fetchStockRequest();
    return await Future.delayed(const Duration(seconds: 1));
  }


  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
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
        body: Obx(() => LiquidPullToRefresh(
          color: ConstColour.shimmerBaseColor,
          height: deviceHeight * 0.1,
          onRefresh: _handleRefresh,
          showChildOpacityTransition: false,
          backgroundColor: ConstColour.primaryColor,
          springAnimationDurationInMilliseconds: 1,
          child: stockRequestController.stockRequestList.isEmpty
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
                              // leading: Image.asset('assets/Images/BakeryDairy.png',width: deviceWidth * 0.1,),
                              leading: Image.network(
                                stockRequestController.stockRequestList[index].productImage.toString(),
                                fit: BoxFit.cover,
                                width: deviceWidth * 0.1,),
                              /*CachedNetworkImage(
                                width: deviceWidth * 0.1,
                                imageUrl: stockRequestController.stockRequestList[index].productImage.toString(),
                                placeholder: (context, url) =>
                                const Icon(Icons.image, size: 45),
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error, size: 45),
                              ),*/
                              trailing: Text(
                                // stockRequestController.stockRequestList[index].request == 0
                                //     ? "Requested"
                                //     : "Accept" ,
                                stockRequestController.stockRequestList[index].request == 1
                                    ? "Delivered"
                                    : stockRequestController.stockRequestList[index].request == 2
                                    ? "Not Delivered"
                                    : stockRequestController.stockRequestList[index].request == 3
                                    ? "Pending"
                                    : "Waiting",
                                style: TextStyle(
                                color: stockRequestController.stockRequestList[index].request == 1
                                    ? Colors.green
                                    : stockRequestController.stockRequestList[index].request == 2
                                    ? Colors.red
                                    : stockRequestController.stockRequestList[index].request == 3
                                    ? Colors.red
                                    : ConstColour.primaryColor,
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
                              subtitle: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(homeController.removeDecimalValue(stockRequestController.stockRequestList[index].unit.toString()),
                                        style: TextStyle(
                                          color: Colors.grey[700]
                                      ),),
                                      Text("Qty : ${stockRequestController.stockRequestList[index].quantity.toString()}",
                                        style: TextStyle(
                                          color: Colors.grey[700]
                                      ),),
                                      Text("₹ ${homeController.formatPrice(stockRequestController.stockRequestList[index].price)}",
                                        style: const TextStyle(
                                          fontSize: 15
                                      ),)
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: deviceWidth * 0.05),
                                    child: Text("Total: ₹${stockRequestController.calculateTotalAmount(
                                        int.tryParse(stockRequestController.stockRequestList[index].quantity.toString()) ?? 0,
                                        stockRequestController.stockRequestList[index].price).toString()}",
                                      style: TextStyle(
                                          color: Colors.grey[700]
                                      ),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
        )),
      ),
    );
  }
}
