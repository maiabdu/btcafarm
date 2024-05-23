import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kadpilgrims/functions/functions.dart';
import 'package:kadpilgrims/models/operationsusermodel.dart';
import 'package:kadpilgrims/screens/bta/confrimBtacode.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../models/usermodel.dart';

class BtaQrScan extends StatefulWidget {
  final OperationsUser user;
  const BtaQrScan({Key? key, required this.user}) : super(key: key);

  @override
  _BtaQrScanState createState() => _BtaQrScanState();
}

class _BtaQrScanState extends State<BtaQrScan> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;

  @override
  void dispose() {
    // TODO: implement dispose
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    double counter = 0;

    void counted() {
      counter = 1;
    }

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          // BuildQrView(context),
          BuildQrView(context, counter),
          Positioned(top: 60, child: builResult(counter)),
          Positioned(bottom: 40, child: buildControlsButtom()),
        ],
      ),
    );
  }

  Widget buildControlsButtom() => Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).primaryColor.withOpacity(.7),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: FutureBuilder<bool?>(
                future: controller?.getFlashStatus(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return const Icon(
                      Icons.flash_off,
                      color: Colors.white,
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              onPressed: () async {
                await controller?.toggleFlash();
                setState(() {});
              },
            ),
            IconButton(
                onPressed: () async {
                  await controller?.flipCamera();
                },
                icon: Icon(
                  Icons.switch_camera_outlined,
                  color: Colors.white,
                ))
          ],
        ),
      );

  Widget builResult(double counter) => Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).primaryColor.withOpacity(.7),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Row(
            children: [
              const Icon(
                Icons.qr_code_2_outlined,
                color: Colors.white,
              ),
              Text(
                barcode != null
                    ? 'Barcode Type: ${describeEnum(barcode!.format)}   Data: ${barcode!.code}'
                    : 'SCAN PILGRIM QR Code to Issue BTA',
                maxLines: 3,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );

  Widget BuildQrView(BuildContext context, double counter) => QRView(
        key: qrKey,
        // onQRViewCreated: onQRViewCreated,
        onQRViewCreated: counter == 0 ? onQRViewCreated : onQRViewCreated2,
        overlay: QrScannerOverlayShape(
            cutOutSize: MediaQuery.of(context).size.width * .8,
            borderWidth: 15,
            borderLength: 15,
            borderColor: Theme.of(context).primaryColor,
            borderRadius: 14),
      );

  void onQRViewCreated(QRViewController controller) async {
    var isCameraoff = false;

    setState(() {
      // debugPrint(widget.counter.toString());
      this.controller = controller;
      controller.scannedDataStream.listen((barcode) => setState(() async {
            this.barcode = barcode;
            String result = barcode.code.toString();
            await controller.pauseCamera();
            showProgress(context, 'Loading', true);

            var pil = await pilgrimminfoBTA(result, context);

            // debugPrint(pil.runtimeType);

            // if (pil.runtimeType == String) {
            if (pil.runtimeType == String) {
              debugPrint('PIL ' + pil.toString());

              String pilg = pil.toString();

              if (pilg.toString() == 'wrong') {
                debugPrint('wrong qr');
                hideProgress();

                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                      content: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 1,
                          color: Colors.red,
                          child: const Center(
                            child: Text(
                              'Wrong QR Scanned, Please Scan your QR again',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            ),
                          ))));
              } else {
                debugPrint('already issued');

                hideProgress();

                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                      content: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width * 1,
                          color: Colors.red,
                          child: const Center(
                            child: Text(
                              'BTA is Already Issued',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            ),
                          ))));
              }
              // andriodAlertDialogue(
              //     context, 'Wrong QR Scanned', 'Please Scan your QR again.');
              await controller.resumeCamera();
            } else if (pil == 1) {
              hideProgress();

              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(SnackBar(
                    content: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width * 1,
                        color: Colors.red,
                        child: const Center(
                          child: Text(
                            'BTA is Already Issued',
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ))));
            }

            final User pilgriminfo = pil;

            debugPrint(pilgriminfo.fullName);
            hideProgress();
            // String fullName = user.fullName;

            // debugPrint(user.fullName.toString());

            showCupertinoDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pilgrim: ' + pilgriminfo.fullName),
                      Text('CodeNO: KD' + pilgriminfo.code),
                      Text('HAJJ ID: ' + pilgriminfo.hajjID),
                      Text('Passport NO: ' + pilgriminfo.passportNo),
                    ],
                  )),
                  content: Container(
                    height: 260,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            // push(context, BtaQrScan());
                            //sending update to database
                            bool ispushed = await issueBTA(
                                pilgriminfo.passportNo,
                                widget.user.userID,
                                context);

                            if (ispushed == true) {
                              Navigator.pop(context);
                              await controller.resumeCamera();
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(SnackBar(
                                    content: Container(
                                        height: 30,
                                        color: Colors.green,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const [
                                            Icon(
                                              CupertinoIcons.check_mark,
                                              color: Colors.white,
                                              size: 25,
                                            ),
                                            Text(
                                              'Success',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        ))));
                            } else {
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(SnackBar(
                                    content: Container(
                                        color: Colors.red,
                                        child: const Text('Failed'))));
                            }
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
                                title: Text('Issue BTA '),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () async {
                            Navigator.pop(context);
                            await controller.resumeCamera();
                          },
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(15),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                trailing: Icon(
                                  Icons.cancel_outlined,
                                  color: Colors.red.shade800,
                                  size: 50,
                                ),
                                title: Text('Cancel'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  elevation: 34,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(14.0))),
                  actions: [],
                );
              },
            );

            // isCameraoff = await pushwithcallback(context, ConfirmBTAcode());
            // this.controller?.dispose();
          }));
    });
  }

  void onQRViewCreated2(QRViewController controller) {}

  validateandsend(String barcode) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Select an Option')),
          content: Container(
            height: 260,
            child: Column(
              children: [
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
                          CupertinoIcons.check_mark,
                          color: Theme.of(context).primaryColor,
                          size: 50,
                        ),
                        title: Text(barcode),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    // push(context, AccomodationPilgrimCodeSearch());
                  },
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(15),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        trailing: Icon(
                          Icons.person_search_outlined,
                          color: Colors.red.shade800,
                          size: 50,
                        ),
                        title: Text('Allocate by Pilgrim Code'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {},
                  child: Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(15),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        leading: Icon(
                          CupertinoIcons.square_stack_3d_down_dottedline,
                          color: Theme.of(context).primaryColor,
                          size: 50,
                        ),
                        title: Text('View Alloted Rooms'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          elevation: 34,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14.0))),
          actions: [],
        );
      },
    );
  }
}
