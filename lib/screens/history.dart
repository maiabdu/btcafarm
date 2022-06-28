import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/bottom_bar.dart';
import '../widgets/bottom_circle.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.history, color: Theme.of(context).primaryColor, size: 35,),
              SizedBox(width: 10,),
              Text('History', style: TextStyle(color: Theme.of(context).primaryColor),),
            ],
          ),

        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 25),
          children: [

            Text('Transaction History', style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20, fontWeight: FontWeight.bold),),
            Column(
              children: mockData.map((e)=>
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: ListTile(
                  leading: BottomCircle(icon: e['icon'], onTap: (){},),
                  title: Text(e['title'], style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 20,
                    fontWeight: FontWeight.w400
                  ),),
                  subtitle: Text(e['subtitle'],
                  style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.5)),
                  ),
                  trailing: Text(e['trailing'],
                    style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(1), fontSize: 20),
                  ),
                ),
              )
              ).toList(),
            )

          ],
        ),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}

const List<Map<String,dynamic >> mockData=[
  {
'title': 'Recieved',
'subtitle':'10 Hours ago',
'trailing':'230k',
'icon':CupertinoIcons.arrow_down_left_circle,
},{
'title':'Send',
'subtitle':'14 Minutes ago',
'trailing':'8.549k',
'icon':CupertinoIcons.arrow_up_right_circle,
},{
'title':'Minting',
'subtitle':'10 Hours ago',
'trailing':'1.423k',
'icon': CupertinoIcons.minus_circled,
},{
'title':'Received',
'subtitle':'2 Hours ago',
'trailing':'\$9745k',
'icon':CupertinoIcons.arrow_down_left_circle,
},
];