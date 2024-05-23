import 'package:kadpilgrims/models/miningmode.dart';
import 'package:kadpilgrims/screens/flight/qrmanifest.dart';
import 'package:kadpilgrims/screens/homescreen/pilgrimscard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kadpilgrims/screens/homescreen/test.dart';
import '../../functions/functions.dart';
import '../../models/operationsusermodel.dart';
import '../../models/usermodel.dart';
import '../../widgets/app_bar_default.dart';
import '../../widgets/bottom_bar.dart';
import '../../widgets/bottom_circle.dart';
import '../../widgets/chart.dart';
import '../../widgets/widgets.dart';
import '../accomodation/Accomodationpilgrimcodesearch.dart';
import '../accomodation/viewallotedroom.dart';
import '../bta/btadashboard.dart';
import '../bta/qrbta.dart';
import '../bta/btabysearch.dart';
import '../flight/codeFlightBoarding.dart';
import '../flight/manifestbycode.dart';
import '../flight/qrFlightboarding.dart';
import '../myQrcode.dart';
import '../transportation/despatch.dart';
import '../transportation/selectbus.dart';

class OperationsScreen extends StatefulWidget {
  final OperationsUser user;
  // final MininingData miningData;
  const OperationsScreen({
    Key? key,
    required this.user,
    // required this.user,
  }) : super(key: key);
  @override
  State<OperationsScreen> createState() => _OperationsScreenState();
}

class _OperationsScreenState extends State<OperationsScreen> {
  bool isaccounts = false,
      isaccomodation = false,
      isflight = false,
      istransportation = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    switch (widget.user.role) {
      case 'transportation':
        setState(() {
          istransportation = true;
        });
        break;
      case 'accomodation':
        setState(() {
          isaccomodation = true;
        });
        break;
      case 'flight':
        setState(() {
          isflight = true;
        });
        break;
      case 'accounts':
        setState(() {
          isaccounts = true;
        });
        break;
      case 'operations':
        setState(() {
          isaccomodation = true;
          isflight = true;
          isaccounts = true;
          istransportation = true;
        });
        break;
      // Add more cases as needed
      default:
      // Code to be executed if expression doesn't match any case
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault(context),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(28.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'User: ' + widget.user.name,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 17),
                ),
                Text(
                  'Role: ' + widget.user.role,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 17),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //bta
                Visibility(
                  visible: isaccounts,
                  child: InkWell(
                    onTap: () {
                      showCupertinoDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title:
                                const Center(child: Text('Select an Option')),
                            content: Container(
                              height: 260,
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      push(
                                          context,
                                          BtaQrScan(
                                            user: widget.user,
                                          ));
                                    },
                                    child: Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(15),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        child: ListTile(
                                          leading: Icon(
                                            CupertinoIcons.qrcode,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 50,
                                          ),
                                          title: Text('Issue BTA with QR'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      push(
                                          context,
                                          IssueBTAbyCode(
                                            user: widget.user,
                                          ));
                                    },
                                    child: Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(15),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        child: ListTile(
                                          trailing: Icon(
                                            Icons.person_search_outlined,
                                            color: Colors.red.shade800,
                                            size: 50,
                                          ),
                                          title: Text(
                                              'Issue BTA by Searching Pilgrim Code'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      push(
                                          context,
                                          BtaDashboard(
                                            user: widget.user,
                                          ));
                                    },
                                    child: Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(15),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        child: ListTile(
                                          leading: Icon(
                                            CupertinoIcons
                                                .square_stack_3d_down_dottedline,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 50,
                                          ),
                                          title: Text(
                                              'View BTA History/Dashboard'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            elevation: 34,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0))),
                            actions: [],
                          );
                        },
                      );
                    },
                    child: MenuItem1(
                      val: 'BTA',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                //accomodation
                Visibility(
                  visible: isaccomodation,
                  child: InkWell(
                    onTap: () {
                      showCupertinoDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title:
                                const Center(child: Text('Select an Option')),
                            content: Container(
                              height: 260,
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      push(
                                          context,
                                          AccomodationPilgrimCodeSearch(
                                            user: widget.user,
                                          ));
                                    },
                                    child: Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(15),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        child: ListTile(
                                          leading: Icon(
                                            CupertinoIcons.qrcode,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 50,
                                          ),
                                          title: Text('Allocate Using QR'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      push(
                                          context,
                                          AccomodationPilgrimCodeSearch(
                                            user: widget.user,
                                          ));
                                    },
                                    child: Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(15),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        child: ListTile(
                                          trailing: Icon(
                                            Icons.person_search_outlined,
                                            color: Colors.red.shade800,
                                            size: 50,
                                          ),
                                          title:
                                              Text('Allocate by Pilgrim Code'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      push(context,
                                          ViewAllotedRoom(user: widget.user,));
                                    },
                                    child: Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(15),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        child: ListTile(
                                          leading: Icon(
                                            CupertinoIcons
                                                .square_stack_3d_down_dottedline,
                                            color:
                                                Theme.of(context).primaryColor,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0))),
                            actions: [],
                          );
                        },
                      );
                    },
                    child: MenuItem2(
                      val: 'ACCOMDATION',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //fligit
                Visibility(
                  visible: isflight,
                  child: InkWell(
                    onTap: () {
                      showCupertinoDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title:
                                const Center(child: Text('Select an Option')),
                            content: Container(
                              height: 380,
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      push(
                                          context,
                                          ManifestQR(
                                            user: widget.user,
                                          ));
                                    },
                                    child: Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(15),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        child: ListTile(
                                          leading: Icon(
                                            CupertinoIcons.qrcode,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 50,
                                          ),
                                          title: Text(
                                              'Issue Flight Manifest with QR'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      push(
                                          context,
                                          IssueManifestbycode(
                                            user: widget.user,
                                          ));
                                    },
                                    child: Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(15),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        child: ListTile(
                                          trailing: Icon(
                                            Icons.person_search_outlined,
                                            color: Colors.red.shade800,
                                            size: 50,
                                          ),
                                          title: Text(
                                              'Issue Flight Manfiest by Pilgrim Code'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      push(
                                          context,
                                          FlightboardingQR(
                                            user: widget.user,
                                          ));
                                    },
                                    child: Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(15),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        child: ListTile(
                                          leading: Icon(
                                            CupertinoIcons.airplane,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 50,
                                          ),
                                          title: Text('Flight Boarding'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      push(
                                          context,
                                          CodeFlightBoarding(
                                            user: widget.user,
                                          ));
                                    },
                                    child: Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(15),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        child: ListTile(
                                          trailing: Icon(
                                            Icons.airplanemode_active_outlined,
                                            color: Colors.red.shade800,
                                            size: 50,
                                          ),
                                          title:
                                              Text('Flight boarding by code'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            elevation: 34,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0))),
                            actions: [],
                          );
                        },
                      );
                    },
                    child: MenuItem3(
                      val: 'Flight',
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                //transporation
                Visibility(
                  visible: istransportation,
                  child: InkWell(
                    onTap: () {
                      showCupertinoDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title:
                                const Center(child: Text('Select an Option')),
                            content: Container(
                              height: 330,
                              child: Column(
                                children: [
                                  //Kaduna despatch
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (_) => FractionallySizedBox(
                                          heightFactor: 0.5,
                                          child: Column(
                                            children: [
                                              option(
                                                  context,
                                                  'Mando Hajj Camp to Airport Camp',
                                                  SelectBus(
                                                    user: widget.user,
                                                    route:
                                                        'kd_mando_to_airport',
                                                  )),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              option(
                                                  context,
                                                  'To Airport Tarmac',
                                                  SelectBus(
                                                    user: widget.user,
                                                    route:
                                                        'kd_airport_to_tarmac',
                                                  )),
                                              // SizedBox(
                                              //   height: 10,
                                              // ),
                                              // option(context, 'Boarding Aircraft',
                                              //     SelectBus()),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(15),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        child: ListTile(
                                          leading: Icon(
                                            CupertinoIcons.bus,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 50,
                                          ),
                                          title: Text('Kaduna Despatch'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //Jedda despatch
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (_) => FractionallySizedBox(
                                          heightFactor: 0.5,
                                          child: Column(
                                            children: [
                                              option(
                                                  context,
                                                  'Jeddah to Madinah',
                                                  SelectBus(
                                                    user: widget.user,
                                                    route: 'jeddah_to_madina',
                                                  )),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              option(
                                                  context,
                                                  'Jeddah to Makkah',
                                                  SelectBus(
                                                    user: widget.user,
                                                    route: 'jeddah_to_makkah',
                                                  )),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              option(
                                                  context,
                                                  'Jeddah to Aircraft',
                                                  SelectBus(
                                                    user: widget.user,
                                                    route: 'jeddah_to_aircraft',
                                                  )),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(15),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        child: ListTile(
                                          trailing: Icon(
                                            Icons.airplane_ticket_outlined,
                                            color: Colors.red.shade800,
                                            size: 50,
                                          ),
                                          title: Text('Jedda Despatch'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //Madina Desptach
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (_) => FractionallySizedBox(
                                          heightFactor: 0.5,
                                          child: Column(
                                            children: [
                                              option(
                                                  context,
                                                  'Madinah to Makkah',
                                                  SelectBus(
                                                    user: widget.user,
                                                    route: 'madina_to_makkah',
                                                  )),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              option(
                                                  context,
                                                  'Madinah to Jeddah ',
                                                  SelectBus(
                                                    user: widget.user,
                                                    route: 'madina_to_jiddahx`',
                                                  )),
                                            ],
                                          ),
                                        ),
                                      );

                                      // showModalBottomSheet(
                                      //   isScrollControlled: true,
                                      //   context: context,
                                      //   builder: (_) =>
                                      //       const FractionallySizedBox(
                                      //           heightFactor: 0.8,
                                      //           child: AmChatFriendModal(
                                      //               amount: '3000')),
                                      // );
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                          isScrollControlled: true,
                                          context: context,
                                          builder: (_) => FractionallySizedBox(
                                            heightFactor: 0.5,
                                            child: Column(
                                              children: [
                                                option(
                                                    context,
                                                    'Madinah to Makkah',
                                                    SelectBus(
                                                      user: widget.user,
                                                      route: 'madina_to_makkah',
                                                    )),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                option(
                                                    context,
                                                    'Madinah to Jeddah ',
                                                    SelectBus(
                                                      user: widget.user,
                                                      route: 'madina_to_jiddah',
                                                    )),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Material(
                                        elevation: 5,
                                        borderRadius: BorderRadius.circular(15),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: ListTile(
                                            leading: Icon(
                                              CupertinoIcons.bus,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              size: 50,
                                            ),
                                            title: Text('Madina Despatch'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  //Makkah desptach
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (_) => FractionallySizedBox(
                                          heightFactor: 0.5,
                                          child: Column(
                                            children: [
                                              option(
                                                  context,
                                                  'Makkah to Madina',
                                                  SelectBus(
                                                    user: widget.user,
                                                    route: 'makkah_to_madina',
                                                  )),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              option(
                                                  context,
                                                  'Makkah to Jeddah',
                                                  SelectBus(
                                                    user: widget.user,
                                                    route: 'makkah_to_jeddah',
                                                  )),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Material(
                                      elevation: 5,
                                      borderRadius: BorderRadius.circular(15),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        child: ListTile(
                                          leading: Icon(
                                            CupertinoIcons.bus,
                                            color:
                                                Theme.of(context).primaryColor,
                                            size: 50,
                                          ),
                                          title: Text('Makkah Despatch'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            elevation: 34,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14.0))),
                            actions: [],
                          );
                        },
                      );
                    },
                    child: MenuItem4(
                      val: 'Transportation',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: const BottomBar(),
    );
  }

  InkWell option(BuildContext context, String title, Widget page) {
    return InkWell(
      onTap: () {
        push(context, page);
      },
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: Icon(
              CupertinoIcons.airplane,
              color: Theme.of(context).primaryColor,
              size: 50,
            ),
            title: Text(title),
          ),
        ),
      ),
    );
  }
}
