import 'dart:ui';

import 'package:kadpilgrims/functions/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmBTAcode extends StatefulWidget {
  const ConfirmBTAcode({Key? key}) : super(key: key);

  @override
  State<ConfirmBTAcode> createState() => _ConfirmBTAcodeState();
}

class _ConfirmBTAcodeState extends State<ConfirmBTAcode> {
  TextEditingController? walletAddress;
  TextEditingController? amount;
  @override
  Widget build(BuildContext context) {
    var Get = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context, true);
              },
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(15),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: Icon(
                      CupertinoIcons.check_mark,
                      color: Theme.of(context).primaryColor,
                      size: 50,
                    ),
                    title: Text('barcode'),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                // push(context, BtaQrScan());
              },
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(15),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.cancel_outlined,
                      color: Theme.of(context).primaryColor,
                      size: 50,
                    ),
                    title: Text('barcode'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
