import 'package:btcafarm/functions/functions.dart';
import 'package:btcafarm/main.dart';
import 'package:btcafarm/widgets/bottom_circle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/history.dart';
import '../screens/qrexample.dart';
import '../screens/qrscan.dart';
import '../screens/settings.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      // color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        BottomCircle(icon: Icons.home_outlined, onTap: (){push(context, MyHomePage());}),
        BottomCircle(icon: Icons.history,
            // onTap: ()=> Get.to(History())
          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>History()))
        //
        ),
        BottomCircle(icon: Icons.qr_code,
        onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>QrScan()))
        ),
        BottomCircle(icon: Icons.settings_outlined, onTap: (){push(context, Settings());}),


      ],),
    );
  }
}
