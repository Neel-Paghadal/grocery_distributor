import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery_distributor/Screens/godown_stock.dart';
import 'package:grocery_distributor/Screens/loader.dart';
import 'package:grocery_distributor/Screens/order_details.dart';
import '../ConstFile/constFonts.dart';
import '../Controllers/user_list_controller.dart';

class UserPage extends StatefulWidget {
  const UserPage({
    Key? key,
  }) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  UserListController userListController = Get.put(UserListController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userListController.UserListApiCall();
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context).push(MaterialPageRoute(
        //         builder: (context) => const OrderdetailsPage()));
        //   },
        //   icon: const Icon(
        //     Icons.arrow_back_ios,
        //     color: Colors.black,
        //   ),
        // ),
        automaticallyImplyLeading: false,
        actions: [Image.asset("assets/Icons/notification.png")],
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "User List",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Obx(
        () => userListController.allUser.isNotEmpty
            ? ListView.builder(
          shrinkWrap: true,
                scrollDirection: Axis.vertical,
                controller: ScrollController(),
                itemCount: userListController.allUser.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: deviceWidth * 0.016,
                      right: deviceWidth * 0.016,
                    ),
                    child: Card(
                      color: const Color(0xffF3F4F4),
                      child: ListTile(
                        onTap: () {},
                        leading:

                        Image(
                          width: deviceWidth * 0.1,
                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                            // Custom error widget to display when image fails to load
                            return Icon(Icons.image,size: 45,);
                          },
                          image:  NetworkImage(
                              userListController.allUser[index].customerImage.toString(),),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const GodownPage()));
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                        ),
                        title: Text(
                          userListController.allUser[index].name.toString(),
                          style:  TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: ConstFont.popinsRegular,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        subtitle: Text(
                          userListController.allUser[index].address
                              .toString(),
                          style: const TextStyle(
                              fontFamily: ConstFont.popinsRegular,
                              color: Colors.black,
                              fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  );
                })
            :  Loaders(
          items: 10,
          direction: LoaderDirection.ltr,
          builder: Padding(
            padding: EdgeInsets.only(right: deviceWidth * 0.01),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      mainAxisAlignment:
                      MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: deviceWidth * 0.018),
                          child: const Icon(
                            Icons.image,
                            size: 80,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment:
                      MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: deviceHeight * 0.01,
                              left: deviceWidth * 0.02),
                          child: Container(
                            color: Colors.grey,
                            width: deviceWidth * 0.6,
                            height: deviceHeight * 0.01,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: deviceHeight * 0.02,
                              left: deviceWidth * 0.02),
                          child: Container(
                            color: Colors.grey,
                            width: deviceWidth * 0.6,
                            height: deviceHeight * 0.01,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: deviceHeight * 0.02,
                              left: deviceWidth * 0.02,
                              bottom: deviceHeight * 0.02),
                          child: Container(
                            color: Colors.grey,
                            width: deviceWidth * 0.6,
                            height: deviceHeight * 0.01,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
