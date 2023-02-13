import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../api/apihelpers.dart';

class ReceiveBTCA extends StatefulWidget {
  const ReceiveBTCA({Key? key}) : super(key: key);

  @override
  _ReceiveBTCAState createState() => _ReceiveBTCAState();
}

class _ReceiveBTCAState extends State<ReceiveBTCA> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var Get = MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, color: Theme.of(context).primaryColor, size: 35,),
            SizedBox(width: 10,),
            Text('Recieve BTCA', style: TextStyle(color: Theme.of(context).primaryColor),),
          ],
        ),

      ),

      body: ListView(

       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),


        children: [
          SizedBox(height: 50,),
       Padding(
         padding: const EdgeInsets.all(15.0),
         child: AnimatedContainer(
      duration: Duration(milliseconds: 250),
      width:Get.width,
      height:Get.height *.55,
      decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(223, 228, 250, 1),
                  Color.fromRGBO(241, 243, 255, 1),
                  Color.fromRGBO(241, 243, 255, 1),
                ]
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Row(
                   children: [
                     IconButton(
                       onPressed:(){},
                       icon:Icon(Icons.account_balance_wallet),
                       color:Theme.of(context).primaryColor,),
                     Text('bc1qxy2kgdygjrsqtzq2n0yrf2493',style:TextStyle(
                         color:Theme.of(context).primaryColor,
                         fontSize:15,
                         fontWeight:FontWeight.w400
                     ),// TextStyle
                     ),
                     IconButton(
                       onPressed:(){
                         share();
                       },
                       icon:Icon(Icons.share_outlined, size: 30,),
                       color:Theme.of(context).primaryColor,),
                   ],
                 ),
                ],
              ),
            ),
           const SizedBox(height: 50,),
            QrImage(
                data: textController.text,
              size: 200,
              // Widget builTextField(context),
            ),
            const SizedBox(height: 20,),
         Padding(
           padding: const EdgeInsets.all(15.0),
           child: TextField(
             onChanged: (textController){setState(() {
             });},
             keyboardType: TextInputType.number,
             controller: textController,
             decoration: InputDecoration(
               focusColor: Theme.of(context).primaryColor,
               fillColor: Theme.of(context).primaryColor,
               border: OutlineInputBorder(),
               labelText: 'Enter the amount',
               hintText: ' 0,00 BTCA',
             ),
           ),
         ),




          // Padding

          ],
      ),


            ),
       ),

          const SizedBox(height: 40,),




          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor, // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () { },
              child: const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text('Done'),
              ),
            ),
          )

        ],
      ),
    );
  }


}

