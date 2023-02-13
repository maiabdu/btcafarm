import 'package:btcafarm/functions/functions.dart';
import 'package:btcafarm/main.dart';
import 'package:btcafarm/models/miningmode.dart';
import 'package:btcafarm/widgets/bottom_circle.dart';
import 'package:flutter/material.dart';
import '../models/usermodel.dart';
import '../screens/history.dart';
import '../screens/homescreen/homescreen.dart';
import '../screens/qrexample.dart';
import '../screens/qrscan.dart';
import '../screens/settings.dart';

class BottomBar extends StatefulWidget {
  final User user;
  final MininingData minningData;
  const BottomBar({Key? key, required this.user, required this.minningData}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    var Get = MediaQuery.of(context).size;
    return Container(
      height: 80,
      // color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        BottomCircle(icon: Icons.home_outlined, onTap: (){push(context, MyHomePage(user: widget.user, miningData: widget.minningData,));}),
        BottomCircle(icon: Icons.history,
            // onTap: ()=> Get.to(History())
          onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>History(user: widget.user, mininingData: widget.minningData,)))
        //
        ),
        BottomCircle(icon: Icons.qr_code,
        onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>QrScan()))
        ),
        BottomCircle(icon: Icons.settings_outlined, onTap: (){push(context, Settings(user: widget.user,));}),


      ],),
    );
  }
}
