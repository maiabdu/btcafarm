import 'dart:convert';

import 'package:kadpilgrims/models/operationsusermodel.dart';

import 'package:flutter/material.dart';
import '../../functions/functions.dart';
import '../../models/btadashboardmodel.dart';

import '../../widgets/app_bar_default.dart';
import '../../widgets/bottom_bar.dart';

import 'package:http/http.dart' as http;

import '../../widgets/widgets.dart';

class BtaDashboard extends StatefulWidget {
  final OperationsUser user;
  // final MininingData miningData;

  BtaDashboard({
    Key? key,
    required this.user,
    // required this.user,
  }) : super(key: key);
  @override
  State<BtaDashboard> createState() => _BtaDashboardState();
}

class _BtaDashboardState extends State<BtaDashboard> {
  // late Future<DashboadBTA> btaData;
  late Future<List<DashboadBTA>> futureData;

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

  Future<List<DashboadBTA>> fetchData(String uid) async {
    final response =
        await http.get(Uri.parse('$baseUrl/myissuedbta.php?uid=$uid'));
    if (response.statusCode == 200) {
      debugPrint(response.body);
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((item) => DashboadBTA.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDefault(context),
      body: FutureBuilder<List<DashboadBTA>>(
        future: futureData,
        builder:
            (BuildContext context, AsyncSnapshot<List<DashboadBTA>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final List<DashboadBTA> data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                final DashboadBTA item = data[index];
                return ListTile(
                  isThreeLine: true,
                  title: Text(item.name),
                  subtitle: Text('Passport NO: ' + item.passport_no),
                  trailing: Text('LGA: ' + item.lga),
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
