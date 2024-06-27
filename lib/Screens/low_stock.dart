
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery_distributor/api_services/all_services.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../ConstFile/constColor.dart';
import '../ConstFile/constFonts.dart';
import '../Controllers/lowStock_controller.dart';
import 'loader.dart';

class LowStockScreen extends StatefulWidget {
  const LowStockScreen({Key? key}) : super(key: key);

  @override
  State<LowStockScreen> createState() => _LowStockScreenState();
}

class _LowStockScreenState extends State<LowStockScreen> {
  LowStockController lowStockController = Get.put(LowStockController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lowStockController.lowStockApiCall();
  }

  Future<void> _handleRefresh() async {
    debugPrint("ScreenRefresh");
    lowStockController.lowStockApiCall();
    return await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
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
          title: Text(
            "Low Stock",
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
          child: lowStockController.lowStockList.isEmpty
              ? lowStockController.isNoDataInStock.value == false
              ? Center(child: Text("No Data Found"))
              : Loaders(
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
                      itemCount: lowStockController.lowStockList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            /*Padding(
                            padding: EdgeInsets.only(
                                right: deviceWidth * 0.02,
                                left: deviceWidth * 0.02,
                                bottom: deviceHeight * 0.01),
                            child: TextFormField(
                              decoration: InputDecoration(
                                fillColor: Color(0xffF3F4F4),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(2),
                                    borderSide: BorderSide.none),
                                hintStyle: TextStyle(
                                    fontFamily: ConstFont.popinsRegular,
                                    fontSize: 15),
                                hintText: "Search Product Name",
                              ),
                            ),
                          ),*/
                            Padding(
                              padding: EdgeInsets.only(
                                  left: deviceWidth * 0.02,
                                  right: deviceWidth * 0.02),
                              child: Card(
                                color: Color(0xffFFE4E3),
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
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: deviceWidth * 0.01),
                                            child: Container(
                                              height: deviceHeight * 0.09,
                                              width: deviceWidth * 0.15,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(6)
                                              ),
                                              child: CachedNetworkImage(
                                                width: deviceWidth * 0.1,
                                                imageUrl: lowStockController.lowStockList[index].imageName.toString(),
                                                placeholder: (context, url) =>
                                                const Icon(Icons.image, size: 45),
                                                errorWidget: (context, url, error) =>
                                                const Icon(Icons.error, size: 45),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: deviceHeight * 0.01),
                                                  child: Text(
                                                    lowStockController.lowStockList[index].productName.toString(),
                                                    maxLines : 1,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily: ConstFont
                                                          .popinsRegular,
                                                      fontWeight: FontWeight.w600,
                                                      color: Colors.black,
                                                      overflow: TextOverflow.ellipsis
                                                    ),
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: deviceHeight * 0.01,
                                                      right: deviceHeight * 0.01),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Unit : ",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily: ConstFont
                                                                .popinsRegular,
                                                            fontWeight:
                                                            FontWeight.w300,
                                                            color: Colors.black),
                                                      ),
                                                      Text(homeController.removeDecimalValue(lowStockController.lowStockList[index].unit),
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily: ConstFont
                                                                .popinsMedium,
                                                            color: Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: deviceHeight * 0.01,
                                                      right: deviceHeight * 0.01),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Price : ",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily: ConstFont
                                                                .popinsRegular,
                                                            fontWeight:
                                                            FontWeight.w300,
                                                            color: Colors.black),
                                                      ),
                                                      Text(
                                                        "₹${homeController.formatPrice(lowStockController.lowStockList[index].price)}",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily: ConstFont
                                                                .popinsMedium,
                                                            color: Colors.black),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: deviceHeight * 0.01,
                                                      top: deviceHeight * 0.01,
                                                      right: deviceHeight * 0.01),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Text(
                                                            "Stock In",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily: ConstFont
                                                                    .popinsRegular,
                                                                fontWeight: FontWeight.w300,
                                                                color: Colors.black),
                                                          ),
                                                          Text(
                                                            "${homeController.formatPrice(lowStockController.lowStockList[index].stockIn)} Pic",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily: ConstFont
                                                                    .popinsMedium,
                                                                color: Colors.black),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        children: [
                                                          Text(
                                                            "Stock Out",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily: ConstFont
                                                                    .popinsRegular,
                                                                fontWeight: FontWeight.w300,
                                                                color: Colors.black),
                                                          ),
                                                          Text(
                                                            "${homeController.formatPrice(lowStockController.lowStockList[index].stockOut)} Pic",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily: ConstFont
                                                                    .popinsMedium,
                                                                fontWeight: FontWeight.w300,
                                                                color: Colors.black),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        "Total Stock\n${homeController.formatPrice(lowStockController.lowStockList[index].totalStock)} Pic",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily: ConstFont.popinsMedium,
                                                            fontWeight: FontWeight.w300,
                                                            color: Colors.black),
                                                      ),
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
                        );
                      },
                    ),
        )));
  }
}
