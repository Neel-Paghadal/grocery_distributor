import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grocery_distributor/Screens/godown_stock.dart';
import 'package:grocery_distributor/Screens/order_details.dart';
import '../ConstFile/constFonts.dart';

class UserPage extends StatefulWidget{
  const UserPage({Key? key,}):super(key: key);


  @override
  _UserPageState createState() => _UserPageState();
}
class _UserPageState extends State<UserPage>{
  List<String> UserName=['Kinjal Ukani','Nikita Sharma','Nikita Sharma','Nikita Sharma','Nikita Sharma','Nikita Sharma'];
  List<String> UserAddress=['Sudama Chowk, Surat-395006','Sudama Chowk, Surat-395006','Sudama Chowk, Surat-395006','Sudama Chowk, Surat-395006','Sudama Chowk, Surat-395006','Sudama Chowk, Surat-395006'];
  List<String> UserImage=['assets/Images/Maskgroup.png','assets/Images/Maskgroup.png','assets/Images/Maskgroup.png','assets/Images/Maskgroup.png','assets/Images/Maskgroup.png','assets/Images/Maskgroup.png'];

  @override
  Widget build(BuildContext context){
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrderdetailsPage()));
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.black,),),
        actions: [
          Image.asset("assets/Icons/notification.png")
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true ,
        title: Text("User List",
          style: TextStyle(color: Colors.black),),
      ),
      body: ListView.builder(
          itemCount: 6,
          itemBuilder: (BuildContext context,int index){
            return Padding(
              padding: EdgeInsets.only(left:deviceWidth*0.016,right:deviceWidth*0.016,),
              child: Card(
                color:Color(0xffF3F4F4),
                child: ListTile(
                  onTap: (){},
                  leading:Image.asset(UserImage[index].toString()),
                  trailing: IconButton(onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => GodownPage()));
                  }, icon: Icon(Icons.arrow_forward_ios,color: Colors.black,),),
                  title: Text(UserName[index].toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: ConstFont.popinsRegular,
                      color: Colors.black,
                      fontSize: 14,),),
                  subtitle: Text(UserAddress[index].toString(),
                    style: TextStyle(
                        fontFamily: ConstFont.popinsRegular,
                        color: Colors.black,
                        fontSize: 12),
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            );
          }),
    );
  }
}
