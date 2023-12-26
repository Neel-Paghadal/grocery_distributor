import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/ConstFile/constColor.dart';
import 'package:grocery_distributor/ConstFile/constFonts.dart';
import 'package:grocery_distributor/Controllers/orderGenrate_controller.dart';

class OrderGenrateBottom extends StatefulWidget {
  String image;
  String productName;
  OrderGenrateBottom({super.key, required this.productName, required this.image ,});

  @override
  State<OrderGenrateBottom> createState() => _OrderGenrateBottomState();
}

class _OrderGenrateBottomState extends State<OrderGenrateBottom> {

  OrderGenrateController orderGenrate = Get.put(OrderGenrateController());



  @override
  Widget build(BuildContext context) {

    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Image.network(height: 50, width: 55, widget.image),
            title: Text(
              widget.productName,
              // "PRodcsfs ",
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
                  () => ListView.builder(
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      child: ListTile(
                        onTap: () {
                          Get.back();
                          orderGenrate.showDialogs(context);
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
                            widget.image
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
                      ),
                    ),
                  );
                },),
            ),
          )
        ],
      ),
    );
  }
}
