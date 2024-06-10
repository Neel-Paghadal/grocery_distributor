import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/Screens/wallet/wallet_payment_screen.dart';
import 'package:grocery_distributor/api_services/all_services.dart';
import '../../Common/utils.dart';
import '../../ConstFile/constColor.dart';
import '../../ConstFile/constFonts.dart';
import '../../ConstFile/constPreferences.dart';
import '../../Controllers/wallet_controller.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  // HomeController homeController = Get.put(HomeController());
  WalletController walletController = Get.put(WalletController());
  int? selectedValueIndex = 0;
  // TextEditingController amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    walletController.getPrefData();
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Wallet",
          style: const TextStyle(
              fontFamily: ConstFont.popinsMedium,
              fontSize: 16,
              color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.02),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight * 0.02),
                  child: Container(
                    height: deviceHeight * 0.1,
                    decoration: BoxDecoration(
                      color: ConstColour.greenColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: deviceWidth * 0.015),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "₹ ${homeController.formatPrice(walletController.totalWalletAmount.value == 0.0
                                    ? 0.0
                                    : walletController.totalWalletAmount.value)}",
                                style: const TextStyle(
                                    fontFamily: ConstFont.popinsMedium,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              const Text(
                                "Total Balance",
                                style: TextStyle(
                                    fontFamily: ConstFont.popinsMedium,
                                    fontSize: 12,
                                    color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: deviceHeight * 0.01),
                  child: ListTile(
                    onTap: walletController.totalWalletAmount.value > 0
                        ? () {showDialogs();}
                        : () {
                      Utils().snackBar("Cannot withdraw when total balance is 0", "");
                    },
                    shape: OutlineInputBorder(
                      borderSide: BorderSide(color: ConstColour.btnHowerColor),
                    ),
                    dense: true,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/Icons/with_draw.png",
                          fit: BoxFit.cover,
                          height: deviceHeight * 0.025,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: deviceWidth * 0.04),
                          child: Text(
                            "Withdrawal",
                            style: TextStyle(
                                fontFamily: ConstFont.popinsMedium,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(top: deviceHeight * 0.01),
                //   child: const Text("Add Balance",
                //       style: TextStyle(
                //           color: Colors.black,
                //           fontFamily: ConstFont.popinsRegular,
                //           fontSize: 18,
                //           fontWeight: FontWeight.w600,
                //           overflow: TextOverflow.ellipsis)),
                // ),
                // Card(
                //   color: ConstColour.cardBgColor,
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Column(
                //       children: [
                //         TextFormField(
                //           onChanged: (value) {
                //             setState(() {
                //               selectedValueIndex = 0;
                //             });
                //           },
                //           controller: amountController,
                //           keyboardType: TextInputType.number,
                //           decoration: InputDecoration(
                //             hintText: "0.0",
                //             prefixIcon: const Icon(
                //               Icons.currency_rupee_rounded,
                //               color: Colors.black,
                //             ),
                //             prefixStyle: const TextStyle(
                //                 fontSize: 16,
                //                 fontFamily: ConstFont.popinsRegular,
                //                 color: Colors.black),
                //             isDense: true,
                //             enabledBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(6),
                //               borderSide: BorderSide(
                //                   color: ConstColour.primaryColor,
                //                   width: deviceWidth * 0.001),
                //             ),
                //             focusedBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(6),
                //               borderSide: BorderSide(
                //                   color: ConstColour.primaryColor,
                //                   width: deviceWidth * 0.001),
                //             ),
                //           ),
                //         ),
                //         Padding(
                //           padding: EdgeInsets.only(
                //               top: deviceHeight * 0.01,
                //               bottom: deviceHeight * 0.01),
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               ElevatedButton(
                //                 style: ElevatedButton.styleFrom(
                //                     shape: RoundedRectangleBorder(
                //                         side: BorderSide.none,
                //                         borderRadius: BorderRadius.circular(3)),
                //                     backgroundColor: selectedValueIndex == 1
                //                         ? ConstColour.primaryColor
                //                         : Colors.white,
                //                     minimumSize: Size(deviceWidth * 0.16,
                //                         deviceHeight * 0.04),
                //                     maximumSize: Size(deviceWidth * 0.18,
                //                         deviceHeight * 0.06),
                //                     elevation: 0.5),
                //                 onPressed: () {
                //                   setState(() {
                //                     selectedValueIndex = 1;
                //                     debugPrint(selectedValueIndex.toString());
                //                     walletController.walletAmount = 500.0.obs;
                //                     amountController.text = walletController
                //                         .walletAmount
                //                         .toString();
                //                     // amountController.clear();
                //                   });
                //                 },
                //                 child: Text(
                //                   "₹ 500",
                //                   style: TextStyle(
                //                       fontSize: 12,
                //                       color: selectedValueIndex == 1
                //                           ? Colors.white
                //                           : Colors.black,
                //                       fontFamily: ConstFont.popinsMedium),
                //                   textAlign: TextAlign.center,
                //                 ),
                //               ),
                //               // SizedBox(width: deviceWidth * 0.01,),
                //               ElevatedButton(
                //                 style: ElevatedButton.styleFrom(
                //                     shape: RoundedRectangleBorder(
                //                         side: BorderSide.none,
                //                         borderRadius: BorderRadius.circular(3)),
                //                     backgroundColor: selectedValueIndex == 2
                //                         ? ConstColour.primaryColor
                //                         : Colors.white,
                //                     minimumSize: Size(deviceWidth * 0.17,
                //                         deviceHeight * 0.04),
                //                     maximumSize: Size(deviceWidth * 0.19,
                //                         deviceHeight * 0.06),
                //                     elevation: 0.5),
                //                 onPressed: () {
                //                   setState(() {
                //                     selectedValueIndex = 2;
                //                     debugPrint(selectedValueIndex.toString());
                //                     walletController.walletAmount = 1000.0.obs;
                //                     amountController.text = walletController
                //                         .walletAmount
                //                         .toString();
                //                     // amountController.clear();
                //                   });
                //                 },
                //                 child: Text(
                //                   "₹ 1000",
                //                   style: TextStyle(
                //                       fontSize: 12,
                //                       color: selectedValueIndex == 2
                //                           ? Colors.white
                //                           : Colors.black,
                //                       fontFamily: ConstFont.popinsMedium),
                //                   textAlign: TextAlign.center,
                //                 ),
                //               ),
                //               // SizedBox(width: deviceWidth * 0.01,),
                //               ElevatedButton(
                //                 style: ElevatedButton.styleFrom(
                //                     shape: RoundedRectangleBorder(
                //                         side: BorderSide.none,
                //                         borderRadius: BorderRadius.circular(3)),
                //                     backgroundColor: selectedValueIndex == 3
                //                         ? ConstColour.primaryColor
                //                         : Colors.white,
                //                     minimumSize: Size(deviceWidth * 0.16,
                //                         deviceHeight * 0.04),
                //                     maximumSize: Size(deviceWidth * 0.19,
                //                         deviceHeight * 0.06),
                //                     elevation: 0.5),
                //                 onPressed: () {
                //                   setState(() {
                //                     selectedValueIndex = 3;
                //                     debugPrint(selectedValueIndex.toString());
                //                     walletController.walletAmount = 2000.0.obs;
                //                     amountController.text = walletController
                //                         .walletAmount
                //                         .toString();
                //                   });
                //                 },
                //                 child: Text(
                //                   "₹ 2000",
                //                   style: TextStyle(
                //                       fontSize: 12,
                //                       color: selectedValueIndex == 3
                //                           ? Colors.white
                //                           : Colors.black,
                //                       fontFamily: ConstFont.popinsMedium),
                //                   textAlign: TextAlign.center,
                //                 ),
                //               ),
                //               // SizedBox(width: deviceWidth * 0.01,),
                //               ElevatedButton(
                //                 style: ElevatedButton.styleFrom(
                //                     shape: RoundedRectangleBorder(
                //                         side: BorderSide.none,
                //                         borderRadius: BorderRadius.circular(3)),
                //                     backgroundColor: selectedValueIndex == 4
                //                         ? ConstColour.primaryColor
                //                         : Colors.white,
                //                     minimumSize: Size(deviceWidth * 0.18,
                //                         deviceHeight * 0.04),
                //                     maximumSize: Size(
                //                         deviceWidth * 0.2, deviceHeight * 0.06),
                //                     elevation: 0.5),
                //                 onPressed: () {
                //                   setState(() {
                //                     selectedValueIndex = 4;
                //                     debugPrint(selectedValueIndex.toString());
                //                     walletController.walletAmount = 3000.0.obs;
                //                     amountController.text = walletController
                //                         .walletAmount
                //                         .toString();
                //                   });
                //                 },
                //                 child: Text(
                //                   "₹ 3000",
                //                   style: TextStyle(
                //                       fontSize: 12,
                //                       color: selectedValueIndex == 4
                //                           ? Colors.white
                //                           : Colors.black,
                //                       fontFamily: ConstFont.popinsMedium),
                //                   textAlign: TextAlign.center,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //         ElevatedButton(
                //             style: ElevatedButton.styleFrom(
                //                 shape: RoundedRectangleBorder(
                //                     side: BorderSide.none,
                //                     borderRadius: BorderRadius.circular(6)),
                //                 backgroundColor: ConstColour.quantityRemove,
                //                 minimumSize: Size(
                //                     deviceWidth * 1.0, deviceHeight * 0.055),
                //                 maximumSize: Size(
                //                     deviceWidth * 1.5, deviceHeight * 0.07),
                //                 elevation: 0.5),
                //             onPressed: () async {
                //               final receivedResult;
                //               if (amountController.text.isEmpty) {
                //                 Utils().toastMessage(
                //                     "Please add amount.");
                //                 /*receivedResult = await Navigator.push(
                //                   context,
                //                   MaterialPageRoute(
                //                     builder: (context) => WalletPaymentScreen(
                //                         sendTotalPrice: walletController
                //                             .walletAmount!
                //                             .toDouble()),
                //                   ),
                //                 );
                //
                //                 if (receivedResult != null) {
                //                   setState(() async {
                //                     walletController.walletAmount =
                //                         receivedResult;
                //                     walletController.totalWalletAmount.value =
                //                         await ConstPreferences()
                //                                 .getDistributorWalletAmount() ??
                //                             0.0;
                //                   });
                //                 }*/
                //               } else {
                //                 if (double.parse(amountController.text) >
                //                     95000.0) {
                //                   Utils().toastMessage(
                //                       "You can add maximum 95000");
                //                 } else {
                //                   if (amountController.text.isNotEmpty) {
                //                     double walletValue =
                //                         double.parse(amountController.text);
                //                     debugPrint(walletValue.toString());
                //                     walletController.walletAmount =
                //                         walletValue.obs;
                //
                //                     receivedResult = await Navigator.push(
                //                       context,
                //                       MaterialPageRoute(
                //                         builder: (context) =>
                //                             WalletPaymentScreen(
                //                                 sendTotalPrice: walletController
                //                                     .walletAmount!
                //                                     .toDouble()),
                //                       ),
                //                     );
                //
                //                     if (receivedResult != null) {
                //                       setState(() async {
                //                         walletController.walletAmount =
                //                             receivedResult;
                //                         walletController.totalWalletAmount
                //                             .value = await ConstPreferences()
                //                                 .getDistributorWalletAmount() ??
                //                             0.0;
                //                       });
                //                     }
                //                   }
                //                 }
                //               }
                //             },
                //             child: const Text(
                //               "Add Balance",
                //               style: TextStyle(
                //                   fontFamily: ConstFont.popinsMedium,
                //                   fontSize: 18),
                //             ))
                //       ],
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      )),
    );
  }

  void showDialogs() {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    walletController.amountController.clear();
    walletController.remarkController.clear();
    showDialog(
      useSafeArea: true,
      barrierDismissible: true,
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (context, setState) => Dialog(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)
              ),
              backgroundColor: Colors.white,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: deviceHeight * 0.02,
                          horizontal: deviceWidth * 0.05),
                      child: TextFormField(
                        controller: walletController.amountController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          border: InputBorder.none,
                          filled: true,
                          isDense: true,
                          hintText: "Enter Amount",
                          hintStyle: const TextStyle(
                              color: Colors.black,
                              fontFamily: ConstFont.popinsRegular,
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis),
                          // prefixIcon: const Icon( CupertinoIcons.search,size: 24,color: ConstColour.primaryColor,)
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter the amount";
                          } else if (value == '0') {
                            return "Please enter greater amount";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: deviceWidth * 0.05),
                      child: TextFormField(
                        controller: walletController.remarkController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          border: InputBorder.none,
                          filled: true,
                          isDense: true,
                          hintText: "Enter Remark",
                          hintStyle: const TextStyle(
                              color: Colors.black,
                              fontFamily: ConstFont.popinsRegular,
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis),
                          // prefixIcon: const Icon( CupertinoIcons.search,size: 24,color: ConstColour.primaryColor,)
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter the remark";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ConstColour.primaryColor,
                            maximumSize: Size(deviceWidth * 0.4, deviceHeight * 0.055),
                            minimumSize: Size(deviceWidth * 0.3, deviceHeight * 0.05),
                            // backgroundColor: Colors.white
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Get.back();
                              walletController.WithdrawalApi(
                                  walletController.amountController.text.toString(),
                                  walletController.remarkController.text.toString());
                            }
                          },
                          child: const Text(
                            "With drawal",
                            style: TextStyle(
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis,
                                fontFamily: ConstFont.popinsMedium,
                                fontSize: 17),
                          )
                      ),
                    ),
                  ],
                ),
              )
          )
      ),
    ).whenComplete(() {});
  }
}
