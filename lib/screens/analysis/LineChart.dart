import 'package:flutter/material.dart';
import 'package:stress_detection_app/charts/chart.dart';
import 'package:stress_detection_app/models/linerseries.dart';
import 'package:stress_detection_app/screens/analysis/OpenReport.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'OpenReport.dart';

// ignore: must_be_immutable
class LineChart extends StatelessWidget {
  TooltipBehavior? _tooltipBehavior;

  @override
  Widget build(BuildContext context) {

    final List<DeveloperSeries> data = [

      DeveloperSeries(
        year: new DateTime(2021, 5, 31),
        level: 9,
        barColor: charts.ColorUtil.fromDartColor(Colors.green),
      ),
      DeveloperSeries(
        year: new DateTime(2021, 6, 1),
        level: 8,
        barColor: charts.ColorUtil.fromDartColor(Colors.green),
      ),
      DeveloperSeries(
        year: new DateTime(2021, 6, 2),
        level: 6,
        barColor: charts.ColorUtil.fromDartColor(Colors.green),
      ),
      DeveloperSeries(
        year: new DateTime(2021, 6, 3),
        level: 7,
        barColor: charts.ColorUtil.fromDartColor(Colors.green),
      ),
      DeveloperSeries(
        year: new DateTime(2021, 6, 4),
        level: 8,
        barColor: charts.ColorUtil.fromDartColor(Colors.green),
      ),
    ];
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        child: Row(
          children: <Widget> [
            ElevatedButton(
            child: Text('Generate Report'),
            onPressed: createReport
          ),
          DeveloperChart(
            data: data,
          )
          ] 
        )
        // child: Container(
        //   // Center is a layout widget. It takes a single child and positions it
        //   // in the middle of the parent.
        //   // height of the Container widget
        //   height: 450,
        //   // width of the Container widget
        //   child: SfCartesianChart(
        //     primaryXAxis: DateTimeAxis(),
        //
        //     // Enable legend
        //     legend:
        //     Legend(isVisible: true,  position: LegendPosition.bottom),
        //     // Chart title
        //     title: ChartTitle(text: 'Stress Level over Past Week'),
        //
        //     // Enable tooltip
        //     tooltipBehavior: _tooltipBehavior,
        //
        //     series: <LineSeries<ChartData, DateTime>>[
        //       LineSeries<ChartData, DateTime>(
        //         // Bind data source
        //           dataSource: <ChartData>[
        //             ChartData(DateTime(2022, 5, 7), 9),
        //             ChartData(DateTime(2022, 5, 8), 8),
        //             ChartData(DateTime(2022, 5, 9), 9),
        //             ChartData(DateTime(2022, 5, 10), 6),
        //             ChartData(DateTime(2022, 5, 11), 5),
        //             ChartData(DateTime(2022, 5, 12), 7),
        //             ChartData(DateTime(2022, 5, 13), 6),
        //           ],
        //           xValueMapper: (ChartData data, _) => data.year,
        //           yValueMapper: (ChartData data, _) => data.sales,
        //           dataLabelSettings: DataLabelSettings(isVisible: true))
        //     ],
        //   ),
        // ),
      ),
    );
  }

  Future<void> createReport() async {

    PdfDocument document =  PdfDocument();
    document.pages.add();

    List<int> bytes = document.save();
    document.dispose();

    saveLaunchFiles(bytes, 'Report.pdf'); 
  }
}

class ChartData {
  ChartData(this.year, this.sales);

  final DateTime year;
  final double sales;
}
