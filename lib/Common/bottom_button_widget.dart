

import 'package:flutter/material.dart';

import '../ConstFile/constColor.dart';
import '../ConstFile/constFonts.dart';

class BottomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final btnName;
  const BottomButton({Key? key, this.onPressed,this.btnName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return   Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11)
            ),
            splashColor: ConstColour.btnHowerColor,
            onTap: onPressed,
            tileColor: ConstColour.primaryColor,
            title:Center(child: Text(btnName,style: TextStyle(fontSize: 16,fontFamily: ConstFont.popinsMedium,color: Colors.black))),
            trailing: Icon(Icons.arrow_forward,color: Colors.black,size: 24,),
          ),
        ],
      ),
    );
  }
}
