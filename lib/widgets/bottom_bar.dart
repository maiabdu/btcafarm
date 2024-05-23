import 'package:flutter/cupertino.dart';
import 'package:kadpilgrims/functions/functions.dart';
import 'package:kadpilgrims/main.dart';
import 'package:kadpilgrims/models/miningmode.dart';
import 'package:kadpilgrims/widgets/bottom_circle.dart';
import 'package:flutter/material.dart';
import '../models/usermodel.dart';
import '../screens/accomodation/viewallotedroom.dart';
import '../screens/auth/authscree.dart';
import '../screens/history.dart';
import '../screens/homescreen/homescreen.dart';
import '../screens/qrexample.dart';
import '../screens/qrscan.dart';
import '../screens/settings.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    var Get = MediaQuery.of(context).size;
    return Container(
      height: 80,
      // color: Colors.grey,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BottomCircle(
              icon: Icons.home_outlined,
              onTap: () {
                // push(context, MyHomePage());
              }),
          BottomCircle(
              icon: Icons.qr_code,
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => QrScan()))),
          BottomCircle(
              icon: Icons.logout,
              onTap: () {
                //logout

                showCupertinoDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Center(child: Text('Log Out')),
                      content: Container(
                        height: 200,
                        child: Column(
                          children: [
                            Text(
                              'Click to Proceed to Logout',
                              style: TextStyle(fontSize: 20, color: Colors.red),
                            ),
                            InkWell(
                              onTap: () {
                                pushAndRemoveUntil(context, MyLogin(), false);
                              },
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(15),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: ListTile(
                                    leading: Icon(
                                      Icons.logout_outlined,
                                      color: Theme.of(context).primaryColor,
                                      size: 50,
                                    ),
                                    title: Text('Logout'),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                               Navigator.pop(context);
                              },
                              child: Material(
                                elevation: 5,
                                borderRadius: BorderRadius.circular(15),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: ListTile(
                                    trailing: Icon(
                                      Icons.cancel,
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
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(14.0))),
                      actions: [],
                    );
                  },
                );

                // pushAndRemoveUntil(context, MyLogin(), false);
              }),
        ],
      ),
    );
  }
}
