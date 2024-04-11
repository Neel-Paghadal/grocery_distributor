import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:grocery_distributor/Common/utils.dart';
import 'package:grocery_distributor/Model/distributordeatil_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../ConstFile/constApi.dart';
import '../ConstFile/constPreferences.dart';
import '../Model/myProfile_model.dart';
import '../Screens/home_screen.dart';
import '../api_services/all_services.dart';

class MyProfileController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // UserDetailApi();
    // getPrefData();
  }

  RxList<DistibutorData> userList = <DistibutorData>[].obs;

  TextEditingController mobile_num_Controller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  RxString number = ''.obs;
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxBool isVisible = false.obs;
  int? messageCode;
  RxString? userProfileImage;
  RxString lowStockCount = ''.obs;
  RxString totalStockCount = ''.obs;

  void getPrefData() async {
    DistibutorData? distibutorData = await ConstPreferences().getUserData();
    userProfileImage!.value = distibutorData!.profileImage.toString();
    // number.value = (await ConstPreferences().ge("mobilenumber"))!;
    name.value =
        (await ConstPreferences().getDistributorName('DistributorName'))!;
    email.value =
        (await ConstPreferences().getDistributorEmail('DistributorEmail'))!;
    debugPrint("mobile-num $number");
    nameController.text = name.value;
    emailController.text = email.value;
  }

  Future<void> UserDetailApi() async {
    String? distributorId =
        await ConstPreferences().getDistributorId("DistributorId");

    final response = await http.post(Uri.parse(ConstApi.distributorDetail),
        body: {"Id": distributorId});
    var data = response.body;
    debugPrint(data.toString());

    if (response.statusCode == 200) {
      final responseData = distributorDetailFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint(messageCode.toString());
      if (messageCode == 200) {
        userList.clear();
        userList.addAll(responseData.data);
        ConstPreferences().setUserData(responseData.data[0]);
        debugPrint("user data Get Successfully");
      } else {
        debugPrint("Error");
      }
    } else {
      Utils().toastMessage("Something Went Wrong");
    }
  }

  Future<void> getDistributorProfile() async {
    print("call+++");
    String? distributorId =
        await ConstPreferences().getDistributorId("DistributorId");
    print('distributorId' + distributorId.toString());

    final response = await http.post(Uri.parse(ConstApi.distributorProfile),
        body: {"DistiButerId": distributorId});
    var data = response.body;
    debugPrint(data.toString());

    if (response.statusCode == 200) {
      final responseData = profileModelFromJson(response.body);
      debugPrint(responseData.toString());
      messageCode = responseData.messageCode;
      debugPrint(messageCode.toString());
      if (messageCode == 200) {
        lowStockCount.value = responseData.data[0].lowStockCount.toString();
        totalStockCount.value = responseData.data[0].totalStockCount.toString();
        print("totalStockCount${totalStockCount.value}");
        debugPrint("user data Get Successfully");
      } else {
        debugPrint("Error");
      }
    } else {
      Utils().toastMessage("Something Went Wrong");
    }
  }
}
