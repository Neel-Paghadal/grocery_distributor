import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:grocery_distributor/ConstFile/constColor.dart';
import 'package:grocery_distributor/ConstFile/constFonts.dart';

import '../Controllers/searchScreen_controllers.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  SearchScreenController searchController = Get.put(SearchScreenController());


  @override
  Widget build(BuildContext context) {

    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        // elevation: 0.0,
        title: Text("Aayu plus",style: TextStyle(color: ConstColour.primaryColor,fontFamily: ConstFont.popinsMedium,fontSize: 20),),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            size: 25,
            color: Colors.black,
          ),
        ),

      ),
      body: Padding(
          padding: EdgeInsets.only(
              left: deviceWidth * 0.025,
              right: deviceWidth * 0.025,
              top: deviceHeight * 0.01),
          child: SafeArea(
            child: SingleChildScrollView(
              controller: ScrollController(),
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  TextFormField(
                    autofocus: true,
                    controller: searchController.allSearchController,

                    onChanged: (value) {
                      searchController.SearchProduct(searchController.allSearchController.text);
                    },
                    decoration: InputDecoration(
                      labelStyle:  const TextStyle(color: Colors.black),
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
                      hintText: "Search For Products...",
                      hintStyle: const TextStyle(
                          color: Colors.black,
                          fontFamily: ConstFont.popinsRegular,
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis),
                      prefixIcon: Icon( CupertinoIcons.search,size: 24,color: ConstColour.primaryColor,)
                    ),

                  ),
                Obx(
                  () => ListView.builder(
                    controller: ScrollController(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: searchController.searchList.length,
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
                              searchController.searchList[index].productImage
                                  .toString(),
                            ),
                          ),
                          title: Text(
                              searchController.searchList[index].productName,
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
                )
                ],
              ),
            ),
          ),
        ),
    );
  }
}
