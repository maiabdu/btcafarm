 import 'dart:convert';

import 'package:kadpilgrims/models/operationsusermodel.dart';

import 'package:flutter/material.dart';
import '../../functions/functions.dart';
import '../../models/btadashboardmodel.dart';

import '../../models/usermodel.dart';
import '../../widgets/app_bar_default.dart';
import '../../widgets/bottom_bar.dart';

import 'package:http/http.dart' as http;

import '../../widgets/widgets.dart';

class ViewAllotedRoom extends StatefulWidget {
  final OperationsUser user;
  // final MininingData miningData;

  ViewAllotedRoom({
    Key? key,
    required this.user,
    // required this.user,
  }) : super(key: key);
  @override
  State<ViewAllotedRoom> createState() => _ViewAllotedRoomState();
}

class _ViewAllotedRoomState extends State<ViewAllotedRoom> {
  // late Future<DashboadBTA> btaData;
  late Future<List<AccomodationInfo>> futureData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // btaData = fetchDashboadBTA(widget.user.userID);
    futureData = fetchData(widget.user.userID);
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

  Future<List<AccomodationInfo>> fetchData(String uid) async {
    final response =
        await http.get(Uri.parse('$baseUrl/myallotedroom.php?uid=$uid'));
    if (response.statusCode == 200) {
      debugPrint(response.body);
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => AccomodationInfo.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault(context),
      body: FutureBuilder<List<AccomodationInfo>>(
        future: futureData,
        builder:
            (BuildContext context, AsyncSnapshot<List<AccomodationInfo>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<AccomodationInfo> data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final AccomodationInfo item = data[index];
                return ListTile(
                  isThreeLine: true,
                  title: Text(item.name),
                  subtitle: Text('House : ' + item.house +' Floor: ' + item.floor + ' Room: ' + item.room),
                  trailing: Text('bed: ' + item.bed),
                  // subtitle: Text('ID: ${item.id}'),
                );
              },
            );
          }
        },
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: const BottomBar(),
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
