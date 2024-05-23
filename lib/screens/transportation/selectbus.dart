import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:kadpilgrims/models/operationsusermodel.dart';
import 'package:flutter/material.dart';
import 'package:kadpilgrims/screens/transportation/pilgrimsonboard.dart';
import '../../functions/functions.dart';
import '../../models/btadashboardmodel.dart';
import '../../models/transportation.dart';
import '../../widgets/app_bar_default.dart';
import '../../widgets/bottom_bar.dart';
import 'package:http/http.dart' as http;

import 'despatch.dart';

class SelectBus extends StatefulWidget {
  final OperationsUser user;
  final String route;

  // final MininingData miningData;

  const SelectBus({
    Key? key,
    required this.user,
    required this.route,
  }) : super(key: key);
  @override
  State<SelectBus> createState() => _SelectBusState();
}

class _SelectBusState extends State<SelectBus> {
  // late Future<Buses> btaData;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  late Future<List<Buses>> futureData;
  TextEditingController? bus = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // btaData = fetchDashboadBTA(widget.user.userID);
    futureData = fetchData(widget.route);
  }

  // Future<List<Data>> fetchData(String argument) async {
  //   final response = await http.get(Uri.parse('${widget.apiUrl}?arg=$argument'));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> jsonData = json.decode(response.body);
  //     return jsonData.map((item) => Data.fromJson(item)).toList();
  //   } else {
  //     throw Exception('Failed to fetch data');
  //   }
  // }

  Future<List<Buses>> fetchData(String route) async {
    debugPrint(route);
    final response =
        await http.get(Uri.parse('$baseUrl/viewbus.php?route=$route'));
    if (response.statusCode == 200) {
      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => Buses.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault(context),
      body: FutureBuilder<List<Buses>>(
        future: futureData,
        builder: (BuildContext context, AsyncSnapshot<List<Buses>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<Buses> data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final Buses item = data[index];
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: selectBuses(
                          item.name, item.id, item.route, item.count),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                          onTap: () {
                            push(
                                context,
                                PilgrimsOnboard(
                                  user: widget.user,
                                  route: item.route,
                                ));
                          },
                          child: Text(
                            'View Pilgrims onBoard',
                            style: TextStyle(color: Colors.blue),
                          )),
                    )
                  ],
                );
                // return ListTile(
                //   isThreeLine: true,
                //   title: Text(item.name),
                //   subtitle: Text('Bus: ' + item.name),
                //   trailing: Text('Route: ' + item.route),
                //   // subtitle: Text('ID: ${item.id}'),
                // );
              },
            );
          }
        },
      ),

      floatingActionButton: Container(
        width: 140,
        height: 60,
        child: FloatingActionButton(
          onPressed: () async {
            // Action to perform when the button is pressed
            await dialogue(context).then((value) {
              debugPrint('return of :' + value.toString());

              if (value == true) {
                setState(() {
                  futureData = fetchData(widget.route);
                  bus!.text = '';
                });
              }
            });
            // showModalBottomSheet(
            //   isScrollControlled: true,
            //   context: context,
            //   builder: (_) => FractionallySizedBox(
            //     heightFactor: 0.5,
            //     child: Column(
            //       children: [
            //         // TODO::check and rectify this;
            //        Text('hello')
            //       ],
            //     ),
            //   ),
            // );
          },
          child: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.add,
                  size: 40,
                ),
                Text(
                  'Add Bus',
                  style: TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          elevation: 14.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          // Set the desired size using the size property
          // You can adjust the values as per your preference
          // Here, width and height are both set to 56.0
          // Modify these values to make the button bigger or smaller
          // For example, width: 64.0, height: 64.0 for a larger button
          // or width: 48.0, height: 48.0 for a smaller button
          // You can also use MediaQuery to dynamically calculate the size based on the device's screen size
          // width: MediaQuery.of(context).size.width * 0.15,
          // height: MediaQuery.of(context).size.width * 0.15,
          mini: false,
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
      // bottomNavigationBar: const BottomBar(),
    );
  }

  Future<dynamic> dialogue(BuildContext context) {
    return showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ADD BUS to ' + widget.route),
            ],
          )),
          content: Container(
            height: MediaQuery.of(context).size.height * .2,
            width: MediaQuery.of(context).size.width * .8,
            child: Column(
              children: [
                Form(
                  key: globalFormKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: bus,
                        validator: minimum3,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Bus Name",
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.2))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                          prefixIcon: Icon(
                            Icons.bus_alert_sharp,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: IconButton(
                              color: Colors.white,
                              onPressed: () async {
                                if (globalFormKey.currentState?.validate() ??
                                    false) {
                                  globalFormKey.currentState!.save();
                                  String? bus_name = bus?.text.toString();
                                  print(bus_name);
                                  // print(password);

                                  showProgress(context, 'Adding bus', true);

                                  var addingBus = await addbus(
                                      bus_name,
                                      widget.route,
                                      widget.user.userID,
                                      context);

                                  if (addingBus == false) {
                                    //set preferences for auto addingBus
                                    // await saveUserCredentials(email, password);
                                    ScaffoldMessenger.of(context)
                                      ..removeCurrentSnackBar()
                                      ..showSnackBar(SnackBar(
                                          content: Container(
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  1,
                                              color: Colors.red,
                                              child: const Center(
                                                child: Text(
                                                  'Operation Failed',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.white),
                                                ),
                                              ))));

                                    Navigator.of(context).pop(false);
                                  }

                                  if (addingBus == true) {
                                    // Navigator.pop(context, true);
                                    setState(() {});
                                    ScaffoldMessenger.of(context)
                                      ..removeCurrentSnackBar()
                                      ..showSnackBar(SnackBar(
                                          content: Container(
                                              height: 50,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  1,
                                              color: Colors.green,
                                              child: const Center(
                                                child: Text(
                                                  'Bus Added',
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.white),
                                                ),
                                              ))));

                                    Navigator.of(context).pop(true);
                                  }
                                }
                              },
                              icon: const Icon(Icons.arrow_forward),
                            ),
                          ),
                        ],
                      ),
                    ],
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
  }

  InkWell selectBuses(String name, bus_id, route, count) {
    return InkWell(
      onTap: () {
        // print('hello');
        push(
            context,
            TransportOperations(
              user: widget.user,
              distination: route,
              bus_id: bus_id,
            ));
      },
      child: Column(
        children: [
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(15),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                leading: Icon(
                  CupertinoIcons.bus,
                  color: Theme.of(context).primaryColor,
                  size: 50,
                ),
                title: Text(name),
                subtitle: Row(
                  children: [
                    Text('Route: '),
                    Text(
                      '$route',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ],
                ),
                trailing: Text(
                  count.toString() + ' Persons onbord',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  ListTile issuedList(BuildContext context, String pilgrim, description) {
    return ListTile(
      title: Text(pilgrim),
      subtitle: Text(description),
      trailing: Icon(
        Icons.check,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
