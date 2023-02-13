import 'dart:ui';

import 'package:btcafarm/functions/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SendBTCA extends StatefulWidget {
  const SendBTCA({Key? key}) : super(key: key);

  @override
  State<SendBTCA> createState() => _SendBTCAState();
}

class _SendBTCAState extends State<SendBTCA> {
  TextEditingController? walletAddress;
  TextEditingController? amount;
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
            Icon(
              CupertinoIcons.arrow_up_right_circle,
              color: Theme.of(context).primaryColor,
              size: 35,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Send BTCA',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  width: Get.width,
                  height: Get.height * .45,
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
                    
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 15),
                        child: TextField(
                          onChanged: (textController) {
                            setState(() {});
                          },
                          keyboardType: TextInputType.number,
                          controller: walletAddress,
                          decoration: InputDecoration(
                            suffix: Text('BTCA'),
                            focusColor: Theme.of(context).primaryColor,
                            fillColor: Theme.of(context).primaryColor,
                            border: OutlineInputBorder(),
                            labelText: 'Wallet Address',
                            hintText: ' BTCA Address',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 15),
                        child: TextField(
                          onChanged: (textController) {
                            setState(() {});
                          },
                          keyboardType: TextInputType.number,
                          controller: amount,
                          decoration: InputDecoration(
                            suffix: const Text('BTCA'),
                            focusColor: Theme.of(context).primaryColor,
                            fillColor: Theme.of(context).primaryColor,
                            border: OutlineInputBorder(),
                            labelText: 'Enter the amount',
                            hintText: ' 0,00 BTCA',
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary:
                                Theme.of(context).primaryColor, // background
                            onPrimary: Colors.white, // foreground
                          ),
                          onPressed: () {
                            // push(context, PaymentDetail())
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(18.0),
                            child: Text('Proceed'),
                          ),
                        ),
                      )

                      // Padding
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
