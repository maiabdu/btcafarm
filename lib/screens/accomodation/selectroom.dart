import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kadpilgrims/models/operationsusermodel.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../functions/functions.dart';
import '../../models/hotelModel.dart';
import 'package:http/http.dart' as http;

import '../../models/usermodel.dart';
import 'Accomodationpilgrimcodesearch.dart';

class SelectRoom extends StatefulWidget {
  final String hotel, pilgrim, pilgrimName, floor;
  final OperationsUser user;
  const SelectRoom(
      {Key? key,
      required this.hotel,
      required this.pilgrim,
      required this.pilgrimName,
      required this.floor,
      required this.user})
      : super(key: key);

  @override
  _SelectRoomState createState() => _SelectRoomState();
}

class _SelectRoomState extends State<SelectRoom> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;

  List<Rooms> room = [];

  Future<void> fetchRooms(String hotel, floor) async {
    final response = await http
        .get(Uri.parse('$baseUrl/getroom.php?app=$hotel&floor=$floor'));
    // await http.get(Uri.parse('$baseUrl/getfloors.php?app=$hotel'));
    if (response.statusCode == 200) {
      debugPrint(response.body);
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      setState(() {
        room = jsonResponse.map((data) => Rooms.fromJson(data)).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRooms(widget.hotel, widget.floor);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: FutureBuilder<List<dynamic>>(
    //     future: fetchPosts(widget.hotel),
    //     builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
    //       if (snapshot.hasData) {
    //         return ListView.builder(
    //           itemCount: snapshot.data!.length,
    //           itemBuilder: (BuildContext context, int index) {
    //             return ListTile(
    //               title: Text(snapshot.data![index]['floor']),
    //             );
    //           },
    //         );
    //       } else if (snapshot.hasError) {
    //         return Center(child: Text('Error: ${snapshot.error}'));
    //       } else {
    //         return Center(child: CircularProgressIndicator());
    //       }
    //     },
    //   ),
    // );

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Select Room for ' + widget.pilgrimName,
        ),
      ),
      body: room.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: room.length,
              // itemCount: 1,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: option(
                      context,
                      'Room ' + room[index].room,
                      room[index].space,
                      room[index].is_full + ' of ' + room[index].space,
                      widget.pilgrimName,
                      widget.floor,
                      room[index].room,
                      widget.hotel,
                      widget.pilgrim,
                      room[index].rid,
                      widget.user.userID.toString()),
                );
                // title: Text(snapshot
                //     .data![index]['appartment']),
              },
            ),
    );
  }

  InkWell option(BuildContext context, String title, space, occupied, pilgrim,
      floor, room, hotel, pilgrimId, rid, acb) {
    double? s = double.tryParse(space);
    double? c = double.tryParse(occupied);

    bool isfull = false;
    if (s == c) {
      isfull = true;
    }
    return InkWell(
      onTap: () {
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
                  Text('Pilgrim: ' + pilgrim),
                  Text('Hotel ' + hotel),
                  Text('Floor: ' + floor),
                  Text('Room NO: ' + room),
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

                        bool ispushed = await allocateRoom(
                            pilgrimId, hotel, floor, room, acb, rid, context);

                        if (ispushed == true) {
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

                          pushAndRemoveUntil(
                              context,
                              AccomodationPilgrimCodeSearch(
                                user: widget.user,
                              ),
                              false);
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
                            title: Text('Continue'),
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

        // push(context, page);
      },
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            leading: Icon(
              CupertinoIcons.home,
              color: Theme.of(context).primaryColor,
              size: 50,
            ),
            title: isfull == true
                ? Text(
                    title + ' -- Room Full',
                    style: TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough),
                  )
                : Text(title),
            subtitle: Row(
              children: [
                Text('Bed Space '),
                Text(
                  '($space)',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ],
            ),
            trailing: Text(
              occupied,
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
