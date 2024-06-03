import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/Controllers/notification_controller.dart';
import '../ConstFile/constFonts.dart';
import 'loader.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationController notificationController =
      Get.put(NotificationController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationController.isNoNewNotification.value = true;
    notificationController.getNotification();
  }
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Notification",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Obx(() => notificationController.notificationList.isEmpty
          ?    notificationController.isNoNewNotification.value == false
          ? const Center(child: Text("No Notification Found")) : Loaders(
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
                  itemCount: notificationController.notificationList.length,
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
                          dense: false,
                          tileColor: Colors.grey.shade50,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          leading: const Icon(Icons.calendar_month_outlined),
                          title: Text(
                              notificationController
                                  .notificationList[index].message
                                  .toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: ConstFont.popinsMedium,
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2),
                        ),
                      ),
                    );
                  },
                )),
    );
  }
}
