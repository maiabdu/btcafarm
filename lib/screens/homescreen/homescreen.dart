import 'package:btcafarm/models/miningmode.dart';
import 'package:btcafarm/screens/gauge.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../functions/functions.dart';
import '../../models/usermodel.dart';
import '../../widgets/app_bar_default.dart';
import '../../widgets/bottom_bar.dart';
import '../../widgets/bottom_circle.dart';
import '../../widgets/chart.dart';
import '../../widgets/menu_bar.dart';
import '../btca_send.dart';
import '../receive_btca_screen.dart';

class MyHomePage extends StatefulWidget {
  final User user;
  final MininingData miningData;
  const MyHomePage({
    Key? key,
    required this.user,
    required this.miningData,
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
              package: widget.miningData.packageName,
              data: widget.miningData,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  <Widget>[
                MenuItem(
                  title: 'Frozen',
                  val: widget.miningData.minnedThisMonth,
                ),
                const SizedBox(
                  width: 12,
                ),
                MenuItem(
                  title: 'Mined',
                  val: widget.miningData.minnedToday,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 20),
            child: CardChart(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BottomCircle(
                icon: CupertinoIcons.arrow_up_right_circle,
                onTap: () {
                  push(context, const SendBTCA());
                },
              ),
              BottomCircle(
                icon: CupertinoIcons.arrow_down_left_circle,
                onTap: () {
                  push(context, const ReceiveBTCA());
                },
              )
            ],
          ),
         const SizedBox(height: 30,),
        ],
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomBar(
        user: widget.user,
        minningData: widget.miningData,
      ),
    );
  }
}
