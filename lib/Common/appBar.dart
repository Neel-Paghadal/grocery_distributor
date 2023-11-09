
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../ConstFile/constColor.dart';
import '../ConstFile/constFonts.dart';

class DetailsAppbar extends StatelessWidget {
  final String title;

  const DetailsAppbar({
    super.key,
    required this.title,
    this.onPressed,
    this.onTap
  });

  final VoidCallback? onPressed;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              splashColor: ConstColour.btnHowerColor,
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),

            Text(
              title,
              style: const TextStyle(
                  fontFamily: ConstFont.popinsRegular,
                  fontSize: 16,
                  color: Colors.black),
            ),
            // IconButton(
            //   splashColor: ConstColour.btnHowerColor,
            //
            //   onPressed: onTap,
            //   icon: SvgPicture.asset("assets/Icons/bell.svg",)
            // )
          ],
        ));
  }
}
