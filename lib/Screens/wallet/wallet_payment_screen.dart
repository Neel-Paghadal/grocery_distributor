import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:upi_india/upi_india.dart';
import '../../Common/appBar.dart';
import '../../ConstFile/constColor.dart';
import '../../ConstFile/constFonts.dart';
import '../../ConstFile/constPreferences.dart';
import '../../Controllers/wallet_controller.dart';
import 'package:http/http.dart' as http;

class WalletPaymentScreen extends StatefulWidget {
  WalletPaymentScreen({
    super.key,
    required this.sendTotalPrice,
  });
  double sendTotalPrice;
  @override
  State<WalletPaymentScreen> createState() => _WalletPaymentScreenState();
}

class _WalletPaymentScreenState extends State<WalletPaymentScreen> {
  // OrderController orderController = Get.put(OrderController());
  // CouponController couponController = Get.put(CouponController());
  // CartController cartController = Get.put(CartController());
  WalletController walletController = Get.put(WalletController());

  String? deliveryAddress;
  var couponId;
  bool isWallet = false;
  bool isUPIVisible = false;
  bool isVisible = false;
  bool isChecked = false;
  bool isCheckedfirst = false;
  bool isCheckedsecond = false;
  bool isCheckedthird = false;
  int? selectedOption;
  double deliveryCharge = 40.00;

  Future<UpiResponse>? _transaction;
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;
  List<UpiApp>? deviceApps;
  List<UpiApp>? appsStatic;
  List<UpiApp>? staticApp = [];
  List<UpiApp>? newAppsStatic;

  TextStyle header = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  double walletAmount = 0.0;

  TextStyle value = const TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  @override
  void initState() {
    getWalletAmount();
    // getPrefData();
    _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
      setState(() {
        staticApp!.add(UpiApp("GPay", ""));
        staticApp!.add(UpiApp("PhonePe", ""));
        staticApp!.add(UpiApp("Paytm", ""));
        staticApp!.add(UpiApp("Amazon", ""));
        staticApp!.add(UpiApp(
          "Cred",
          "",
        ));
        apps = value;
        deviceApps = value;
        appsStatic = value;
        newAppsStatic = value;
        List<UpiApp> itemsNotInList2 = staticApp!
            .where(
              (item1) => !apps!.any((item2) => item1.name == item2.name),
            )
            .toList();
        apps!.addAll(itemsNotInList2);
      });
    }).catchError((e) {
      apps = [];
      deviceApps = [];
      appsStatic = [];
    });
    super.initState();
  }

  Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "vivekchaudhary3434@axl",
      receiverName: 'Vivek Chaudhary',
      transactionRefId: 'TestingUpiIndiaPlugin',
      transactionNote: 'Not actual. Just an example.',
      amount: widget.sendTotalPrice,
    );
  }

  Widget displayUpiApps() {
    if (apps == null)
      return const Center(child: CircularProgressIndicator());
    else if (apps!.isEmpty) {
      return Center(
        child: Text(
          "No apps found to handle transaction.",
          style: header,
        ),
      );
    } else {
      return Flexible(
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: ScrollController(),
            child: Wrap(
              children: apps!.map<Widget>((UpiApp app) {
                return GestureDetector(
                  onTap: () {
                    _transaction = initiateTransaction(app);
                    setState(() {});
                  },
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.grey)),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: (app.name == "GPay")
                                ? Image.asset(
                                    "assets/Icons/googlepay.png",
                                    height: 40,
                                    width: 40,
                                  )
                                : (app.name == "PhonePe")
                                    ? Image.asset(
                                        "assets/Icons/phonepe.png",
                                        height: 40,
                                        width: 40,
                                      )
                                    : (app.name == "Amazon")
                                        ? Image.asset(
                                            "assets/Icons/amzonpay.png",
                                            height: 40,
                                            width: 40,
                                          )
                                        : (app.name == "Cred")
                                            ? Image.asset(
                                                "assets/Icons/cred.png",
                                                height: 40,
                                                width: 40,
                                              )
                                            : (app.name == "Paytm")
                                                ? Image.asset(
                                                    "assets/Icons/paytm.png",
                                                    height: 40,
                                                    width: 40,
                                                  )
                                                : null,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3),
                          child: Text(app.name),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      );
    }
  }

  String _upiErrorHandler(error) {
    switch (error) {
      case UpiIndiaAppNotInstalledException:
        return 'Requested app not installed on device';
      case UpiIndiaUserCancelledException:
        return 'You cancelled the transaction';
      case UpiIndiaNullResponseException:
        return 'Requested app didn\'t return any response';
      case UpiIndiaInvalidParametersException:
        return 'Requested app cannot handle the transaction';
      default:
        return 'An Unknown error has occurred';
    }
  }

  void _checkTxnStatus(String status) {
    switch (status) {
      case UpiPaymentStatus.SUCCESS:
        walletController.addWallet(
            widget.sendTotalPrice.toString(), status.toString());
        debugPrint('Transaction Successful');
        break;
      case UpiPaymentStatus.SUBMITTED:
        debugPrint('Transaction Submitted');
        break;
      case UpiPaymentStatus.FAILURE:
        debugPrint('Transaction Failed');
        break;
      default:
        debugPrint('Received an Unknown transaction status');
    }
  }

  Widget displayTransactionData(title, body) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title: ", style: header),
          Flexible(
              child: Text(
            body,
            style: value,
          )),
        ],
      ),
    );
  }

  // void getPrefData() async {
  //   deliveryAddress = await ConstPreferences().getAddress();
  //   deliveryCharge =
  //   await double.parse(ConstPreferences().getDiscount().toString());
  // }

  void getWalletAmount() async {
    walletAmount =
        (await ConstPreferences().getDistributorWalletAmount() ?? 0.0);
  }

  Widget displayAvailableApp() {
    if (deviceApps == null)
      return Center(child: CircularProgressIndicator());
    else if (deviceApps!.length == 0)
      return Center(
        child: Text(
          "No apps found to handle transaction.",
          style: header,
        ),
      );
    else
      return Expanded(
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              children: deviceApps!.map<Widget>((UpiApp deviceAvilableAppp) {
                return GestureDetector(
                  onTap: () {
                    _transaction = initiateTransaction(deviceAvilableAppp);
                    setState(() {});
                  },
                  child: Container(
                    height: 80,
                    width: 80,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        deviceAvilableAppp.packageName.isNotEmpty
                            ? Image.memory(
                                deviceAvilableAppp.icon,
                                height: 40,
                                width: 40,
                              )
                            : SizedBox(),
                        Text(deviceAvilableAppp.packageName.isNotEmpty
                            ? deviceAvilableAppp.name
                            : ""),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      );
  }

  double amount = 0.0;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Payment",
          style: const TextStyle(
              fontFamily: ConstFont.popinsMedium,
              fontSize: 16,
              color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.only(
                      top: deviceHeight * 0.01,
                      left: deviceWidth * 0.02,
                      right: deviceWidth * 0.02,
                      bottom: deviceHeight * 0.01),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            'Amount',
                            style: TextStyle(
                              fontFamily: ConstFont.popinsRegular,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          dense: true,
                          horizontalTitleGap: deviceWidth * 0.1,
                          contentPadding:
                              EdgeInsets.only(right: deviceWidth * 0.05),
                          trailing: Text(
                            "₹ " + widget.sendTotalPrice.toString(),
                            style: TextStyle(
                              fontFamily: ConstFont.popinsMedium,
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: ScrollController(),
              scrollDirection: Axis.vertical,
              child: Container(
                color: Colors.green.shade50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.025,
                    ),
                    Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: deviceWidth * 0.02,
                                top: deviceHeight * 0.02),
                            child: const Text(
                              "UPI",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: deviceHeight * 0.003),
                            child: ListTile(
                              leading: Container(
                                  height: deviceHeight * 0.04,
                                  width: deviceWidth * 0.09,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.grey)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Image.asset(
                                      "assets/Icons/upi-icon.png",
                                    ),
                                  )),
                              minLeadingWidth: deviceWidth * 0.05,
                              onTap: () {
                                // srgerg
                                // openGooglePay2("9510672463",520.0);
                              },
                              trailing: Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11)),
                                value: isUPIVisible,
                                activeColor: ConstColour.primaryColor,
                                // groupValue: selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    selectedOption = 1;
                                    isUPIVisible = value!;
                                    debugPrint("Button value: $value");
                                  });
                                },
                              ),
                              // onLongPress: () {},
                              title: const Text(
                                "Pay by Any UPI app",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: ConstFont.popinsMedium,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: const Text(
                                "Use any UPI app on your phone to pay",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: ConstFont.popinsRegular,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: isUPIVisible,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: deviceWidth * 0.05,
                                  top: deviceHeight * 0.03,
                                  bottom: deviceHeight * 0.02),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [displayAvailableApp()],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: deviceWidth * 0.05,
                                top: deviceHeight * 0.03,
                                bottom: deviceHeight * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                displayUpiApps(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.025,
                    ),
                    // Card(
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Padding(
                    //         padding: EdgeInsets.only(
                    //             left: deviceWidth * 0.02, top: deviceHeight * 0.02),
                    //         child: const Text(
                    //           "Pluxee | Sodexo",
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.bold, fontSize: 19),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: EdgeInsets.only(top: deviceHeight * 0.003),
                    //         child: ListTile(
                    //           leading: Container(
                    //               height: deviceHeight * 0.04,
                    //               width: deviceWidth * 0.09,
                    //               decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(5),
                    //                   border: Border.all(color: Colors.grey)
                    //               ),
                    //               child: Padding(
                    //                 padding: const EdgeInsets.all(5.0),
                    //                 child: Image.asset("assets/Icons/pluxee.png"),
                    //               )),
                    //           minLeadingWidth: deviceWidth * 0.05,
                    //           onTap: () {},
                    //           trailing: IconButton(
                    //               icon: const Icon(Icons.arrow_forward_ios),
                    //               iconSize: 20,
                    //               onPressed: () {
                    //                 walletController.isShowWallet.value == false;
                    //                 setState(() {
                    //                   debugPrint("Button value ");
                    //                   Get.to(() => const CardScreen());
                    //                 });
                    //               }),
                    //           iconColor: ConstColour.primaryColor,
                    //           // onLongPress: () {},
                    //           title: const Text(
                    //             "Pluxee | Sodexo Meal Card",
                    //             style: TextStyle(
                    //               fontSize: 15,
                    //               fontFamily: ConstFont.popinsRegular,
                    //               color: Colors.black,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: deviceHeight * 0.025,
                    // ),
                    Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: deviceWidth * 0.02,
                                top: deviceHeight * 0.02),
                            child: const Text(
                              "Cards",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: deviceHeight * 0.003),
                            child: ListTile(
                              leading: Container(
                                  height: deviceHeight * 0.04,
                                  width: deviceWidth * 0.09,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.grey)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Image.asset(
                                        "assets/Icons/credit-card.png"),
                                  )),
                              minLeadingWidth: deviceWidth * 0.05,
                              onTap: () {},
                              trailing: IconButton(
                                  icon: const Icon(Icons.arrow_forward_ios),
                                  iconSize: 20,
                                  onPressed: () {
                                    walletController.isShowWallet.value = false;
                                    setState(() {
                                      debugPrint("Button value ");
                                      // Get.to(() => const CardScreen());
                                    });
                                  }),
                              iconColor: ConstColour.primaryColor,
                              title: const Text(
                                "Credit/Debit Cards",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: ConstFont.popinsRegular,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.025,
                    ),
                    // Card(
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Padding(
                    //         padding: EdgeInsets.only(
                    //             left: deviceWidth * 0.02,
                    //             top: deviceHeight * 0.02),
                    //         child: const Text(
                    //           "Wallets",
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.bold, fontSize: 19),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: EdgeInsets.only(top: deviceHeight * 0.003),
                    //         child: ListTile(
                    //           leading: Container(
                    //               height: deviceHeight * 0.04,
                    //               width: deviceWidth * 0.09,
                    //               decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(5),
                    //                   border: Border.all(color: Colors.grey)),
                    //               child: Padding(
                    //                 padding: const EdgeInsets.all(5.0),
                    //                 child: Image.asset(
                    //                     "assets/Icons/appIcons.png"),
                    //               )),
                    //           minLeadingWidth: deviceWidth * 0.05,
                    //           onTap: () {},
                    //           trailing: Radio(
                    //             value: 2,
                    //             activeColor: ConstColour.primaryColor,
                    //             groupValue: selectedOption,
                    //             onChanged: (value) {
                    //               setState(() {
                    //                 walletController.isShowWallet.value = true;
                    //                 selectedOption = value;
                    //                 debugPrint("Button value: $value");
                    //               });
                    //             },
                    //           ),
                    //           // onLongPress: () {},
                    //           title: Row(
                    //             mainAxisAlignment:
                    //             MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               const Text(
                    //                 "AayuPlus Wallet",
                    //                 style: TextStyle(
                    //                   fontSize: 15,
                    //                   fontFamily: ConstFont.popinsRegular,
                    //                   color: Colors.black,
                    //                 ),
                    //               ),
                    //               Text(
                    //                 "₹ " + walletAmount.toString(),
                    //                 style: TextStyle(
                    //                   fontSize: 16,
                    //                   fontFamily: ConstFont.popinsMedium,
                    //                   color: Colors.black,
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //       walletController.isShowWallet.value == true
                    //           ? ElevatedButton(
                    //           style: ElevatedButton.styleFrom(
                    //               shape: RoundedRectangleBorder(
                    //                   side: BorderSide.none,
                    //                   borderRadius:
                    //                   BorderRadius.circular(6)),
                    //               backgroundColor: ConstColour.primaryColor,
                    //               minimumSize: Size(deviceWidth * 1.0,
                    //                   deviceHeight * 0.055),
                    //               maximumSize: Size(deviceWidth * 1.5,
                    //                   deviceHeight * 0.07),
                    //               elevation: 0.5),
                    //           onPressed: () async {
                    //             Get.to(() => WalletScreen());
                    //           },
                    //           child: const Text(
                    //             "Add Balance",
                    //             style: TextStyle(
                    //                 fontFamily: ConstFont.popinsMedium,
                    //                 fontSize: 18),
                    //           ))
                    //           : SizedBox(),
                    //     ],
                    //   ),
                    // ),
                    //
                    // SizedBox(
                    //   height: deviceHeight * 0.025,
                    // ),
                    Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: deviceWidth * 0.02,
                                top: deviceHeight * 0.02),
                            child: const Text(
                              "Net Banking",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 19),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: deviceHeight * 0.003),
                            child: ListTile(
                              leading: Container(
                                  height: deviceHeight * 0.04,
                                  width: deviceWidth * 0.09,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(color: Colors.grey)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Image.asset(
                                        "assets/Icons/credit-card.png"),
                                  )),
                              minLeadingWidth: deviceWidth * 0.05,
                              onTap: () {
                                walletController.isShowWallet.value == false;
                              },
                              // onLongPress: () {},
                              title: const Text(
                                "SBI",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: ConstFont.popinsRegular,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.025,
                    ),
                    // Card(
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Padding(
                    //         padding: EdgeInsets.only(
                    //             left: deviceWidth * 0.02,
                    //             top: deviceHeight * 0.02),
                    //         child: const Text(
                    //           "Pay On Delivery",
                    //           style: TextStyle(
                    //               fontWeight: FontWeight.bold, fontSize: 19),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: EdgeInsets.only(top: deviceHeight * 0.003),
                    //         child: ListTile(
                    //           leading: Container(
                    //               height: deviceHeight * 0.04,
                    //               width: deviceWidth * 0.09,
                    //               decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(5),
                    //                   border: Border.all(color: Colors.grey)),
                    //               child: Padding(
                    //                 padding: const EdgeInsets.all(5.0),
                    //                 child: Image.asset(
                    //                   "assets/Icons/cash.png",
                    //                 ),
                    //               )),
                    //           minLeadingWidth: deviceWidth * 0.05,
                    //           onTap: () {},
                    //           trailing: Checkbox(
                    //             shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(11)),
                    //             value: isVisible,
                    //             activeColor: ConstColour.primaryColor,
                    //             onChanged: (value) {
                    //               setState(() {
                    //                 selectedOption = 1;
                    //                 isCheckedthird = value!;
                    //                 isVisible = value!;
                    //                 debugPrint("Button value: $value");
                    //               });
                    //             },
                    //           ),
                    //           title: const Text(
                    //             "Cash On Delivery",
                    //             style: TextStyle(
                    //               fontSize: 15,
                    //               fontFamily: ConstFont.popinsMedium,
                    //               color: Colors.black,
                    //             ),
                    //           ),
                    //           subtitle: const Text(
                    //             "Pay by Cash/UPI on delivery",
                    //             style: TextStyle(
                    //               fontSize: 12,
                    //               fontFamily: ConstFont.popinsRegular,
                    //               color: Colors.black87,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //       Visibility(
                    //         visible: isVisible,
                    //         child: ElevatedButton(
                    //             style: ElevatedButton.styleFrom(
                    //                 shape: RoundedRectangleBorder(
                    //                     side: BorderSide.none,
                    //                     borderRadius: BorderRadius.circular(6)),
                    //                 backgroundColor: ConstColour.primaryColor,
                    //                 minimumSize: Size(deviceWidth * 1.0,
                    //                     deviceHeight * 0.055),
                    //                 maximumSize: Size(
                    //                     deviceWidth * 1.5, deviceHeight * 0.07),
                    //                 elevation: 0.5),
                    //             onPressed: () async {
                    //               walletController.isShowWallet.value == false;
                    //               if (couponController.coupon.isNotEmpty) {
                    //                 couponId = couponController.coupon[0].id;
                    //               } else {
                    //                 couponId = 0;
                    //               }
                    //               debugPrint(selectedOption.toString());
                    //
                    //               String? distributor_Id =
                    //               await ConstPreferences()
                    //                   .getDistributorId('DistributorId');
                    //               debugPrint("distributor_Id$distributor_Id");
                    //
                    //               // orderController.order_place(
                    //               //     widget.sendTotalPrice
                    //               //         .toStringAsFixed(2),
                    //               //     widget.sendTotalPrice.toStringAsFixed(2),
                    //               //     couponId.toString(),
                    //               //     cartController.cartDetailList.toList());
                    //             },
                    //             child: const Text(
                    //               "Order",
                    //               style: TextStyle(
                    //                   fontFamily: ConstFont.popinsMedium,
                    //                   fontSize: 18),
                    //             )),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: deviceHeight * 0.08,
                    // ),
                    FutureBuilder(
                      future: _transaction,
                      builder: (BuildContext context,
                          AsyncSnapshot<UpiResponse> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                _upiErrorHandler(snapshot.error.runtimeType),
                                style: header,
                              ), // Print's text message on screen
                            );
                          }
                          UpiResponse _upiResponse = snapshot.data!;
                          String txnId = _upiResponse.transactionId ?? 'N/A';
                          String resCode = _upiResponse.responseCode ?? 'N/A';
                          String txnRef =
                              _upiResponse.transactionRefId ?? 'N/A';
                          String status = _upiResponse.status ?? 'N/A';
                          String approvalRef =
                              _upiResponse.approvalRefNo ?? 'N/A';
                          _checkTxnStatus(status);

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                displayTransactionData('Transaction Id', txnId),
                                displayTransactionData(
                                    'Response Code', resCode),
                                displayTransactionData('Reference Id', txnRef),
                                displayTransactionData(
                                    'Status', status.toUpperCase()),
                                displayTransactionData(
                                    'Approval No', approvalRef),
                              ],
                            ),
                          );
                        } else
                          return const Center(
                            child: Text(''),
                          );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class _PaymentWalletScreenState extends State<PaymentWalletScreen> {
//   OrderController orderController = Get.put(OrderController());
//   CouponController couponController = Get.put(CouponController());
//   CartController cartController = Get.put(CartController());
//   WalletController walletController = Get.put(WalletController());
//
//
//   String? deliveryAddress;
//   var couponId;
//   bool isVisible = false;
//   bool isChecked = false;
//   bool isCheckedfirst = false;
//   bool isCheckedsecond = false;
//   bool isCheckedthird = false;
//   int? selectedOption;
//   double deliveryCharge = 40.00;
//
//   Future<UpiResponse>? _transaction;
//   UpiIndia _upiIndia = UpiIndia();
//   List<UpiApp>? apps;
//   List<UpiApp>? appsStatic;
//   // List<UpiApp>? staticApp = new ArrayList();
//   List<UpiApp>? newAppsStatic;
//
//   TextStyle header = const TextStyle(
//     fontSize: 18,
//     fontWeight: FontWeight.bold,
//   );
//   double walletAmount = 0.0;
//
//   TextStyle value = const TextStyle(
//     fontWeight: FontWeight.w400,
//     fontSize: 14,
//   );
//
//   @override
//   void initState() {
//     getWalletAmount();
//     // getPrefData();
//     _upiIndia.getAllUpiApps(mandatoryTransactionId: false).then((value) {
//       setState(() {
//         // staticApp!.add(UpiApp("GPay", ""));
//         // staticApp!.add(UpiApp("PhonePay", ""));
//         // staticApp!.add(UpiApp("Paytm", ""));
//         // staticApp!.add(UpiApp("Amazon", ""));
//         apps = value;
//         appsStatic = value;
//         newAppsStatic = value;
//       });
//     }).catchError((e) {
//       apps = [];
//       appsStatic = [];
//     });
//     super.initState();
//   }
//
//
//   Future<UpiResponse> initiateTransaction(UpiApp app) async {
//     return _upiIndia.startTransaction(
//       app: app,
//       receiverUpiId: "9510672463@ybl",
//       receiverName: 'Mr Patel',
//       transactionRefId: 'TestingUpiIndiaPlugin',
//       transactionNote: 'Not actual. Just an example.',
//       amount: widget.sendTotalPrice,
//     );
//   }
//
//   Widget displayUpiApps() {
//     if (apps == null)
//       return const Center(child: CircularProgressIndicator());
//     else if (apps!.isEmpty) {
//       return Center(
//         child: Text(
//           "No apps found to handle transaction.",
//           style: header,
//         ),
//       );
//     } else {
//       return Align(
//         alignment: Alignment.topCenter,
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Wrap(
//             children: apps!.map<Widget>((UpiApp app) {
//               return GestureDetector(
//                 onTap: () {
//                   _transaction = initiateTransaction(app);
//                   setState(() {});
//                 },
//                 child: SizedBox(
//                   height: 80,
//                   width: 80,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Image.memory(
//                         app.icon,
//                         height: 40,
//                         width: 40,
//                       ),
//                       Text(app.name),
//                     ],
//                   ),
//                 ),
//
//               );
//             }).toList(),
//           ),
//         ),
//       );
//     }
//   }
//
//   String _upiErrorHandler(error) {
//     switch (error) {
//       case UpiIndiaAppNotInstalledException:
//         return 'Requested app not installed on device';
//       case UpiIndiaUserCancelledException:
//         return 'You cancelled the transaction';
//       case UpiIndiaNullResponseException:
//         return 'Requested app didn\'t return any response';
//       case UpiIndiaInvalidParametersException:
//         return 'Requested app cannot handle the transaction';
//       default:
//         return 'An Unknown error has occurred';
//     }
//   }
//
//   Future<void> _checkTxnStatus(String status) async {
//     switch (status) {
//       case UpiPaymentStatus.SUCCESS:
//         amount = (await ConstPreferences().getUserWalletAmount() ?? 0.0);
//         double finalBalance =
//             amount + walletController.walletAmount!.toDouble();
//         ConstPreferences().setUserWalletAmount(finalBalance);
//         Navigator.pop(context, finalBalance);
//         debugPrint('Transaction Successful');
//         walletController.totalWalletAmount.value = await ConstPreferences().getUserWalletAmount() ?? 0.0;
//
//         break;
//       case UpiPaymentStatus.SUBMITTED:
//         debugPrint('Transaction Submitted');
//         break;
//       case UpiPaymentStatus.FAILURE:
//         amount = (await ConstPreferences().getUserWalletAmount() ?? 0.0);
//         double finalBalance = amount + walletController.walletAmount!.toDouble();
//         ConstPreferences().setUserWalletAmount(finalBalance);
//         Navigator.pop(context, finalBalance);
//         walletController.totalWalletAmount.value = await ConstPreferences().getUserWalletAmount() ?? 0.0;
//         debugPrint('Transaction Failed');
//         break;
//       default:
//         debugPrint('Received an Unknown transaction status');
//     }
//   }
//
//   Widget displayTransactionData(title, body) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text("$title: ", style: header),
//           Flexible(
//               child: Text(
//                 body,
//                 style: value,
//               )),
//         ],
//       ),
//     );
//   }
//
//
//   // void getPrefData() async {
//   //   deliveryAddress = await ConstPreferences().getAddress();
//   //   deliveryCharge = await double.parse(ConstPreferences().getDiscount().toString());
//   // }
//
//
//
//
//
//   void getWalletAmount() async {
//     walletAmount = (await ConstPreferences().getUserWalletAmount() ?? 0.0);
//   }
//
//
// // GPay, Amazon,
// //   Widget displayUpiApps() {
// //     if (apps == null)
// //       return const Center(child: CircularProgressIndicator());
// //     else if (apps!.length == 0)
// //       return Center(
// //         child: Text(
// //           "No apps found to handle transaction.",
// //           style: header,
// //         ),
// //       );
// //     else
// //       return Align(
// //         alignment: Alignment.topLeft,
// //         child: SingleChildScrollView(
// //           physics: const BouncingScrollPhysics(),
// //           child: Wrap(
// //             children: apps!.map<Widget>((UpiApp app) {
// //               return GestureDetector(
// //                 onTap: () {
// //                   _transaction = initiateTransaction(app);
// //                   setState(() {});
// //                 },
// //                 // child: Container(
// //                 //   height: 100,
// //                 //   width: 100,
// //                 child: Column(
// //                   mainAxisSize: MainAxisSize.min,
// //                   mainAxisAlignment: MainAxisAlignment.start,
// //                   children: <Widget>[
// //                     Container(
// //                       height: 35,
// //                       width: 35,
// //                       decoration: BoxDecoration(
// //                           borderRadius: BorderRadius.circular(5),
// //                           border: Border.all(color: Colors.grey)
// //                       ),
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(1.0),
// //                         child: Image.memory(
// //                           app.icon,
// //                           height: 60,
// //                           width: 60,
// //                         ),
// //                       ),
// //                     ),
// //                     Padding(
// //                       padding: EdgeInsets.only(top: 5),
// //                       child: Text(app.name),
// //                     ),
// //                   ],
// //                 ),
// //                 // ),
// //               );
// //             }).toList(),
// //           ),
// //         ),
// //       );
// //   }
//
//
//
//
//   double amount = 0.0;
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     final deviceHeight = MediaQuery.of(context).size.height;
//     final deviceWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       bottomNavigationBar: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//               shape: RoundedRectangleBorder(
//                   side: BorderSide.none,
//                   borderRadius: BorderRadius.circular(6)),
//               backgroundColor: ConstColour.primaryColor,
//               minimumSize: Size(deviceWidth * 1.0, deviceHeight * 0.055),
//               maximumSize: Size(deviceWidth * 1.5, deviceHeight * 0.07),
//               elevation: 0.5),
//           onPressed: () async {
//             if (couponController.coupon.isNotEmpty) {
//               couponId = couponController.coupon[0].id;
//             } else {
//               couponId = 0;
//             }
//             if (selectedOption == null) {
//               Utils().snackBar('Please Select Payment Type', '');
//             } else {
//               debugPrint(selectedOption.toString());
//
//               String? distributor_Id =
//               await ConstPreferences().getDistributorId('DistributorId');
//               debugPrint("distributor_Id$distributor_Id");
//
//               // sendRequest();
//               if (selectedOption == 1) {
//
//               } else if(selectedOption == 2){
//                 Get.to(() => const BottomBarScreen(), arguments: {homeController.currentIndex = 2});
//
//               } else if(selectedOption == 3){
//                 Get.to(() => const CardScreen());
//               }
//
//               else {
//
//               }
//             }
//           },
//           child: const Text(
//             "Pay Now",
//             style: TextStyle(fontFamily: ConstFont.popinsMedium, fontSize: 18),
//           )),
//       appBar: PreferredSize(
//           preferredSize: Size(deviceWidth, deviceHeight),
//           child: DetailsAppbar(
//             title: 'Payment',
//             onPressed: () {
//               Get.back();
//             },
//             onTap: () {},
//           )),
//       // bottomNavigationBar: ElevatedButton(
//       //     style: ElevatedButton.styleFrom(
//       //         shape: RoundedRectangleBorder(
//       //             side: BorderSide.none,
//       //             borderRadius: BorderRadius.circular(6)),
//       //         backgroundColor: ConstColour.primaryColor,
//       //         minimumSize: Size(deviceWidth * 1.0, deviceHeight * 0.055),
//       //         maximumSize: Size(deviceWidth * 1.5, deviceHeight * 0.07),
//       //         elevation: 0.5),
//       //     onPressed: () async {
//       //       var couponId;
//       //       if (couponController.coupon.isNotEmpty) {
//       //         couponId = couponController.coupon[0].id;
//       //       } else {
//       //         couponId = 0;
//       //       }
//       //       if (selectedOption == null) {
//       //         Utils().snackBar('Please Select Payment Type', '');
//       //       } else  {
//       //         debugPrint(selectedOption.toString());
//       //
//       //         String? distributor_Id =
//       //             await ConstPreferences().getDistributorId('DistributorId');
//       //         debugPrint("distributor_Id$distributor_Id");
//       //
//       //         // sendRequest();
//       //              if(selectedOption == 1 || selectedOption == 4){
//       //
//       //                // Navigator.push(context, MaterialPageRoute(builder: (context) =>
//       //
//       //                    // GoogleHomePage(sendFinalAmountForOrder: widget.sendFinalAmountForOrder, sendTotalPrice: widget.sendTotalPrice, coupnId: couponId, /*sendFinalPrice: finalPrice*/)));
//       //
//       //              }else{
//       //
//       //                // orderController.order_place(
//       //                //     widget.sendFinalAmountForOrder.toStringAsFixed(2),
//       //                //     widget.sendTotalPrice.toStringAsFixed(2),
//       //                //     couponId.toString(),
//       //                //     cartController.cartDetailList.toList());
//       //              }
//       //
//       //
//       //       }
//       //     },
//       //     child: const Text(
//       //       "Pay Now",
//       //       style: TextStyle(fontFamily: ConstFont.popinsMedium, fontSize: 18),
//       //     )),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Stack(
//             children: [
//
//             ],
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               controller: ScrollController(),
//               scrollDirection: Axis.vertical,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
//                     height: deviceHeight * 0.03,
//                   ),
//                   Card(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(
//                               left: deviceWidth * 0.02, top: deviceHeight * 0.02),
//                           child: const Text(
//                             "UPI",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 19),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(top: deviceHeight * 0.003),
//                           child: ListTile(
//                             leading: Container(
//                                 height: deviceHeight * 0.04,
//                                 width: deviceWidth * 0.09,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(5),
//                                     border: Border.all(color: Colors.grey)
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(5.0),
//                                   child: Image.asset(
//                                     "assets/Icons/upi-icon.png",
//                                   ),
//                                 )),
//                             minLeadingWidth: deviceWidth * 0.05,
//                             onTap: () {
//                               // srgerg
//                               // openGooglePay2("9510672463",520.0);
//                             },
//                             trailing: Checkbox(
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(11)),
//                               value: isVisible,
//                               activeColor: ConstColour.primaryColor,
//                               // groupValue: selectedOption,
//                               onChanged: (value) {
//                                 setState(() {
//                                   selectedOption = 1;
//                                   isVisible = value!;
//                                   debugPrint("Button value: $value");
//                                 });
//                               },
//                             ),
//                             // onLongPress: () {},
//                             title: const Text(
//                               "Pay by Any UPI app",
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontFamily: ConstFont.popinsMedium,
//                                 color: Colors.black,
//                               ),
//                             ),
//                             subtitle: const Text(
//                               "Use any UPI app on your phone to pay",
//                               style: TextStyle(
//                                 fontSize: 10,
//                                 fontFamily: ConstFont.popinsRegular,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                           ),
//                         ),
//                         Visibility(
//                           visible: isVisible,
//                           child: Padding(
//                             padding: EdgeInsets.only(
//                                 left: deviceWidth * 0.05,
//                                 top: deviceHeight * 0.03,
//                                 bottom: deviceHeight * 0.02),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//
//                               children: [
//                                 displayUpiApps(),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(
//                               left: deviceWidth * 0.05,
//                               top: deviceHeight * 0.03,
//                               bottom: deviceHeight * 0.02),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               displayUpiApps(),
//                             ],
//                           ),
//                         ),
//                         // Padding(
//                         //   padding: EdgeInsets.only(
//                         //       left: deviceWidth * 0.05,
//                         //       top: deviceHeight * 0.03,
//                         //       bottom: deviceHeight * 0.02),
//                         //   child: Row(
//                         //     mainAxisAlignment: MainAxisAlignment.center,
//                         //     children: [
//                         //       ElevatedButton(
//                         //         onPressed: () {},
//                         //         style: ElevatedButton.styleFrom(
//                         //           primary: Colors.white,
//                         //         ),
//                         //         child: const Text(
//                         //           'Other UPI Options',
//                         //           style: TextStyle(
//                         //             fontSize: 18,
//                         //             fontFamily: ConstFont.popinsMedium,
//                         //             color: Colors.black,
//                         //           ),
//                         //         ),
//                         //       ),
//                         //     ],
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: deviceHeight * 0.03,
//                   ),
//                   Card(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(
//                               left: deviceWidth * 0.02, top: deviceHeight * 0.02),
//                           child: const Text(
//                             "Pluxee | Sodexo",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 19),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(top: deviceHeight * 0.003),
//                           child: ListTile(
//                             leading: Container(
//                                 height: deviceHeight * 0.04,
//                                 width: deviceWidth * 0.09,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(5),
//                                     border: Border.all(color: Colors.grey)
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(5.0),
//                                   child: Image.asset("assets/Icons/pluxee.png"),
//                                 )),
//                             minLeadingWidth: deviceWidth * 0.05,
//                             onTap: () {},
//                             trailing: IconButton(
//                                 icon: const Icon(Icons.arrow_forward_ios),
//                                 iconSize: 20,
//                                 onPressed: () {
//                                   setState(() {
//                                     debugPrint("Button value ");
//                                     Get.to(() => const CardScreen());
//                                   });
//                                 }),
//                             iconColor: ConstColour.primaryColor,
//                             // onLongPress: () {},
//                             title: const Text(
//                               "Pluxee | Sodexo Meal Card",
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontFamily: ConstFont.popinsRegular,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: deviceHeight * 0.03,
//                   ),
//                   Card(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(
//                               left: deviceWidth * 0.02, top: deviceHeight * 0.02),
//                           child: const Text(
//                             "Cards",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 19),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(top: deviceHeight * 0.003),
//                           child: ListTile(
//                             leading: Container(
//                                 height: deviceHeight * 0.04,
//                                 width: deviceWidth * 0.09,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(5),
//                                     border: Border.all(color: Colors.grey)
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(5.0),
//                                   child: Image.asset("assets/Icons/credit-card.png"),
//                                 )),
//                             minLeadingWidth: deviceWidth * 0.05,
//                             onTap: () {},
//                             trailing: IconButton(
//                                 icon: const Icon(Icons.arrow_forward_ios),
//                                 iconSize: 20,
//                                 onPressed: () {
//                                   setState(() {
//                                     debugPrint("Button value ");
//                                     Get.to(() => const CardScreen());
//                                   });
//                                 }),
//                             iconColor: ConstColour.primaryColor,
//                             // Radio(
//                             //   value: 3,
//                             //   activeColor: ConstColour.primaryColor,
//                             //   groupValue: selectedOption,
//                             //   onChanged: (value) {
//                             //     setState(() {
//                             //       selectedOption = value;
//                             //       debugPrint("Button value: $value");
//                             //       Get.to(() => const CardScreen());
//                             //     });
//                             //   },
//                             // ),
//                             // onLongPress: () {},
//                             title: const Text(
//                               "Credit/Debit Cards",
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontFamily: ConstFont.popinsRegular,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//
//
//                   SizedBox(
//                     height: deviceHeight * 0.03,
//                   ),
//                   Card(
//                     // shape: RoundedRectangleBorder(
//                     //   borderRadius: BorderRadius.circular(15.0),
//                     // ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(
//                               left: deviceWidth * 0.02, top: deviceHeight * 0.02),
//                           child: const Text(
//                             "Net Banking",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold, fontSize: 19),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(top: deviceHeight * 0.003),
//                           child: ListTile(
//                             leading: Container(
//                                 height: deviceHeight * 0.04,
//                                 width: deviceWidth * 0.09,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(5),
//                                     border: Border.all(color: Colors.grey)
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(5.0),
//                                   child: Image.asset("assets/Icons/credit-card.png"),
//                                 )),
//                             minLeadingWidth: deviceWidth * 0.05,
//                             onTap: () {},
//                             // onLongPress: () {},
//                             title: const Text(
//                               "SBI",
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontFamily: ConstFont.popinsRegular,
//                                 color: Colors.black,
//                               ),
//                             ),
//                           ),
//                         ),
//                         // Padding(
//                         //   padding: EdgeInsets.only(
//                         //       left: deviceWidth * 0.05,
//                         //       top: deviceHeight * 0.003,
//                         //       bottom: deviceHeight * 0.02),
//                         //   child: Row(
//                         //     mainAxisAlignment: MainAxisAlignment.center,
//                         //     children: [
//                         //       ElevatedButton(
//                         //         onPressed: () {},
//                         //         style: ElevatedButton.styleFrom(
//                         //           primary: Colors.white,
//                         //           // minimumSize: Size.fromHeight(deviceHeight * 0.02),
//                         //         ),
//                         //         child: const Text(
//                         //           'Other Banks',
//                         //           style: TextStyle(
//                         //             fontSize: 18,
//                         //             fontFamily: ConstFont.popinsMedium,
//                         //             color: Colors.black,
//                         //           ),
//                         //         ),
//                         //       ),
//                         //     ],
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: deviceHeight * 0.03,
//                   ),
//
//                   SizedBox(
//                     height: deviceHeight * 0.08,
//                   ),
//                   FutureBuilder(
//                     future: _transaction,
//                     builder: (BuildContext context,
//                         AsyncSnapshot<UpiResponse> snapshot) {
//                       if (snapshot.connectionState == ConnectionState.done) {
//                         if (snapshot.hasError) {
//                           return Center(
//                             child: Text(
//                               _upiErrorHandler(snapshot.error.runtimeType),
//                               style: header,
//                             ), // Print's text message on screen
//                           );
//                         }
//
//                         // If we have data then definitely we will have UpiResponse.
//                         // It cannot be null
//                         UpiResponse _upiResponse = snapshot.data!;
//
//                         // Data in UpiResponse can be null. Check before printing
//                         String txnId = _upiResponse.transactionId ?? 'N/A';
//                         String resCode = _upiResponse.responseCode ?? 'N/A';
//                         String txnRef = _upiResponse.transactionRefId ?? 'N/A';
//                         String status = _upiResponse.status ?? 'N/A';
//                         String approvalRef = _upiResponse.approvalRefNo ?? 'N/A';
//                         _checkTxnStatus(status);
//
//                         return Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               displayTransactionData('Transaction Id', txnId),
//                               displayTransactionData('Response Code', resCode),
//                               displayTransactionData('Reference Id', txnRef),
//                               displayTransactionData(
//                                   'Status', status.toUpperCase()),
//                               displayTransactionData('Approval No', approvalRef),
//                             ],
//                           ),
//                         );
//                       } else
//                         return const Center(
//                           child: Text(''),
//                         );
//                     },
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   // void openGooglePay2(String phoneNumber, double amount) async {
//   //   // String deepLink = "https://pay.google.com/gp/v/u/0/send?phone=$phoneNumber&amount=$amount";
//   //   String deepLink = "https://pay.google.com/pay?phone=$phoneNumber&amount=$amount";
//   //
//   //   try {
//   //     if (await canLaunch(deepLink)) {
//   //       await launch(deepLink);
//   //     } else {
//   //       throw 'Could not launch $deepLink';
//   //     }
//   //   } catch (e) {
//   //     print('Error launching deep link: $e');
//   //   }
//   // }
//   // void openGooglePay(String phoneNumber, double amount) async {
//   //   // Replace "yourPackageName" with your app's package name
//   //   String packageName = "com.example.grocery_user";
//   //
//   //   // Replace "yourScheme" with your app's custom scheme
//   //   String scheme = "https://pay.google.com/about";
//   //
//   //   String url = "upi://pay?pa=$phoneNumber&pn=PayeeName&mc=yourMerchantCode&tid=yourTransactionId&tr=yourRefId&tn=Payment%20for%20purchase&am=$amount&cu=INR&url=https://your-transaction-response-url/";
//   //
//   //   String url2 = 'upi://pay?pa=example@bank&pn=TestName&mc=123&tid=456&tr=123456&tn=Test%20Transaction&am=10.00&cu=INR';
//   //
//   //   // Encode the URL
//   //   String encodedUrl = Uri.encodeFull(url);
//   //
//   //   // Create the final deep link
//   //   String deepLink = "$scheme://$packageName?data=$encodedUrl";
//   //   print("deepLink$deepLink");
//   //
//   //   if (await canLaunch(url2)) {
//   //     print("deepLink success$deepLink");
//   //     // await launch(deepLink);
//   //     await launch(url2);
//   //   } else {
//   //     print("faild deepLink$deepLink");
//   //     throw 'Could not launch $deepLink';
//   //   }
//   // }
//   //
//   // void openGooglePayy(/*String phoneNumber*/) async {
//   //   // Construct the Google Pay URL with the phone number
//   //   final googlePayUrl = 'https://pay.google.com/gp?v=upi&t=phone&mc=+919879467222';
//   //
//   //   // Use the url_launcher package to open the URL
//   //   if (await canLaunch(googlePayUrl)) {
//   //     await launch(googlePayUrl);
//   //   } else {
//   //     // Handle error, e.g., if the URL can't be launched
//   //     print('Could not launch $googlePayUrl');
//   //   }
//   // }
//   //
//   // void onGooglePayResult(paymentResult) {
//   //   debugPrint(paymentResult.toString());
//   //   // Send the resulting Google Pay token to your server / PSP
//   // }
//
//   // void _requestGooglePay() async {
//   //   GooglePayPaymentRequest googlePayPaymentRequest = GooglePayPaymentRequest(
//   //     billingAddressRequired: true,
//   //     currencyCode: 'INR',
//   //     totalPrice: '1.00',
//   //     countryCode: 'INR',
//   //     isEmailRequired: true,
//   //   );
//   //
//   //   GooglePayPaymentResponse paymentResponse =
//   //   await GooglePay.requestPayment(googlePayPaymentRequest);
//   //
//   //   if (paymentResponse.status == GooglePayStatus.SUCCESS) {
//   //     // Payment successful, handle accordingly
//   //     print('Payment successful');
//   //   } else if (paymentResponse.status == GooglePayStatus.FAILURE) {
//   //     // Payment failed, handle accordingly
//   //     print('Payment failed');
//   //   } else if (paymentResponse.status == GooglePayStatus.CANCELED) {
//   //     // Payment was canceled by the user
//   //     print('Payment canceled');
//   //   }
//   // }
//
//   void sendRequest() async {
//     // Replace the URL with your actual endpoint
//     var url =
//         'http://208.64.33.118/ECommerce/api/Product/Order_Assign_InsertData';
//
//     // Replace the JSON data with your actual request data
//     var requestData = {
//       "CustomerId": 1,
//       "DistriButerId": 20,
//       "CouponId": 1,
//       "FinalAmount": "100",
//       "TotalAmount": "120",
//       "DeliveryAddress": "Sudama chowk Surat",
//       "PaymentType": "COD",
//       "Products": [
//         {
//           "Id": 1,
//           "PriceId": 1,
//           "ProductId": 1,
//           "Quantity": "7",
//           "ProductName": "kellogg's chocos",
//           "Unit": "250.00 g",
//           "Description": "can",
//           "ProductImage":
//           "http://208.64.33.118:8085//Docs/Distibutor/24/16976922941995757.png",
//           "Price": "144.0",
//           "OfferPrice": "136.8"
//         }
//       ]
//     };
//
//     // Convert the request data to a JSON string
//     var requestBody = jsonEncode(requestData);
//
//     // Set the headers for the request
//     var headers = {'Content-Type': 'application/json'};
//
//     try {
//       // Send the POST request
//       var response = await http.post(
//         Uri.parse(url),
//         headers: headers,
//         body: requestBody,
//       );
//
//       // Check if the request was successful (status code 200)
//       if (response.statusCode == 200) {
//         // Parse and handle the response data as needed
//         var responseData = jsonDecode(response.body);
//         debugPrint('Response: $responseData');
//       } else {
//         // Handle error cases
//         debugPrint('Error: ${response.statusCode}, ${response.reasonPhrase}');
//       }
//     } catch (e) {
//       // Handle exceptions
//       debugPrint('Exception: $e');
//     }
//   }
// }
