import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kadpilgrims/screens/myQrcode.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../functions/functions.dart';
import '../../models/usermodel.dart';

class Gauge extends StatefulWidget {
  final User;
  const Gauge({
    Key? key, required this.User,
  }) : super(key: key);

  @override
  State<Gauge> createState() => _GaugeState();
}

class _GaugeState extends State<Gauge> {
  late YoutubePlayerController _controller;



  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: MediaQuery.of(context).size.width,
      height: 250,
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
              offset: Offset(4, 4),
              spreadRadius: 1,
              blurRadius: 15,
            ),
            BoxShadow(
                color: Colors.white.withOpacity(0.9),
                offset: const Offset(-10, -10),
                spreadRadius: 1,
                blurRadius: 15), // BoxShadow
          ]),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .4,
                height: 200,
                padding: const EdgeInsets.all(10),
                child: Image.network(widget.User.image),
              ),

              // roundedCustomButton(context),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PILGRIM INFORMATION',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 16, fontWeight: FontWeight.bold),
                ),
               const SizedBox(
                  height: 10,
                ),
                Text(
                  widget.User.fullName,
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
               const SizedBox(
                  height: 5,
                ),
                Text('Gender: ' + widget.User.sex,
                  style: TextStyle(fontSize: 15),),
               const SizedBox(
                  height: 5,
                ),
                Text('LGA: ' + widget.User.lga,
                  style: TextStyle(fontSize: 15),),
                const SizedBox(
                  height: 5,
                ),
                Text('Hajj ID: ' + widget.User.hajjID,
                  style: TextStyle(fontSize: 15),),
               const SizedBox(
                  height: 5,
                ),
                Text('Code No:' + widget.User.code,
                  style: TextStyle(fontSize: 19),),

                roundedCustomButton(context, widget.User)
              ],
            ),
          )
          
        ],
      ),
    );
  }

  TextButton roundedCustomButton(BuildContext context, User user) {
    return TextButton(
      onPressed: () {
        push(context,  MyQrCode(value: user.barcode,));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Theme.of(context).primaryColor),
        // decoration: BoxDecoratio
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Text(
            'View QR Code',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }



  // blogView(context, 'https://example.com/sample.jpg');

  



}
