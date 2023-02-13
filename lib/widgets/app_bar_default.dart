import 'package:btcafarm/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'get'

PreferredSizeWidget appBarDefault(context) => AppBar(
      // ignore: prefer_const_constructors
      systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: Colors.black,

        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      shadowColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      leading: const Text(''), // Rotated Box
      actions: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/img/btca1.png',
                ),
                const Text(
                  'BTCA FARM',
                  style: TextStyle(
                    color: Color.fromRGBO(94, 80, 201, 1),
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 80,
            ),
            Container(
              height: 50,
              width: 50,
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
                // border:Border.all(color:Get.theme.primaryColorLight,width:1.5)
              ), // BoxDecoration
              //  child: Image.asset('assets/img/qrcode.png', color: Color.fromRGBO(94, 80, 201, 1),),
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