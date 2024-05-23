import 'dart:convert';

import 'package:kadpilgrims/models/operationsusermodel.dart';

import 'package:flutter/material.dart';
import '../../functions/functions.dart';
import '../../models/btadashboardmodel.dart';

import '../../models/transportation.dart';
import '../../widgets/app_bar_default.dart';
import '../../widgets/bottom_bar.dart';

import 'package:http/http.dart' as http;

import '../../widgets/widgets.dart';

class PilgrimsOnboard extends StatefulWidget {
  final OperationsUser user;
  final String route;
  // final MininingData miningData;

  const PilgrimsOnboard({
    Key? key,
    required this.user, required this.route,
    // required this.user,
  }) : super(key: key);
  @override
  State<PilgrimsOnboard> createState() => _PilgrimsOnboardState();
}

class _PilgrimsOnboardState extends State<PilgrimsOnboard> {
  // late Future<DashboadBTA> btaData;
  late Future<List<PigrimOnBuses>> futureData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // btaData = fetchDashboadBTA(widget.user.userID);
    futureData = fetchData(widget.user.userID, widget.route);
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

  Future<List<PigrimOnBuses>> fetchData(String uid, route) async {
    final response =
        await http.get(Uri.parse('$baseUrl/viewpilgrimsonbus.php?route=$route&uid=$uid'));
    if (response.statusCode == 200) {
      debugPrint(response.body);
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => PigrimOnBuses.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault(context),
      body: FutureBuilder<List<PigrimOnBuses>>(
        future: futureData,
        builder:
            (BuildContext context, AsyncSnapshot<List<PigrimOnBuses>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<PigrimOnBuses> data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final PigrimOnBuses item = data[index];
                return ListTile(
                  isThreeLine: false,
                  title:  Text('' + item.name + ' ' + item.otherName),
                  subtitle: Text('PassportNo: ' + item.passportNo),
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
