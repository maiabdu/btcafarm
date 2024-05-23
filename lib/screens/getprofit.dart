import 'package:kadpilgrims/models/miningmode.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../widgets/chart.dart';

class Profit extends StatelessWidget {
  final MininingData data;
  const Profit({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32.0, horizontal: 0),
                child: CardChart(),
              ),
              ListTile(
                textColor: Theme.of(context).primaryColor,
                title: const Text(
                  'Package',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: const Text(
                  '',
                  style: TextStyle(fontSize: 10),
                ),
                trailing: Text(
                  data.packageName,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              listData(context, 'Month Mined', '', data.monthMinned + 'Months'),
              listData(context, 'Max Load', 'BTCA', data.maxLoad + ' BTCA'),
              listData(
                  context, 'Mined Today', 'BTCA', data.minnedToday + ' BTCA'),
              listData(context, 'Mined This Month', 'BTCA',
                  data.minnedThisMonth + ' BTCA'),
              listData(
                  context, 'Total Mined', 'BTCA', data.totalMinned + ' BTCA'),
            ],
          ),
        ),
      ),
    );
  }

  ListTile listData(
      BuildContext context, String header, String subtitle, String value) {
    return ListTile(
      // textColor: Theme.of(context).primaryColor,
      title: Text(
        header,
        style: TextStyle(fontSize: 15),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 12),
      ),
      trailing: Text(
        value,
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}
