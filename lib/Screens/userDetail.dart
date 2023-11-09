import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/Controllers/userOrderHistory_controller.dart';
import 'package:grocery_distributor/Screens/loader.dart';
import '../ConstFile/constColor.dart';
import '../ConstFile/constFonts.dart';
import '../Controllers/home_controller.dart';
import '../Controllers/user_list_controller.dart';
import 'userOrder_history.dart';

class UserDetailPage extends StatefulWidget {
  int userIndex;
  UserDetailPage({super.key, required this.userIndex,});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  HomeController homeController = Get.put(HomeController());
  UserListController userListController = Get.put(UserListController());
  UserOrderHistoryController userOrderHistoryController = Get.put(UserOrderHistoryController());

  @override
  Widget build(BuildContext context) {
    debugPrint("rebuild");
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.yellow.shade100,
      // backgroundColor: Colors.white,
      appBar: AppBar(

        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Tooltip(
            message: "Customer History",
            child: IconButton(onPressed: () {
              userOrderHistoryController.UserOrderListApiCall(userOrderHistoryController.customerId.toString());

               Get.to(() => const UserOrderHistory());
            },icon: const Icon(Icons.manage_history_outlined,color: Colors.black),),
          )
        ],
        centerTitle: true,
        elevation: 0.0,
        // backgroundColor: Colors.white,
        backgroundColor: Colors.yellow.shade100,
        title:  const Text("Customer Detail",
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontFamily: ConstFont.popinsMedium),
            maxLines: 1,
            overflow: TextOverflow.ellipsis),
      ),
      body: FutureBuilder<dynamic>(
        future: userListController.UserListApiCall(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display shimmer while waiting for data
            return Loaders(
              items: 1,
              direction: LoaderDirection.ltr,
              builder: Padding(
                padding: EdgeInsets.only(right: deviceWidth * 0.01),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.grey,
                      height: deviceHeight * 0.3,
                      width: deviceWidth * 0.9,

                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.grey,
                        height: deviceHeight * 0.06,
                        width: deviceWidth * 0.7,

                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.grey,
                        height: deviceHeight * 0.06,
                        width: deviceWidth * 0.9,

                      ),
                    ), Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.grey,
                        height: deviceHeight * 0.06,
                        width: deviceWidth * 0.9,

                      ),
                    ), Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.grey,
                        height: deviceHeight * 0.06,
                        width: deviceWidth * 0.9,

                      ),
                    ), Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.grey,
                        height: deviceHeight * 0.06,
                        width: deviceWidth * 0.9,

                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            // Handle error
            return Center(child: Text('Error: ${snapshot.error}',style: const TextStyle(color: Colors.black,fontFamily: ConstFont.popinsRegular,fontSize: 18,overflow: TextOverflow.ellipsis,),));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            // Display "No data available" message
            return const Center(child: Text('No data available',style: TextStyle(color: Colors.black,fontFamily: ConstFont.popinsRegular,fontSize: 18,overflow: TextOverflow.ellipsis,)));
          } else if (snapshot.hasData) {
            // Display the fetched data
            return   ListView.builder(
                    itemCount: 1,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    controller: ScrollController(),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                // color: Colo,
                              ),
                              height: deviceHeight * 0.25,
                              child: Image(

                                width: deviceWidth  * 2.0,
                                errorBuilder: (BuildContext context, Object exception,
                                    StackTrace? stackTrace) {
                                  // Custom error widget to display when image fails to load
                                  return const Center(
                                      child: Icon(
                                        Icons.image,
                                        size: 200,
                                      ));
                                },
                                image: NetworkImage(
                                  userListController
                                      .allUser[widget.userIndex].customerImage,
                                ),
                              ),
                            ),
                          ),
                          const Center(
                            child: Text("⫷ Customer Details ⫸",
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black,
                                    fontFamily: ConstFont.popinsMedium),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 5.5,
                              color: ConstColour.primaryColor,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Card(
                                    color: Colors.white,
                                    child: ListTile(
                                      // tileColor: ConstColour.cardBgColor,

                                      title:Text(userListController.allUser[widget.userIndex].name,
                                          style: const TextStyle(
                                              fontSize: 24,
                                              color: Colors.black,
                                              fontFamily: ConstFont.popinsMedium),
                                          maxLines: 3,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                  Card(
                                    color: Colors.white,

                                    child: ListTile(
                                      // tileColor: ConstColour.cardBgColor,

                                      title: const Text("Address : ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontFamily: ConstFont.popinsMedium),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis),
                                      subtitle: Text(
                                          userListController.allUser[widget.userIndex].address,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black87,

                                              fontFamily: ConstFont.popinsRegular),
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ),
                                  Card(
                                    color: Colors.white,
                                    child: ListTile(
                                      // tileColor: ConstColour.cardBgColor,

                                      title:
                                      Row(
                                        children: [
                                          const Text("Phone No : ",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontFamily: ConstFont.popinsMedium),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis),
                                          Text(
                                              userListController.allUser[widget.userIndex].mobileNo,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black87,
                                                  fontFamily: ConstFont.popinsRegular),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis),
                                        ],
                                      ),

                                    ),
                                  ),
                                  Card(
                                    color: Colors.white,
                                    child: ListTile(
                                      // tileColor: ConstColour.cardBgColor,

                                      title: Row(
                                        children: [
                                          const Text("Pincode : ",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontFamily: ConstFont.popinsMedium),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis),
                                          Text(userListController.allUser[widget.userIndex].pinCode,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black87,
                                                  fontFamily: ConstFont.popinsRegular),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },

            );
          } else {
            // This is a fallback in case something unexpected happens
            return const Center(child: Text('Unexpected error',style: TextStyle(color: Colors.black,fontFamily: ConstFont.popinsRegular,fontSize: 18,overflow: TextOverflow.ellipsis,)));
          }
        },
      ),
    );
  }
}
