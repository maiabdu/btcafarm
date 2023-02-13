import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'line_chart.dart';
// import 'package:charts_flutter/';
class CardChart extends StatefulWidget {
  const CardChart({Key? key}) : super(key: key);

  @override
  _CardChartState createState() => _CardChartState();
}

class _CardChartState extends State<CardChart> {
  String? value = '1W';
  @override
  Widget build(BuildContext context) {
    var Get = MediaQuery.of(context).size;
   return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      width:Get.width,
      height:250,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(223, 228, 250, 1),
                Color.fromRGBO(241, 243, 255, 1),
                Color.fromRGBO(241, 243, 255, 1),
              ],
          ),
          borderRadius: const BorderRadius.all(Radius.elliptical(30, 25)),
          boxShadow: [
            const BoxShadow(
              color: Color(0xffabb2ea),
              offset: Offset(4,4),
              spreadRadius: 1,
              blurRadius: 15,
            ),
            BoxShadow(
                color: Colors.white.withOpacity(0.9),
                offset:const Offset(-10,-10),
                spreadRadius:1,
                blurRadius:15

            ), // BoxShadow
          ]
      ),
     child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       children: [
         Padding(
           padding: const EdgeInsets.only(top: 8.0),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: mockData.map((e) => Column(
               children: [
               Text(e['title'],style: TextStyle(color: e['color'], fontWeight: FontWeight.w500),
               ),
                 Text(e['subtitle'], style: TextStyle(color: Colors.black54),)
             ],)).toList(),
           ),
         ),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 16.0),
           child: SizedBox(
               height: 120,
               child: LineChart()),
         ),

   Padding(
     padding:const EdgeInsets.symmetric(horizontal:16),
     child:Row(
       mainAxisAlignment:MainAxisAlignment.spaceBetween,

       children: ['10','1W','1M','3M','6M','9M','1Y'].map((e)=>SizedBox(
           height:30,
           width:40,
           child:TextButton(
               onPressed:(){
                 setState(() {
                   value = e;
                 });
               },
               child:Text(e),
               style:TextButton.styleFrom(
                 backgroundColor:
                 value == e ? Theme.of(context).primaryColor : null,
                   primary:
                   value == e ? Colors.white : Colors.grey,
                   shape:RoundedRectangleBorder(
                   borderRadius:BorderRadius.circular(10)
           ),// Rounded Rectangle Border
           textStyle:const TextStyle(fontSize:11)
       ),
     ),// TextButton
   )).toList(),// SizedBox
    ),// Row
    ),// Padding

       ],
     ),

    );
  }
}

final List<Map<String,dynamic >> mockData=[
{
'title':'4,732.97',
'subtitle':'Global Avg.',
'color':Colors.blueAccent,
},

{
'title':'\$80.3M',
'subtitle':'Market Cap.',
'color':Colors.greenAccent.shade700,},
{
'title':'\$1.73M',
'subtitle':'Volume',
'color':Colors.orangeAccent.shade700,}
];
