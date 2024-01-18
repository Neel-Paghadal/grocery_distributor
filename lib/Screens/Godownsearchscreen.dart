import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/ConstFile/constColor.dart';
import 'package:grocery_distributor/ConstFile/constFonts.dart';
import 'package:grocery_distributor/Controllers/orderGenrate_controller.dart';
import 'package:grocery_distributor/Screens/loader.dart';

import '../Controllers/searchScreen_controllers.dart';

class GodownSearchScreen extends StatefulWidget {
  const GodownSearchScreen({super.key});

  @override
  State<GodownSearchScreen> createState() => _GodownSearchScreenState();
}

class _GodownSearchScreenState extends State<GodownSearchScreen> {

  SearchScreenController searchController = Get.put(SearchScreenController());
  OrderGenrateController orderGenrate = Get.put(OrderGenrateController());


  @override
  Widget build(BuildContext context) {

    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        // elevation: 0.0,
        title: const Text("Aayu plus",style: TextStyle(color: ConstColour.primaryColor,fontFamily: ConstFont.popinsMedium,fontSize: 20),),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 25,
            color: Colors.black,
          ),
        ),

      ),
      body: Padding(
          padding: EdgeInsets.only(
              left: deviceWidth * 0.025,
              right: deviceWidth * 0.025,
              top: deviceHeight * 0.01),
          child: SafeArea(
            child: SingleChildScrollView(
              controller: ScrollController(),
              scrollDirection: Axis.vertical,
              child: Obx(
                () => Column(
                  children: [
                    TextFormField(
                      controller: searchController.allSearchController,
                      onChanged: (value) {
                        searchController.inputValue.value = value;
                        searchController.SearchProduct(searchController.allSearchController.text);
                      },
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
                        hintText: "Search For Products...",
                        hintStyle: const TextStyle(
                            color: Colors.black,
                            fontFamily: ConstFont.popinsRegular,
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis),
                        prefixIcon: const Icon( CupertinoIcons.search,size: 24,color: ConstColour.primaryColor,),
                        suffixIcon : searchController.inputValue.value.isEmpty ? const SizedBox() :  IconButton (onPressed: () {
                          searchController.allSearchController.clear();
                        }, icon: const Icon( CupertinoIcons.clear_circled ,size: 24,color: ConstColour.primaryColor,))
                      ),
                    ),
                  Obx(
                    () => ListView.builder(
                      controller: ScrollController(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: searchController.searchList.length,
                      itemBuilder: (context, index) {
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
                              orderGenrate.productPriceCall(searchController.searchList[index].id);
                              showPriceQuantityList(searchController.searchList[index].productImage, searchController.searchList[index].productName,searchController.searchList[index].id.toString());
                            },
                            dense: false,
                            tileColor: Colors.grey.shade50,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            trailing:  const Text("Show All",style: TextStyle(color: ConstColour.primaryColor,fontFamily: ConstFont.popinsMedium),),

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
                                searchController.searchList[index].productImage
                                    .toString(),
                              ),
                            ),
                            title: Text(
                                searchController.searchList[index].productName,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: ConstFont.popinsMedium,
                                  fontSize: 16,
                                ),
                                overflow: TextOverflow.ellipsis,maxLines: 4),
                          ),
                        ),
                      );
                    },),
                  )
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }









  void showPriceQuantityList(String image,String productName,String productId){
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;


    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      useSafeArea: true,
      isDismissible: true,
      // showDragHandle:  true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(11),
          )),

      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Image.network(height: 50, width: 55, image),
                  title: Text(
                    productName,
                    style: const TextStyle(
                      fontFamily: ConstFont.popinsMedium,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Divider(
                  height: deviceHeight * 0.01,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Choose a Pack Size",
                    style: TextStyle(
                      fontFamily: ConstFont.popinsRegular,
                      overflow: TextOverflow.ellipsis,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.38,
                  child: Obx(
                        () => orderGenrate.orderPriceList.isEmpty ? Loaders(
                      items: 5,
                      direction: LoaderDirection.ltr,
                      builder: Padding(
                        padding: EdgeInsets.only(
                            right: deviceWidth * 0.01),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(6)),
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
                    ) :  ListView.builder(
                      controller: ScrollController(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: orderGenrate.orderPriceList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: deviceHeight * 0.005,
                              horizontal: deviceWidth * 0.02),
                          child: Card(
                            elevation: 4.0,
                            shadowColor: ConstColour.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6)),
                            child: ListTile(
                              onTap: () {
                                Get.back();
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
                                  image
                                      .toString(),
                                ),
                              ),
                              title: Text(
                                  orderGenrate.orderPriceList[index].priceDetails,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: ConstFont.popinsMedium,
                                    fontSize: 16,
                                  ),
                                  overflow: TextOverflow.ellipsis,maxLines: 4),
                              subtitle: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Stock Quantity : ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: ConstFont.popinsMedium,
                                      fontSize: 15,
                                    ),
                                  ) , Text(
                                    orderGenrate.orderPriceList[index].quantity.toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: ConstFont.popinsRegular,
                                      fontSize: 15,
                                    ),
                                    overflow: TextOverflow.ellipsis,

                                  ),
                                ],
                              ),

                            ),
                          ),
                        );
                      },),
                  ),
                )
              ],
            );

          },
        );
      },
    );
  }




}
