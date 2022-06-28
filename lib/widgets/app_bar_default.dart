import 'package:btcafarm/constants.dart';
import'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'get'


PreferredSizeWidget appBarDefault(context)=>AppBar(
  shadowColor: Colors.transparent,
  backgroundColor: Colors.transparent,
  leading: RotatedBox(
    quarterTurns:3,
    child:IconButton(
      onPressed:(){},
      icon:const Icon(Icons.filter_list_outlined, color: Color.fromRGBO(94, 80, 201, 1),),
    ),// IconButton
  ),// Rotated Box
  actions:[
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Image.asset('assets/img/btca1.png',),
            const Text('BTCA WALLET', style: TextStyle(
              color: Color.fromRGBO(94, 80, 201, 1),
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            ),
          ],
        ),
        SizedBox(width: 80,),
        Container(
          height:50,
          width:50,
          padding:const EdgeInsets.all(5),
          decoration:const  BoxDecoration(
              borderRadius: BorderRadius.all(Radius.elliptical(20,20)),
              // border:Border.all(color:Get.theme.primaryColorLight,width:1.5)
          ),// BoxDecoration
         child: Image.asset('assets/img/qrcode.png', color: Color.fromRGBO(94, 80, 201, 1),),


        ),
      ],
    ),
    // TODO: implement changing of themedata from this
    // IconButton(
    //     icon: const Icon(Icons.lightbulb),
    //     onPressed: () {
    //       Get.isDarkMode
    //           ? Get.changeTheme(ThemeData.light())
    //           : Get.changeTheme(ThemeData.dark());
    //     })// Container
       // Padding
  ],
);// AppBar