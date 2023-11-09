import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../ConstFile/constApi.dart';
import '../ConstFile/constPreferences.dart';
import '../Screens/home_screen.dart';
import '../api_services/all_services.dart';


class MyProfileController extends GetxController {

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getPrefData();
  }

  TextEditingController mobile_num_Controller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  RxString number = ''.obs;
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxBool isVisible = false.obs;
  int? messageCode;

  void getPrefData() async {
    // number.value = (await ConstPreferences().ge("mobilenumber"))!;
    name.value = (await ConstPreferences().getDistributorName('DistributorName'))!;
    email.value = (await ConstPreferences().getDistributorEmail('DistributorEmail'))!;
    debugPrint("mobile-num $number");
    nameController.text = name.value;
    emailController.text = email.value;
  }

  // Future<void> UpdateUserDetailAPI(String name,String email, String image, String pincode,context) async {
  //   // var user = await ConstPreferences().getUserData();
  //   // String? User_Id = await ConstPreferences().getUserId('UserId');
  //   // String? number = await ConstPreferences().getMobileNumber('mobilenumber');
  //   // String? full_Address = await ConstPreferences().getAddress();
  //   // String? land_Mark =  await ConstPreferences().getLandMark();
  //
  //   final response = await http.post(Uri.parse(ConstApi.updateUser), body: {
  //     "Id": User_Id,
  //     "MobileNo": number,
  //     "Address": full_Address,
  //     "LocationType": "City",
  //     "PinCode": pincode,
  //     "LandMark": land_Mark,
  //     "Latitude":  user!.latitude,
  //     "Longitute": user.longitute,
  //     "CustomerImage": image,
  //     "EmailId" : email,
  //     "Name" : name
  //   });
  //   var data = response.body;
  //   debugPrint(data);
  //
  //   if (response.statusCode == 200) {
  //     final responseData = updateUserModelFromJson(response.body);
  //     messageCode = responseData.messageCode;
  //     debugPrint(messageCode.toString());
  //
  //     if (messageCode == 200) {
  //       Utils().snackBar('Address Updated Successfully', '');
  //       userProfileController.UserDetailApi();
  //       final SharedPreferences pref = await SharedPreferences.getInstance();
  //       pref.setBool("login", true);
  //       Navigator.pop(context);
  //       Get.to(() => const BottomBarScreen(), arguments: homeController.currentIndex = 0);
  //     } else {
  //       debugPrint("error in update user");
  //     }
  //   } else {}
  // }
}
