import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grocery_distributor/Screens/godown_stock.dart';
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
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const OrderdetailsPage()));
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
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
                        leading: Image.asset('assets/Images/Maskgroup.png'),
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
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontFamily: ConstFont.popinsRegular,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        subtitle: Expanded(
                          child: Text(
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
                    ),
                  );
                })
            : CircularProgressIndicator(),
      ),
    );
  }
}
