import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScan extends StatefulWidget {
  const QrScan({Key? key}) : super(key: key);

  @override
  _QrScanState createState() => _QrScanState();
}



class _QrScanState extends State<QrScan> {
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
    return SafeArea(child: Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // BuildQrView(context),
          BuildQrView(context),
          Positioned(top: 20, child: builResult()),
          Positioned(bottom: 40, child: buildControlsButtom()),

        ],
      ),
    ));
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
        builder: (context, snapshot){
          if(snapshot.data != null){
            return const Icon(Icons.flash_off, color: Colors.white,);
          }else{
            return Container();
          }
        },
        ),
        onPressed: () async {
          await controller?.toggleFlash();
          setState(() {});
        },

        ),
        
        IconButton(onPressed: () async {await controller?.flipCamera();}, icon: Icon(Icons.switch_camera_outlined, color: Colors.white,))


    ],),
  );
 
  Widget builResult() => Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Theme.of(context).primaryColor.withOpacity(.7),
      
    ),
    child: Row(
      children: [
          Image.asset('assets/img/btca1.png', width: 35,),
        Text(
          barcode != null ? 'BTCA ADDRESS: {$barcode!.code}' : 'SCAN BTCA ADDRESS', maxLines: 3 , style: TextStyle(color: Colors.white),),
      ],
    ),
  );

  Widget BuildQrView(BuildContext context) => QRView(
    key: qrKey,
    onQRViewCreated: onQRViewCreated,
    overlay: QrScannerOverlayShape(
      cutOutSize: MediaQuery.of(context).size.width * .8,
      borderWidth: 15,
      borderLength: 15,
      borderColor: Theme.of(context).primaryColor,
      borderRadius: 14
    ),
    );

      void onQRViewCreated(QRViewController controller){
        setState(()=> this.controller = controller);
        controller.scannedDataStream.listen((barcode)=>setState(() => this.barcode = barcode));
      }
}
