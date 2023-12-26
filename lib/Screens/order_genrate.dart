import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/ConstFile/constColor.dart';
import 'package:grocery_distributor/ConstFile/constFonts.dart';
import 'package:grocery_distributor/Controllers/orderGenrate_controller.dart';
import 'package:grocery_distributor/Screens/Bottom_Sheets/productPrice_bottomSheet.dart';

import '../Model/orderGenrate_model.dart';
import 'searchscreen.dart';

class OrderGenrate extends StatefulWidget {
  const OrderGenrate({super.key});

  @override
  State<OrderGenrate> createState() => _OrderGenrateState();
}

class _OrderGenrateState extends State<OrderGenrate> {
  OrderGenrateController orderGenrate = Get.put(OrderGenrateController());
  ScrollController _scrollController = ScrollController();
  bool isBottomSheetOpen = false;

  int _pageIndex = -1;
  int _pageSize = 15;
  bool _loading = false;

  Future<void> _loadProducts() async {
    setState(() {
      _loading = true;
    });
    _pageIndex++;
    debugPrint("Page Order index"+_pageIndex.toString());
    try {
      final RxList<GenrateOrder> products = await orderGenrate.orderGenrateApiCall(_pageIndex, _pageSize,);
      setState(() {
        orderGenrate.ordergenrateList.addAll(products);

      });
    } catch (e) {
      // Handle errors
      print('Error loading products: $e');
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }


  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // User has reached the end of the list, load more products
      _loadProducts();
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadProducts();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ConstColour.bgColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Order Genrate",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black, // Change this color to your desired color
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: deviceHeight * 0.0,
                left: deviceWidth * 0.02,
                right: deviceWidth * 0.02),
            child: Card(
              color: Colors.white,
              elevation: 5.0,
              child: TextFormField(
                onTap: () {
                  Get.to(() => const SearchScreen());
                },
                showCursor: false,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(
                      color: Colors.black),
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(8),
                      borderSide: BorderSide.none),
                  focusedBorder:
                  const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Colors.transparent),
                    borderRadius: BorderRadius.all(
                        Radius.circular(8)),
                  ),
                  border: InputBorder.none,
                  filled: true,
                  isDense: true,
                  hintText: "Search For Products...",
                  hintStyle: const TextStyle(
                      color: Colors.black,
                      fontFamily:
                      ConstFont.popinsRegular,
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis),
                  suffixIcon: const Icon(
                    CupertinoIcons.search,
                    size: 24,
                    color: ConstColour.primaryColor,
                  ),
                ),
              ),
            ),
          ),
          Flexible(child: Obx( () =>  _buildProductList())),
        ],
      ),
      // body: SingleChildScrollView(
      //   scrollDirection: Axis.vertical,
      //   controller: ScrollController(),
      //   child: Column(
      //     children: [
      //       Obx(
            //   () => ListView.builder(
            //     shrinkWrap: true,
            //     scrollDirection: Axis.vertical,
            //     controller: ScrollController(),
            //     itemCount:  orderGenrate.ordergenrateList.length + (_loading ? 1 : 0),
            //     itemBuilder: (context, index) {
            //       return Padding(
            //         padding: EdgeInsets.symmetric(
            //             vertical: deviceHeight * 0.005,
            //             horizontal: deviceWidth * 0.02),
            //         child: Card(
            //           elevation: 4.0,
            //           shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(6)),
            //           child: ListTile(
            //             dense: false,
            //             tileColor: Colors.grey.shade50,
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(6)),
            //             leading: Image(
            //               width: deviceWidth * 0.1,
            //               errorBuilder: (BuildContext context, Object exception,
            //                   StackTrace? stackTrace) {
            //                 // Custom error widget to display when image fails to load
            //                 return const Icon(
            //                   Icons.image,
            //                   size: 45,
            //                 );
            //               },
            //               image: NetworkImage(
            //                 orderGenrate.ordergenrateList[index].productImage
            //                     .toString(),
            //               ),
            //             ),
            //             title: Text(
            //                 orderGenrate.ordergenrateList[index].productName,
            //                 style: const TextStyle(
            //                   color: Colors.black,
            //                   fontFamily: ConstFont.popinsMedium,
            //                   fontSize: 16,
            //                 ),
            //                 overflow: TextOverflow.ellipsis,maxLines: 2),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // )
      //     ],
      //   ),
      // ),
    );
  }

  Widget _buildProductList() {

    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: orderGenrate.ordergenrateList.length + (_loading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == orderGenrate.ordergenrateList.length) {
          // Loading indicator
          return _loading ? Center(child: const CircularProgressIndicator(color: ConstColour.primaryColor),widthFactor: deviceWidth * 0.1,) : Container();
        }

        final product = orderGenrate.ordergenrateList[index];
        // Build your product list item UI here

        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: deviceHeight * 0.005,
              horizontal: deviceWidth * 0.02),
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6)),
            child: ListTile(
              onTap: () {
              orderGenrate.productPriceCall(orderGenrate.ordergenrateList[index].id);
                showQuantityBottomSheet(context, orderGenrate.ordergenrateList[index].productName, orderGenrate.ordergenrateList[index].productImage,);
              },
              dense: false,
              tileColor: Colors.grey.shade50,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
              leading: Image(
                width: deviceWidth * 0.1,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  // Custom error widget to display when image fails to load
                  return const Icon(
                    Icons.image,
                    size: 45,
                  );
                },
                image: NetworkImage(
                  orderGenrate.ordergenrateList[index].productImage
                      .toString(),
                ),
              ),
              title: Text(
                  orderGenrate.ordergenrateList[index].productName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontFamily: ConstFont.popinsMedium,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,maxLines: 2),
            ),
          ),
        );
      },
      controller: _scrollController,
    );
  }


  void showQuantityBottomSheet(BuildContext context,String productName,
      String image,) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      useSafeArea: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(11),
          )),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        snap: GetPlatform.isAndroid,
        // controller: DraggableScrollableController(),
        initialChildSize: 0.53,
        maxChildSize: 0.53,
        minChildSize: 0.50,
        builder: (context, scrollController) =>  OrderGenrateBottom(
          productName: productName,
          image: image,
          // productId: product_Id,
        ),
      ),
    ).whenComplete(() {
      setState(() {
        isBottomSheetOpen = false;
      });
    });

    setState(() {
      isBottomSheetOpen = true;
    });
  }
}
