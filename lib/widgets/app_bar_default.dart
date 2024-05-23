import 'package:kadpilgrims/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'get'

PreferredSizeWidget appBarDefault(context) => AppBar(
      bottomOpacity: 0.0,
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leading: Builder(
        builder: (BuildContext context) {
          return Row(
            // textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Image.asset('assets/img/kadpil.png'),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                // tooltip: MaterialLocalizations.of(context)
                //     .openAppDrawerTooltip,
              ),
            ],
          );
        },
      ),
      actions: <Widget>[
        Center(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              margin:
                  EdgeInsets.only(right: MediaQuery.of(context).size.width / 7),
              padding: EdgeInsets.all(5),
              decoration: const BoxDecoration(
                // color: Colors.teal,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),

              // height: 20,
              child: Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Theme.of(context).primaryColor,
                    size: 25.0,
                  ),
                  const Text(
                    'Kaduna, NGA',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Fredoka',
                        fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Center(
        //   child: Padding(
        //     padding: EdgeInsets.all(5),
        //     child: Container(
        //       margin:
        //           EdgeInsets.only(right: MediaQuery.of(context).size.width / 7),
        //       padding: EdgeInsets.all(5),
        //       decoration: const BoxDecoration(
        //         color: Colors.teal,
        //         borderRadius: BorderRadius.all(
        //           Radius.circular(10),
        //         ),
        //       ),

        //       // height: 20,
        //       child: Row(
        //         children: const [
        //           Icon(
        //             Icons.location_pin,
        //             color: Colors.white,
        //             size: 25.0,
        //           ),
        //           Text(
        //             'Lagos, Nigeria',
        //             style: TextStyle(
        //                 color: Colors.white, fontFamily: 'Fredoka', fontSize: 15),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        const CircleAvatar(
          radius: 35,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage('assets/img/kadpil.png'),
        ),
      ],
  
      centerTitle: true,
      // backgroundColor: Theme.of(context).accentColor,
    );
