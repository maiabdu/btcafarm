import 'package:btcafarm/constants.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class LineChart extends StatelessWidget {
  const LineChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var Get = MediaQuery.of(context).size;
    final staticTicks = <charts.TickSpec<double>>[];
    return charts.LineChart(
      _createSampleData(context),
      animate: true,
      domainAxis: charts.NumericAxisSpec(
          showAxisLine: false,
          tickProviderSpec: charts.StaticNumericTickProviderSpec(
              staticTicks)), // charts.NumericAxisSpec
      primaryMeasureAxis: const charts.NumericAxisSpec(
          showAxisLine: false,
          tickProviderSpec: charts.StaticNumericTickProviderSpec(
              [])), // charts.NumericAxisSpec
      behaviors: [
        charts.LinePointHighlighter(
            showHorizontalFollowLine:
                charts.LinePointHighlighterFollowLineType.none,
            showVerticalFollowLine: charts.LinePointHighlighterFollowLineType
                .nearest) // charts.LinePointHighlighter
      ],
    );

    // charts.LineChart
  }

  static List<charts.Series<LinearSales, int>> _createSampleData(BuildContext context) {
    final data = [
      LinearSales(0, 100),
      LinearSales(1, 100),
      LinearSales(2, 80),
      LinearSales(3, 80),
      LinearSales(4, 50),
      LinearSales(5, 50),
      LinearSales(6, 30),
      LinearSales(7, 30),
      LinearSales(8, 40),
      LinearSales(9, 25),
      LinearSales(10, 10),
      LinearSales(11, 30),
      LinearSales(12, 30),
      LinearSales(13, 50),
      LinearSales(14, 70),
      LinearSales(15, 70),
    ];

    final datatwo = [
      LinearSales(3, 80),
      LinearSales(4, 50),
      LinearSales(5, 50),
      LinearSales(6, 30),
      LinearSales(7, 30),
      LinearSales(8, 40),
      LinearSales(9, 25),
      LinearSales(10, 10),
      LinearSales(11, 30),
      LinearSales(12, 30),
    ];

    return [
      charts.Series<LinearSales, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(
            Theme.of(context).primaryColor.withOpacity(.2)),
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      ),
      charts.Series<LinearSales, int>(
        id: 'two',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(kPrimaryColor),
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: datatwo,
      )
    ];
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
