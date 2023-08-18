import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ConstFile/constFonts.dart';

class DashbordPage extends StatefulWidget {
  const DashbordPage({Key? key}) : super(key: key);

  @override
  State<DashbordPage> createState() => _DashbordPageState();
}

class _DashbordPageState extends State<DashbordPage> {
 // List<String>productImage=['assets/Images/FrenchBeans.png'];
  List<String> productImage=["assets/Images/beetroot.png","assets/Images/peas.png"];
  List<String> productName=["Beet Root","Peas"];
  List<String> Addresss=["236, Tulsi Arcade, Sudama Chowk, Surat.","236, Tulsi Arcade, Sudama Chowk, Surat."];
  List<String> Price=['₹ 100.00','₹ 59.00'];


  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
   return Scaffold(
     backgroundColor: Colors.white,
     appBar: AppBar(
       backgroundColor: Colors.white,
      title: Text("Dashboard",
      style: TextStyle(color: Colors.black),),
       centerTitle: true,
      elevation: 0,
      leading: IconButton(onPressed: () {}, icon: Image.asset("assets/Icons/drwar.png"),),
       actions: [
         IconButton(onPressed: (){}, icon: Image.asset("assets/Icons/notification.png"))
       ],
     ),
     body: Column(
       children: [
         Expanded(
             child: ListView.builder(
                 itemCount: 2,
                 itemBuilder: (context,index){
                   return Padding(
                     padding: EdgeInsets.only(left: deviceWidth*0.02,right: deviceWidth*0.02),
                     child: Card(
                       color: Color(0xffF3F4F4),
                       child: Padding(
                         padding: EdgeInsets.only(left: deviceWidth*0.01,bottom: deviceHeight*0.01,right: deviceWidth*0.01,top: deviceHeight*0.01),
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 mainAxisSize: MainAxisSize.max,
                                 children: [
                                   Container(
                                     child: Image(image: AssetImage(productImage[index].toString()),
                                       // fit: BoxFit.cover,
                                       // height: 40,
                                       // width: 40,
                                     ),
                                   ),
                                   SizedBox(
                                     width: 10,
                                   ),
                                   Expanded(
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                             Padding(
                                               padding:  EdgeInsets.only(left: deviceHeight*0.01),
                                               child: Text(productName[index].toString(),
                                                 style: TextStyle(
                                                   fontSize: 14,
                                                   fontFamily: ConstFont.popinsRegular,
                                                   color: Colors.black,
                                                   //fontWeight: FontWeight.bold
                                                 ),),
                                             ),
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceAround,
                                               children: [
                                                 Padding(
                                                   padding:  EdgeInsets.only(left: deviceHeight*0.01),
                                                   child: Text("1 Kg"),
                                                 )
                                               ],
                                             ),
                                           ],
                                         ),
                                         SizedBox(
                                           height: 5,
                                         ),
                                         Padding(
                                           padding: EdgeInsets.only(left: deviceHeight*0.01),
                                           child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               Text(Addresss[index].toString(),
                                                 style: TextStyle(
                                                     fontSize: 12,
                                                     fontFamily: ConstFont.popinsRegular,
                                                     color: Colors.black
                                                 ),),
                                             ],
                                           ),
                                         ),
                                         Padding(
                                           padding: EdgeInsets.only(left: deviceHeight*0.01),
                                           child: Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               Padding(
                                                 padding:  EdgeInsets.only(left: deviceHeight*0.01),
                                                 child: Text(Price[index].toString(),
                                                   style: TextStyle(
                                                       fontSize: 12,
                                                       fontFamily: ConstFont.popinsRegular,
                                                       color: Colors.black
                                                   ),),
                                               ),
                                               Padding(
                                                 padding: EdgeInsets.only(left: deviceWidth*0.01,right: deviceWidth*0.01),
                                                 child: Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                   children: [
                                                     Padding(
                                                       padding: EdgeInsets.only(left: deviceWidth*0.01,right: deviceWidth*0.01),
                                                       child: Container(
                                                         height:25,
                                                         width:100,
                                                         decoration: BoxDecoration(
                                                           borderRadius: BorderRadius.circular(2),
                                                         ),
                                                         child: Center(
                                                           child: ElevatedButton(
                                                             style: ElevatedButton.styleFrom(primary: Color(0xff6AB04C)),
                                                             onPressed: () {},
                                                             child: Text("Accept",
                                                               style: TextStyle(
                                                                   fontFamily: ConstFont.popinsRegular,
                                                                   color: Colors.white
                                                               ),),
                                                           ),
                                                         ),
                                                       ),
                                                     ),
                                                     Padding(
                                                       padding: EdgeInsets.only(left: deviceWidth*0.01,right: deviceWidth*0.01),
                                                       child: Container(
                                                         height: 25,
                                                         width: 100,
                                                         decoration: BoxDecoration(
                                                           borderRadius: BorderRadius.circular(2),
                                                         ),
                                                         child: Center(
                                                           child: ElevatedButton(
                                                             style: ElevatedButton.styleFrom(primary: Color(0xffF86C6B)),
                                                             onPressed: (){},
                                                             child: Text("Reject",
                                                               style: TextStyle(
                                                                   fontFamily: ConstFont.popinsRegular,
                                                                   color: Colors.white
                                                               ),),
                                                           ),
                                                         ),
                                                       ),
                                                     )
                                                   ],
                                                 ),
                                               ),
                                             ],
                                           ),
                                         ),
                                       ],
                                     ),
                                   )
                                 ]
                             )
                           ],
                         ),
                       ),
                     ),
                   );
                 })
         )
       ],
     ),
   );
  }
}
