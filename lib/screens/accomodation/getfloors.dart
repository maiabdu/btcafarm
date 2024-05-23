import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kadpilgrims/models/operationsusermodel.dart';
import 'package:kadpilgrims/screens/accomodation/selectroom.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../functions/functions.dart';
import '../../models/hotelModel.dart';
import 'package:http/http.dart' as http;

class Getfloors extends StatefulWidget {
  final String hotel, pilgrim, pilgrimName;
  final OperationsUser user;
  const Getfloors(
      {Key? key,
      required this.hotel,
      required this.pilgrim,
      required this.pilgrimName, required this.user})
      : super(key: key);

  @override
  _GetfloorsState createState() => _GetfloorsState();
}

class _GetfloorsState extends State<Getfloors> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;

  List<Floors> floor = [];

  Future<void> fetchFloor(String hotel) async {
    final response =
        await http.get(Uri.parse('$baseUrl/getfloors.php?app=$hotel'));
    if (response.statusCode == 200) {
      debugPrint(response.body);
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      setState(() {
        floor = jsonResponse.map((data) => Floors.fromJson(data)).toList();
      });
    }
  }

  Future<List<dynamic>> fetchPosts(String hotel) async {
    var result = await http.get(Uri.parse('$baseUrl/getfloors.php?app=$hotel'));
    debugPrint(result.body);
    return json.decode(result.body);
  }

  @override
  void initState() {
    super.initState();
    fetchFloor(widget.hotel);
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
          'Select Floor for ' + widget.pilgrimName,
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: floor.length,
        // itemCount: 1,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: option(
                context,
                'Floor ' + floor[index].floor,
                SelectRoom(
                    hotel: widget.hotel,
                    pilgrim: widget.pilgrim,
                    pilgrimName: widget.pilgrimName,
                    floor: floor[index].floor,
                    user: widget.user,
                    )),
          );
          // title: Text(snapshot
          //     .data![index]['appartment']),
        },
      ),
    );
  }

  InkWell option(BuildContext context, String title, Widget room) {
    return InkWell(
      onTap: () {
        push(context, room);
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
            title: Text(title),
          ),
        ),
      ),
    );
  }
}
