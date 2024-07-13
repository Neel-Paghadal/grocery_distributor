import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/Controllers/godownStock_controller.dart';
import 'package:grocery_distributor/api_services/all_services.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../ConstFile/constColor.dart';
import '../ConstFile/constFonts.dart';
import 'loader.dart';

class GodownScreen extends StatefulWidget {
  const GodownScreen({super.key});

  @override
  State<GodownScreen> createState() => _GodownScreenState();
}

class _GodownScreenState extends State<GodownScreen> {
  GodownStockController godownStockController = Get.put(GodownStockController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    godownStockController.godownStockApiCall();
  }

  Future<void> _handleRefresh() async {
    debugPrint("ScreenRefresh");
    godownStockController.godownStockApiCall();
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
            "Stock List",
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
          child: godownStockController.godownStockList.isEmpty
              ? godownStockController.isNoDataInGodown.value == false
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
                      itemCount: godownStockController.godownStockList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: deviceWidth * 0.02,
                                  right: deviceWidth * 0.02),
                              child: Card(
                                color: godownStockController.godownStockList[index].productLowStockSet < godownStockController.godownStockList[index].totalStock
                                    ? Color(0xffFFE4E3)
                                    : Colors.white30,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: deviceWidth * 0.01),
                                            child: Container(
                                              height: deviceHeight * 0.09,
                                              width: deviceWidth * 0.15,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              child: CachedNetworkImage(
                                                width: deviceWidth * 0.1,
                                                imageUrl: godownStockController
                                                    .godownStockList[index]
                                                    .productImage
                                                    .toString(),
                                                placeholder: (context, url) =>
                                                    const Icon(Icons.image,
                                                        size: 45),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error,
                                                            size: 45),
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
                                                    godownStockController
                                                        .godownStockList[index]
                                                        .productName
                                                        .toString(),
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily:
                                                            ConstFont.popinsRegular,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.black,
                                                        overflow: TextOverflow.ellipsis),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                /*Padding(
                                                  padding: EdgeInsets.only(
                                                      left: deviceHeight * 0.01,
                                                      right: deviceHeight * 0.01),
                                                  child: Text(
                                                    "Offer Price : ₹${godownStockController.godownStockList[index].offerPrice}",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: ConstFont
                                                            .popinsRegular,
                                                        fontWeight:
                                                        FontWeight.w300,
                                                        color: Colors.black),
                                                  ),
                                                ),*/
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: deviceHeight * 0.01,
                                                      right: deviceHeight * 0.01),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "Unit : ${homeController.formatPrice(godownStockController.godownStockList[index].unitVal)} ",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily: ConstFont
                                                                .popinsRegular,
                                                            fontWeight:
                                                            FontWeight.w300,
                                                            color: Colors.black),
                                                      ),
                                                      Text(godownStockController.godownStockList[index].unit,
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily: ConstFont
                                                                .popinsRegular,
                                                            fontWeight:
                                                            FontWeight.w300,
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
                                                            fontFamily: ConstFont.popinsRegular,
                                                            fontWeight:
                                                            FontWeight.w300,
                                                            color: Colors.black),
                                                      ),
                                                      Text(
                                                        "₹${homeController.formatPrice(godownStockController.godownStockList[index].price)}",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily: ConstFont.popinsMedium,
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
                                                                fontWeight:
                                                                    FontWeight.w300,
                                                                color: Colors.black),
                                                          ),
                                                          Text(
                                                            "${homeController.formatPrice(godownStockController.godownStockList[index].stockIn)} Pic",
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
                                                                fontWeight:
                                                                    FontWeight.w300,
                                                                color: Colors.black),
                                                          ),
                                                          Text(
                                                            "${homeController.formatPrice(godownStockController.godownStockList[index].stockOut)} Pic",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily: ConstFont
                                                                    .popinsMedium,
                                                                color: Colors.black),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        "Total Stock\n${homeController.formatPrice(godownStockController.godownStockList[index].totalStock)} Pic",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily: ConstFont
                                                                .popinsMedium,
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
        )),
      ),
    );
  }
}

// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:grocery_distributor/ConstFile/constColor.dart';
// import 'package:grocery_distributor/Controllers/orderGenrate_controller.dart';
// import 'package:grocery_distributor/Model/orderGenrate_model.dart';
// import 'package:grocery_distributor/Screens/Godownsearchscreen.dart';
// import 'package:grocery_distributor/Screens/loader.dart';
// import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
// import '../Common/BottomBarScreen.dart';
// import '../ConstFile/constFonts.dart';
// import '../ConstFile/constImage.dart';
// import '../Controllers/godownStock_controller.dart';
// import '../Controllers/home_controller.dart';
// import 'low_stock.dart';
// import 'searchscreen.dart';
//
// class GodownPage extends StatefulWidget {
//   const GodownPage({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   GodownPageState createState() => GodownPageState();
// }
//
// class GodownPageState extends State<GodownPage> {
//   OrderGenrateController orderGenrate = Get.put(OrderGenrateController());
//   HomeController homeController = Get.put(HomeController());
//   GodownStockController godownStockController = Get.put(GodownStockController());
//
//   // List<String> productName=["Onion Normal","Paprica","Savoy Cabbage","Sweet Potatoes"];
//   // List<String> productImage=[ConstImage.onion,ConstImage.paprica,ConstImage.cabbage,ConstImage.sweet];
//   // List<String> productstockin=["Stock In\n300 Kg","Stock In\n100 Kg","Stock In\n90 Pic","Stock In\n150 Kg"];
//   // List<String> productstockout=["Stock Out\n100 Kg","Stock Out\n50 Kg","Stock Out\n85 Pic","Stock Out\n60 Kg"];
//   // List<String> productstotalstock=["Total Stock\n200 Kg","Total Stock\n50 Kg","Total Stock\n5 Pic","Total Stock\n90 Kg"];
//
//   ScrollController _scrollController = ScrollController();
//   bool isBottomSheetOpen = false;
//
//   int _pageIndex = -1;
//   int _pageSize = 15;
//   bool _loading = false;
//
//   Future<void> _loadProducts() async {
//     setState(() {
//       _loading = true;
//     });
//     _pageIndex++;
//     debugPrint("Page Order index" + _pageIndex.toString());
//     try {
//       final RxList<GenrateOrder> products =
//           await orderGenrate.orderGenrateApiCall(
//         _pageIndex,
//         _pageSize,
//       );
//       setState(() {
//         orderGenrate.ordergenrateList.addAll(products);
//       });
//     } catch (e) {
//       // Handle errors
//       debugPrint('Error loading products: $e');
//     } finally {
//       setState(() {
//         _loading = false;
//       });
//     }
//   }
//
//   Future<void> _handleRefresh() async {
//     _pageIndex = -1;
//     _pageSize = 15;
//     orderGenrate.orderGenrateApiCall(
//       _pageIndex,
//       _pageSize,
//     );
//     debugPrint("ScreenRefresh");
//     return await Future.delayed(Duration(seconds: 1));
//   }
//
//   void _onScroll() {
//     if (_scrollController.position.pixels ==
//         _scrollController.position.maxScrollExtent) {
//       // User has reached the end of the list, load more products
//       _loadProducts();
//     }
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _loadProducts();
//     _scrollController.addListener(_onScroll);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var deviceHeight = MediaQuery.of(context).size.height;
//     var deviceWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//             /* Get.to(() => BottomBarScreen(),
//                 arguments: {homeController.currentIndex = 0});*/
//           },
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//           ),
//         ),
//         elevation: 0,
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: Text(
//           "Godown Stock",
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(
//                 top: deviceHeight * 0.0,
//                 left: deviceWidth * 0.02,
//                 right: deviceWidth * 0.02),
//             child: Card(
//               color: Colors.white,
//               elevation: 5.0,
//               child: TextFormField(
//                 onTap: () {
//                   Get.to(() => const GodownSearchScreen());
//                 },
//                 showCursor: false,
//                 autofocus: false,
//                 readOnly: false,
//                 keyboardType: TextInputType.none,
//                 decoration: InputDecoration(
//                   labelStyle: const TextStyle(color: Colors.black),
//                   fillColor: Colors.white,
//                   enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                       borderSide: BorderSide.none),
//                   focusedBorder: const OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.transparent),
//                     borderRadius: BorderRadius.all(Radius.circular(8)),
//                   ),
//                   border: InputBorder.none,
//                   filled: true,
//                   isDense: true,
//                   hintText: "Search For Products...",
//                   hintStyle: const TextStyle(
//                       color: Colors.black,
//                       fontFamily: ConstFont.popinsRegular,
//                       fontSize: 16,
//                       overflow: TextOverflow.ellipsis),
//                   suffixIcon: const Icon(
//                     CupertinoIcons.search,
//                     size: 24,
//                     color: ConstColour.primaryColor,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Flexible(child: Obx(() => _buildProductList())),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProductList() {
//     var deviceHeight = MediaQuery.of(context).size.height;
//     var deviceWidth = MediaQuery.of(context).size.width;
//
//     return LiquidPullToRefresh(
//       color: Colors.white,
//       height: deviceHeight * 0.08,
//       onRefresh: _handleRefresh,
//       showChildOpacityTransition: false,
//       backgroundColor: ConstColour.primaryColor,
//       springAnimationDurationInMilliseconds: 1,
//       child: ListView.builder(
//         shrinkWrap: true,
//         scrollDirection: Axis.vertical,
//         itemCount: orderGenrate.ordergenrateList.length + (_loading ? 1 : 0),
//         itemBuilder: (context, index) {
//           if (index == orderGenrate.ordergenrateList.length) {
//             // Loading indicator
//             return _loading
//                 ? Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Center(
//                       child: const CircularProgressIndicator(
//                           color: ConstColour.primaryColor),
//                       widthFactor: deviceWidth * 0.1,
//                     ),
//                   )
//                 : Container();
//           }
//
//           final product = orderGenrate.ordergenrateList[index];
//           // Build your product list item UI here
//
//           return Padding(
//             padding: EdgeInsets.symmetric(
//                 vertical: deviceHeight * 0.005, horizontal: deviceWidth * 0.02),
//             child: Card(
//               elevation: 4.0,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(6)),
//               child: ListTile(
//                 onTap: () {
//                   orderGenrate.productPriceCall(
//                       orderGenrate.ordergenrateList[index].id);
//                   showPriceQuantityList(
//                       orderGenrate.ordergenrateList[index].productImage,
//                       orderGenrate.ordergenrateList[index].productName,
//                       orderGenrate.ordergenrateList[index].id.toString());
//                 },
//                 tileColor: Colors.grey.shade50,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(6)),
//                 leading: CachedNetworkImage(
//                   width: deviceWidth * 0.1,
//                   imageUrl: orderGenrate.ordergenrateList[index].productImage
//                       .toString(),
//                   placeholder: (context, url) =>
//                       const Icon(Icons.image, size: 45),
//                   errorWidget: (context, url, error) =>
//                       const Icon(Icons.error, size: 45),
//                 ),
//                 trailing: Text(
//                   "Show All",
//                   style: TextStyle(
//                       color: ConstColour.primaryColor,
//                       fontFamily: ConstFont.popinsMedium),
//                 ),
//                 title: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(orderGenrate.ordergenrateList[index].productName,
//                       style: const TextStyle(
//                         color: Colors.black,
//                         fontFamily: ConstFont.popinsMedium,
//                         fontSize: 16,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 4),
//                 ),
//               ),
//             ),
//           );
//         },
//         controller: _scrollController,
//       ),
//     );
//   }
//
//   void showPriceQuantityList(
//       String image, String productName, String productId) {
//     final deviceHeight = MediaQuery.of(context).size.height;
//     final deviceWidth = MediaQuery.of(context).size.width;
//
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       enableDrag: false,
//       useSafeArea: true,
//       isDismissible: true,
//       // showDragHandle:  true,
//       shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//         top: Radius.circular(11),
//       )),
//
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             return Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ListTile(
//                   leading: CachedNetworkImage(
//                     height: 50,
//                     width: 55,
//                     imageUrl: image.toString(),
//                     placeholder: (context, url) =>
//                         const Icon(Icons.image, size: 45),
//                     errorWidget: (context, url, error) =>
//                         const Icon(Icons.error, size: 45),
//                   ),
//                   title: Text(
//                     productName,
//                     style: const TextStyle(
//                       fontFamily: ConstFont.popinsMedium,
//                       overflow: TextOverflow.ellipsis,
//                       fontSize: 16,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 2,
//                   ),
//                   trailing: IconButton(
//                       onPressed: () {
//                         Get.back();
//                       },
//                       icon: Icon(Icons.close)),
//                 ),
//                 Divider(
//                   height: deviceHeight * 0.01,
//                 ),
//                 const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text(
//                     "Choose a Pack Size",
//                     style: TextStyle(
//                       fontFamily: ConstFont.popinsRegular,
//                       overflow: TextOverflow.ellipsis,
//                       fontSize: 14,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 2,
//                   ),
//                 ),
//                 SizedBox(
//                   height: deviceHeight * 0.38,
//                   child: Obx(
//                     () => orderGenrate.orderPriceList.isEmpty
//                         ? Loaders(
//                             items: 5,
//                             direction: LoaderDirection.ltr,
//                             builder: Padding(
//                               padding:
//                                   EdgeInsets.only(right: deviceWidth * 0.01),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: ListTile(
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(6)),
//                                       title: Container(
//                                           width: deviceWidth * 0.2,
//                                           height: deviceHeight * 0.005,
//                                           color: Colors.grey),
//                                       subtitle: Container(
//                                           width: deviceWidth * 0.2,
//                                           height: deviceHeight * 0.005,
//                                           color: Colors.grey),
//                                       tileColor: Colors.grey.shade100,
//                                       leading: const Icon(
//                                         Icons.image,
//                                         size: 50,
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           )
//                         : ListView.builder(
//                             controller: ScrollController(),
//                             scrollDirection: Axis.vertical,
//                             shrinkWrap: true,
//                             itemCount: orderGenrate.orderPriceList.length,
//                             itemBuilder: (context, index) {
//                               return Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     vertical: deviceHeight * 0.005,
//                                     horizontal: deviceWidth * 0.02),
//                                 child: Card(
//                                   elevation: 4.0,
//                                   shadowColor: ConstColour.primaryColor,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(6)),
//                                   child: ListTile(
//                                     onTap: () {
//                                       Get.back();
//                                       // orderGenrate.showDialogs(context, productId, orderGenrate.orderPriceList[index].priceId.toString(),);
//                                     },
//                                     // trailing: const Icon(Icons.add_shopping_cart,color: ConstColour.primaryColor),
//                                     dense: false,
//                                     tileColor: Colors.grey.shade50,
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(6)),
//                                     leading: CachedNetworkImage(
//                                       width: deviceWidth * 0.1,
//                                       imageUrl: image.toString(),
//                                       placeholder: (context, url) =>
//                                           const Icon(Icons.image, size: 45),
//                                       errorWidget: (context, url, error) =>
//                                           const Icon(Icons.error, size: 45),
//                                     ),
//                                     title: Text(
//                                         orderGenrate
//                                             .orderPriceList[index].priceDetails,
//                                         style: const TextStyle(
//                                           color: Colors.black,
//                                           fontFamily: ConstFont.popinsMedium,
//                                           fontSize: 16,
//                                         ),
//                                         overflow: TextOverflow.ellipsis,
//                                         maxLines: 2),
//                                     subtitle: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "Stock Quantity : ",
//                                           style: const TextStyle(
//                                             color: Colors.black,
//                                             fontFamily: ConstFont.popinsMedium,
//                                             fontSize: 15,
//                                           ),
//                                         ),
//                                         Text(
//                                           orderGenrate
//                                               .orderPriceList[index].quantity
//                                               .toString(),
//                                           style: const TextStyle(
//                                             color: Colors.black,
//                                             fontFamily: ConstFont.popinsRegular,
//                                             fontSize: 15,
//                                           ),
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                   ),
//                 )
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }
