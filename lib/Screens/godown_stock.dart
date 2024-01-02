import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery_distributor/ConstFile/constColor.dart';
import 'package:grocery_distributor/Controllers/orderGenrate_controller.dart';
import 'package:grocery_distributor/Model/orderGenrate_model.dart';
import 'package:grocery_distributor/Screens/Godownsearchscreen.dart';
import 'package:grocery_distributor/Screens/loader.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../Common/BottomBarScreen.dart';
import '../ConstFile/constFonts.dart';
import '../ConstFile/constImage.dart';
import '../Controllers/home_controller.dart';
import 'low_stock.dart';
import 'searchscreen.dart';

class GodownPage extends StatefulWidget{
  const GodownPage({Key? key,}):super(key: key);

  @override
  GodownPageState createState() => GodownPageState();
}
class GodownPageState extends State<GodownPage>{
  OrderGenrateController orderGenrate = Get.put(OrderGenrateController());
  HomeController homeController = Get.put(HomeController());


  // List<String> productName=["Onion Normal","Paprica","Savoy Cabbage","Sweet Potatoes"];
  // List<String> productImage=[ConstImage.onion,ConstImage.paprica,ConstImage.cabbage,ConstImage.sweet];
  // List<String> productstockin=["Stock In\n300 Kg","Stock In\n100 Kg","Stock In\n90 Pic","Stock In\n150 Kg"];
  // List<String> productstockout=["Stock Out\n100 Kg","Stock Out\n50 Kg","Stock Out\n85 Pic","Stock Out\n60 Kg"];
  // List<String> productstotalstock=["Total Stock\n200 Kg","Total Stock\n50 Kg","Total Stock\n5 Pic","Total Stock\n90 Kg"];


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
      debugPrint('Error loading products: $e');
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _handleRefresh() async{
    _pageIndex = -1;
    _pageSize = 15;
    orderGenrate.orderGenrateApiCall(_pageIndex, _pageSize,);
    debugPrint("ScreenRefresh");
    return await Future.delayed(Duration(seconds: 1));
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
  Widget build(BuildContext context){
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Get.to(() => BottomBarScreen(),arguments: {homeController.currentIndex = 0});

        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,),),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true ,
        title: Text("Godown Stock",
          style: TextStyle(color: Colors.black),),
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
                  Get.to(() => const GodownSearchScreen());
                },
                showCursor: false,
                autofocus: false,
                readOnly: false,
                keyboardType: TextInputType.none,
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
    );
  }


  Widget _buildProductList() {

    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return LiquidPullToRefresh(
      color: Colors.white,
      height: deviceHeight * 0.08,
      onRefresh: _handleRefresh,
      showChildOpacityTransition: false,
      backgroundColor: ConstColour.primaryColor,
      springAnimationDurationInMilliseconds: 1,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: orderGenrate.ordergenrateList.length + (_loading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == orderGenrate.ordergenrateList.length) {
            // Loading indicator
            return _loading ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: const CircularProgressIndicator(color: ConstColour.primaryColor),widthFactor: deviceWidth * 0.1,),
            ) : Container();
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
                  showPriceQuantityList(orderGenrate.ordergenrateList[index].productImage, orderGenrate.ordergenrateList[index].productName,orderGenrate.ordergenrateList[index].id.toString());
                },
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
                trailing:  Text("Show All",style: TextStyle(color: ConstColour.primaryColor,fontFamily: ConstFont.popinsMedium),),
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      orderGenrate.ordergenrateList[index].productName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: ConstFont.popinsMedium,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,maxLines: 4),
                ),
              ),
            ),
          );
        },
        controller: _scrollController,
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
                                // orderGenrate.showDialogs(context, productId, orderGenrate.orderPriceList[index].priceId.toString(),);
                              },
                              // trailing: const Icon(Icons.add_shopping_cart,color: ConstColour.primaryColor),
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
                                  overflow: TextOverflow.ellipsis,maxLines: 2),
                              subtitle: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Stock Quantity : ",
                                    style: const TextStyle(
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


//
// Expanded(
// child: ListView.builder(
// itemCount: 4,
// itemBuilder: (context,index){
// return Padding(
// padding: EdgeInsets.only(left: deviceWidth*0.02,right: deviceWidth*0.02),
// child: Card(
// color: Color(0xffF3F4F4),
// child: Padding(
// padding: EdgeInsets.only(left: deviceWidth*0.01,bottom: deviceHeight*0.01,right: deviceWidth*0.01,top: deviceHeight*0.01),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.start,
// crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisSize: MainAxisSize.max,
// children: [
// Image(image: AssetImage(productImage[index].toString()),
// fit: BoxFit.cover,
// width:60,
// height: 60,
// ),
// Expanded(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.start,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Padding(
// padding:  EdgeInsets.only(left: deviceHeight*0.01),
// child: Expanded(
// child: Text(productName[index].toString(),
// style: TextStyle(
// fontSize: 14,
// fontFamily: ConstFont.popinsRegular,
// color: Colors.black,
// ),
// overflow: TextOverflow.ellipsis,
// maxLines: 1,),
// ),
// ),
// Padding(
// padding: EdgeInsets.only(left: deviceHeight*0.01,right: deviceHeight*0.01),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Padding(
// padding: EdgeInsets.only(left: deviceWidth*0.01,right: deviceWidth*0.01),
// child: Container(
// height:25,
// width:62,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(2),
// ),
// child: Center(
// child: ElevatedButton(
// style: ElevatedButton.styleFrom(primary: Color(0xff6AB04C)),
// onPressed: () {
// Get.to(()=>lowstockPage());
// },
// child: Text("Add",
// style: TextStyle(
// fontFamily: ConstFont.popinsRegular,
// color: Colors.white
// ),),
// ),
// ),
// ),
// ),
// Padding(
// padding: EdgeInsets.only(left: deviceWidth*0.01,right: deviceWidth*0.01),
// child: Container(
// height: 25,
// width: 60,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(2),
// ),
// child: Center(
// child: ElevatedButton(
// style: ElevatedButton.styleFrom(primary: Color(0xffF86C6B)),
// onPressed: (){},
// child: Text("Out",
// style: TextStyle(
// fontFamily: ConstFont.popinsRegular,
// color: Colors.white
// ),),
// ),
// ),
// ),
// )
// ],
// ),
// ),
// ],
// ),
// Padding(
// padding: EdgeInsets.only(left: deviceHeight*0.01,top: deviceHeight*0.01,right: deviceHeight*0.01),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text(productstockin[index].toString(),
// style: TextStyle(
// fontSize: 12,
// fontFamily: ConstFont.popinsRegular,
// color: Colors.black
// ),),
// Text(productstockout[index].toString(),
// style: TextStyle(
// fontSize: 12,
// fontFamily: ConstFont.popinsRegular,
// color: Colors.black
// ),),
// Text(productstotalstock[index].toString(),
// style: TextStyle(
// fontSize: 12,
// fontFamily: ConstFont.popinsRegular,
// color: Colors.black
// ),),
// ],
// ),
// ),
// ],
// ),
// )
// ]
// )
// ],
// ),
// ),
// ),
// );
// })
// )