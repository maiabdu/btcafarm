import 'package:kadpilgrims/models/miningmode.dart';
import 'package:kadpilgrims/screens/homescreen/pilgrimscard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../functions/functions.dart';
import '../../models/usermodel.dart';
import '../../widgets/app_bar_default.dart';
import '../../widgets/bottom_bar.dart';
import '../../widgets/bottom_circle.dart';
import '../../widgets/chart.dart';
import '../../widgets/widgets.dart';
import '../bta/btabysearch.dart';
import '../myQrcode.dart';

class MyHomePage extends StatefulWidget {
  final User user;
  // final MininingData miningData;
  const MyHomePage({
    Key? key, required this.user,
    // required this.user,
  }) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault(context),
      body: ListView(
        children: [
          const SizedBox(
            height: 3,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Gauge(
              User: widget.user,
            
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  <Widget>[
                MenuItem(
                  title: 'Accomodation',
                  val: widget.user.passportNo,
                  passport_no: widget.user.passportNo,
                ),
                const SizedBox(
                  width: 12,
                ),
                HomeQr(val: widget.user.passportNo,),
               
              ],
            ),
          ),
       
        
        ],
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: const BottomBar(
      
      ),
    );
  }
}
