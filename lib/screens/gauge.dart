import 'package:btcafarm/models/miningmode.dart';
import 'package:btcafarm/screens/getprofit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:kdgaugeview/kdgaugeview.dart';

import '../functions/functions.dart';

class Gauge extends StatefulWidget {
  final String package;
  final MininingData data;
  const Gauge({Key? key, required this.package, required this.data}) : super(key: key);

  @override
  State<Gauge> createState() => _GaugeState();
}

class _GaugeState extends State<Gauge> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: MediaQuery.of(context).size.width,
      height: 400,
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
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              padding: const EdgeInsets.all(10),
              child: KdGaugeView(
                minSpeed: 0,
                fractionDigits: 0,
                maxSpeed: 100,
                unitOfMeasurement: '2 BTCA \nMAX LOAD',
                unitOfMeasurementTextStyle: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
                speed: 100,
                animate: true,
                alertSpeedArray: [40, 80, 90],
                alertColorArray: [
                  Colors.orange,
                  Colors.indigo,
                  Theme.of(context).primaryColor
                ],
                duration: Duration(seconds: 6),
              ),
            ),
            Center(child: Text('Package: ' + widget.package),),
            TextButton(
              onPressed: () {
                    push(context,  Profit(data: widget.data,));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Theme.of(context).primaryColor),
                // decoration: BoxDecoratio
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 68.0, vertical: 10),
                  child: Text(
                    'Get Profit',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
