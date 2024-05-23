import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../api/apihelpers.dart';

class MyQrCode extends StatefulWidget {
  final String value;
  const MyQrCode({Key? key, required this.value}) : super(key: key);



  @override
  _MyQrCodeState createState() => _MyQrCodeState();
}



class _MyQrCodeState extends State<MyQrCode> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var Get = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 250),
                width: Get.width,
                height: Get.height * .7,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromRGBO(223, 228, 250, 1),
                          Color.fromRGBO(241, 243, 255, 1),
                          Color.fromRGBO(241, 243, 255, 1),
                        ]),
                    borderRadius:
                        const BorderRadius.all(Radius.elliptical(30, 25)),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                 
                    const SizedBox(
                      height: 50,
                    ),
                    QrImage(
                      data: widget.value,
                      size: 200,
                      // Widget builTextField(context),
                    ),
                    ],
                ),
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
