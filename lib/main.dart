import 'package:btcafarm/functions/functions.dart';
import 'package:btcafarm/screens/btca_send.dart';
import 'package:btcafarm/screens/receive_btca_screen.dart';
import 'package:btcafarm/widgets/app_bar_default.dart';
import 'package:btcafarm/widgets/bottom_bar.dart';
import 'package:btcafarm/widgets/bottom_circle.dart';
import 'package:btcafarm/widgets/chart.dart';
import 'package:btcafarm/widgets/menu_bar.dart';
import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'api/apihelpers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor:  Color.fromRGBO(221, 225, 249, 1),
        primaryColor: const Color.fromRGBO(94, 80, 201, 1),
        // primarySwatch: const Color.fromRGBO(94, 80, 201, 1),
        // primarySwatch:   Color.fromRGBO(94, 80, 201, 1),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.

      ),
      // darkTheme: ThemeData.dark(),
      // themeMode: ThemeMode.system,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {




  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return SafeArea(
      child: Scaffold(
        appBar: appBarDefault(context),

        body: ListView(
          children:  [
        ListTile(
          leading: IconButton(
        onPressed:(){},
        icon:Icon(Icons.account_balance_wallet),
        color:Theme.of(context).primaryColor,),// Icon

        title: Text('bc1qxy2kgdygjrsqtzq2n0yrf2493',style:TextStyle(
            color:Theme.of(context).primaryColor,
            fontSize:15,
            fontWeight:FontWeight.w400
        ),// TextStyle
        ),// Text
        subtitle:Padding(
          padding:const EdgeInsets.only(top:1.0),
          child:Text('BTCA Wallet Address',style:TextStyle(
              color:Theme.of(context).primaryColor,
              fontSize:10
          ),
          ),// TextStyle,Text
        ),// Padding
        trailing:IconButton(
          onPressed:(){
            share();
          },
          icon:Icon(Icons.share_outlined),
            color:Theme.of(context).primaryColor,),// Icon
        ),// IconButton

            const SizedBox(height: 10,),
            Padding(
            padding:const EdgeInsets.symmetric(horizontal:20),

               child: Row(
    mainAxisAlignment:MainAxisAlignment.spaceBetween,
    crossAxisAlignment:CrossAxisAlignment.start,
              children: <Widget>[
                MenuBar(title: 'Balance',),
                SizedBox(width: 12,),
                MenuBar(title: 'Frozen',),
              ],
            ),
            ),

            const Padding(
               padding:  EdgeInsets.symmetric(vertical: 32.0, horizontal: 20),
               child: CardChart(),
             ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BottomCircle(icon: CupertinoIcons.arrow_up_right_circle, onTap: (){
                   push(context, SendBTCA());
                },),
                BottomCircle(icon: CupertinoIcons.arrow_down_left_circle, onTap: (){
                  push(context, ReceiveBTCA());
                },)
              ],
            )


          ],
        ),

        // This trailing comma makes auto-formatting nicer for build methods.
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
