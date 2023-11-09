import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/ConstFile/constColor.dart';
import 'package:grocery_distributor/ConstFile/constPreferences.dart';
import 'package:grocery_distributor/Controllers/home_controller.dart';
import 'package:grocery_distributor/Controllers/my_profile_controller.dart';
import 'package:image_picker/image_picker.dart';
import '../ConstFile/constFonts.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  MyProfileController myProfileController = Get.put(MyProfileController());
  HomeController homeController = Get.put(HomeController());



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myProfileController.getPrefData();

  }

  File? imageNotes;
  String selectedItemNotes = "Camera";

  Future getImageCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() {
      imageNotes = imageTemporary;
      debugPrint(imageNotes.toString());
    });
  }

  Future getImageGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() {
      imageNotes = imageTemporary;
      debugPrint(imageNotes.toString());
    });
  }

  // Upload(File imageFile) async {
  //   var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  //   var length = await imageFile.length();
  //
  //   var uri = Uri.parse(uploadURL);
  //
  //   var request = new http.MultipartRequest("POST", uri);
  //   var multipartFile = new http.MultipartFile('file', stream, length,
  //       filename: basename(imageFile.path));
  //   //contentType: new MediaType('image', 'png'));
  //
  //   request.files.add(multipartFile);
  //   var response = await request.send();
  //   debugPrint(response.statusCode);
  //   response.stream.transform(utf8.decoder).listen((value) {
  //     debugPrint(value);
  //   });
  // }



  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        // elevation: 0.0,
        title: const Text(
          'My Profile',
          style: TextStyle(
              fontFamily: ConstFont.popinsRegular,
              fontSize: 16,
              color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 25,
            color: Colors.black,
          ),
        ),

        // actions: [
        //   myProfileController.isVisible.value == true
        //       ?  const SizedBox() : IconButton(
        //           onPressed: () {
        //             // ConstPreferences().saveDistributorName(myProfileController.nameController.text,);
        //             // ConstPreferences().saveDistributorEmail(myProfileController.emailController.text);
        //             // myProfileController.UpdateUserDetailAPI(myProfileController.nameController.text ,myProfileController.emailController.text, imageNotes.toString(), "",context);
        //           },
        //           icon: const Icon(
        //             Icons.check_circle_outlined,
        //             color: Colors.black,
        //           ),
        //         ),
        // ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: deviceWidth * 0.03, right: deviceWidth * 0.03),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Obx(
            () => Column(
              children: [
                Card(
                  elevation: 0.0,
                  color: ConstColour.cardBgColor,
                  child: SizedBox(
                    width: deviceWidth * 1.0,
                    height: deviceHeight * 0.15,
                    child: Center(
                      child: Stack(
                        children: [

                          Container(
                            decoration: const BoxDecoration(
                              // border: Border.all(),
                              // borderRadius: BorderRadius.all(
                              //   Radius.circular(10),
                              // ),
                            ),
                            child: ClipOval(
                              child: imageNotes != null
                                  ? Image.file(
                                imageNotes!,
                                width: deviceWidth * 0.23,
                                height: deviceHeight * 0.12,
                                fit: BoxFit.cover,
                              )
                                  : Image.asset('assets/Images/man.png',
                                width: deviceWidth * 0.23,
                                height: deviceHeight * 0.12,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Container(
                          //   decoration: BoxDecoration(
                          //     border: Border.all(color: Colors.transparent),
                          //     borderRadius: const BorderRadius.all(
                          //       Radius.circular(100),
                          //     ),
                          //   ),
                          //   child: ClipOval(
                          //     child: CircleAvatar(
                          //       maxRadius: 45,
                          //       backgroundColor: imageNotes == null
                          //           ? const Color(0xff99CE02).withOpacity(0.2)
                          //           : Colors.transparent,
                          //       child: imageNotes == null ? null : ClipOval(
                          //               child: Image.file(
                          //               imageNotes!,
                          //             )),
                          //       // backgroundColor: Colors.transparent,
                          //     ),
                          //   ),
                          // ),
                          Positioned(
                            bottom: 4,
                            right: 6,
                            child: InkWell(
                                onTap: () {
                                  showDialog<void>(
                                    context: context,
                                    builder: (BuildContext dialogContext) {
                                      return AlertDialog(
                                        content: SizedBox(
                                          height: deviceHeight * 0.15,
                                          child: Column(
                                            children: [
                                              Card(
                                                child: ListTile(
                                                  title: const Text("Camera"),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    getImageCamera();
                                                  },
                                                  leading: const Icon(
                                                    Icons.camera_alt,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              Card(
                                                child: ListTile(
                                                  title: const Text("Gallery"),
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                    getImageGallery();
                                                  },
                                                  leading: const Icon(
                                                    Icons.photo_library_rounded,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                splashColor: ConstColour.btnHowerColor,
                                child: SvgPicture.asset(
                                    "assets/Icons/userEdit.svg")),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // Card(
                //   elevation: 0.0,
                //   color: ConstColour.cardBgColor,
                //   child: SizedBox(
                //     width: deviceWidth * 1.0,
                //     height: deviceHeight * 0.15,
                //     child: Center(
                //       child: Stack(
                //         children: [
                //
                //           Container(
                //             decoration: const BoxDecoration(
                //               // border: Border.all(),
                //               borderRadius: BorderRadius.all(
                //                 Radius.circular(10),
                //               ),
                //             ),
                //             child: ClipOval(
                //               child: imageNotes != null
                //                   ? Image.file(
                //                 imageNotes!,
                //                 width: deviceWidth * 0.23,
                //                 height: deviceHeight * 0.1,
                //                 fit: BoxFit.cover,
                //               )
                //                   : Image.asset('assets/Images/man.png',
                //                 width: deviceWidth * 0.23,
                //                 height: deviceHeight * 0.1,
                //                 fit: BoxFit.cover,
                //               ),
                //             ),
                //           ),
                //           Container(
                //             decoration: BoxDecoration(
                //               border: Border.all(color: Colors.transparent),
                //               borderRadius: const BorderRadius.all(
                //                 Radius.circular(100),
                //               ),
                //             ),
                //             child: ClipOval(
                //               child: CircleAvatar(
                //                 // maxRadius: 45,
                //                 backgroundColor: imageNotes == null
                //                     ? const Color(0xff99CE02).withOpacity(0.2)
                //                     : Colors.transparent,
                //                 child: imageNotes == null ? null : ClipOval(
                //                         child: Image.file(
                //                         imageNotes!,
                //                       )),
                //                 // backgroundColor: Colors.transparent,
                //               ),
                //             ),
                //           ),
                //           Positioned(
                //             bottom: 4,
                //             right: 5,
                //             child: InkWell(
                //                 onTap: () {
                //                   showDialog<void>(
                //                     context: context,
                //                     builder: (BuildContext dialogContext) {
                //                       return AlertDialog(
                //                         content: SizedBox(
                //                           height: deviceHeight * 0.15,
                //                           child: Column(
                //                             children: [
                //                               Card(
                //                                 child: ListTile(
                //                                   title: const Text("Camera"),
                //                                   onTap: () {
                //                                     Navigator.pop(context);
                //                                     getImageCamera();
                //                                   },
                //                                   leading: const Icon(
                //                                     Icons.camera_alt,
                //                                     color: Colors.black,
                //                                   ),
                //                                 ),
                //                               ),
                //                               Card(
                //                                 child: ListTile(
                //                                   title: const Text("Gallery"),
                //                                   onTap: () {
                //                                     Navigator.pop(context);
                //                                     getImageGallery();
                //                                   },
                //                                   leading: const Icon(
                //                                     Icons.photo_library_rounded,
                //                                     color: Colors.black,
                //                                   ),
                //                                 ),
                //                               ),
                //                             ],
                //                           ),
                //                         ),
                //                       );
                //                     },
                //                   );
                //                 },
                //                 splashColor: ConstColour.btnHowerColor,
                //                 child: SvgPicture.asset(
                //                     "assets/Icons/userEdit.svg")),
                //           )
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                Divider(height: deviceHeight * 0.01, color: Colors.transparent),
                Column(
                  children: [
                    TextFormField(
                      readOnly: myProfileController.isVisible.value,
                      controller: myProfileController.nameController,
                      // autofocus: true,
                      // enabled: false,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        border: InputBorder.none,
                        filled: true,
                        isDense: true,
                        // suffixIcon: TextButton(
                        //     onPressed: () {
                        //       myProfileController.isVisible.value = false;
                        //       setState(() {});
                        //       debugPrint("${myProfileController.isVisible.value}myProfileController.isVisible.value");
                        //     },
                        //     child: const Text("Edit",
                        //         style: TextStyle(
                        //             color: ConstColour.primaryColor,
                        //             fontFamily: ConstFont.popinsRegular,
                        //             fontSize: 15,
                        //             fontWeight: FontWeight.w400,
                        //             overflow: TextOverflow.ellipsis))),
                        hintText: "Enter Name",
                        // prefixText: "Name :  ",
                        hintStyle: const TextStyle(
                            color: Colors.black,
                            fontFamily: ConstFont.popinsRegular,
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),

                    Divider(
                        height: deviceHeight * 0.01, color: Colors.transparent),
                    TextFormField(
                      readOnly : myProfileController.isVisible.value,
                      controller: myProfileController.emailController,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        border: InputBorder.none,
                        filled: true,
                        isDense: true,
                        // prefixText: "Email :  ",

                        // suffixIcon: TextButton(
                        //     onPressed: () {
                        //       myProfileController.isVisible.value = true;
                        //       setState(() {});
                        //     },
                        //     child: const Text("Edit",
                        //         style: TextStyle(
                        //             color: ConstColour.primaryColor,
                        //             fontFamily: ConstFont.popinsRegular,
                        //             fontSize: 15,
                        //             fontWeight: FontWeight.w400,
                        //             overflow: TextOverflow.ellipsis))),
                        hintText: "Enter Email",
                        hintStyle: const TextStyle(
                            color: Colors.black,
                            fontFamily: ConstFont.popinsRegular,
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    Divider(
                        height: deviceHeight * 0.01, color: Colors.transparent),
                    Divider(
                        height: deviceHeight * 0.01, color: Colors.transparent),
                    TextFormField(
                      readOnly: true,
                      // autofocus: true,
                      decoration: InputDecoration(
                        labelStyle: const TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        border: InputBorder.none,
                        filled: true,
                        isDense: true,
                        // suffixIcon: const Icon(
                        //   Icons.verified,
                        //   color: ConstColour.primaryColor,
                        // ),
                        hintText: homeController.distributorAddress == null
                            ? "fetching data"
                            : homeController.distributorAddress.toString(),
                        hintStyle: const TextStyle(
                            color: Colors.black,
                            fontFamily: ConstFont.popinsRegular,
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
