import 'dart:ui';

import 'package:kadpilgrims/functions/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kadpilgrims/models/operationsusermodel.dart';

import '../../models/usermodel.dart';

class CodeFlightBoarding extends StatefulWidget {
  final OperationsUser user;
  const CodeFlightBoarding({Key? key, required this.user}) : super(key: key);

  @override
  State<CodeFlightBoarding> createState() => _CodeFlightBoardingState();
}

class _CodeFlightBoardingState extends State<CodeFlightBoarding> {
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  TextEditingController? pilgrim_id = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var Get = MediaQuery.of(context).size;
    return Scaffold(
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
                        child: Form(
                          key: globalFormKey,
                          child: TextField(
                            onChanged: (textController) {
                              setState(() {});
                            },
                            keyboardType: TextInputType.text,
                            controller: pilgrim_id,
                            decoration: InputDecoration(
                              // suffix: Text('BTCA'),
                              focusColor: Theme.of(context).primaryColor,
                              fillColor: Theme.of(context).primaryColor,
                              border: OutlineInputBorder(),
                              labelText: 'Enter Passport NO or Hajj ID',
                              hintText: 'Enter Passport NO or Hajj ID',
                            ),
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
                          onPressed: () async {
                            if (globalFormKey.currentState?.validate() ??
                                false) {
                              globalFormKey.currentState!.save();
                              debugPrint(pilgrim_id.toString());
                              String? pilgrim = pilgrim_id?.text.toString();

                              debugPrint(pilgrim);

                              showProgress(context, 'Loading', true);

                              var pil = await pilgrimminfo(pilgrim, context);

                              // debugPrint(pil.runtimeType);

                              if (pil.runtimeType == String) {
                                hideProgress();
                                andriodAlertDialogue(
                                    context,
                                    'No Record found,',
                                    'Please check and enter Pilgrim Passport NO');
                              } else {}

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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Pilgrim: ' + pilgriminfo.fullName),
                                        Text('CodeNO: KD' + pilgriminfo.code),
                                        Text('HAJJ ID: ' + pilgriminfo.hajjID),
                                        Text('Passport NO: ' +
                                            pilgriminfo.passportNo),
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
                                              bool ispushed = await flightBoarding(
                                                  pilgriminfo.passportNo,
                                                  widget.user.userID,
                                                  context);

                                              if (ispushed == true) {
                                                Navigator.pop(context);

                                                ScaffoldMessenger.of(context)
                                                  ..removeCurrentSnackBar()
                                                  ..showSnackBar(SnackBar(
                                                      content: Container(
                                                          height: 30,
                                                          color: Colors.green,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: const [
                                                              Icon(
                                                                CupertinoIcons
                                                                    .check_mark,
                                                                color: Colors
                                                                    .white,
                                                                size: 25,
                                                              ),
                                                              Text(
                                                                'Success',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                            ],
                                                          ))));
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                  ..removeCurrentSnackBar()
                                                  ..showSnackBar(SnackBar(
                                                      content: Container(
                                                          color: Colors.red,
                                                          child: const Text(
                                                              'Failed'))));
                                              }
                                            },
                                            child: Material(
                                              elevation: 5,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8.0),
                                                child: ListTile(
                                                  leading: Icon(
                                                    CupertinoIcons.check_mark,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    size: 50,
                                                  ),
                                                  title: Text('Continue '),
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
                                            },
                                            child: Material(
                                              elevation: 5,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8.0),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(14.0))),
                                    actions: [],
                                  );
                                },
                              );

                              // isCameraoff = await pushwithcallback(context, ConfirmBTAcode());
                              // this.controller?.dispose();
                            }

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
