import 'package:flutter/material.dart';
import 'package:stress_detection_app/screens/home/NavBar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:stress_detection_app/services/auth.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AuthService _auth = AuthService();
  TooltipBehavior? _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: SafeArea(
          child: Center(
            child: Container(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              // height of the Container widget
              height: 450,
              // width of the Container widget
              child: SfCartesianChart(
                primaryXAxis: DateTimeAxis(),

                // Enable legend
                legend:
                Legend(isVisible: true,  position: LegendPosition.bottom),
                // Chart title
                title: ChartTitle(text: 'Stress Level over Past Week'),

                // Enable tooltip
                tooltipBehavior: _tooltipBehavior,

                series: <LineSeries<ChartData, DateTime>>[
                  LineSeries<ChartData, DateTime>(
                      // Bind data source
                      dataSource: <ChartData>[
                        ChartData(DateTime(2022, 5, 7), 9),
                        ChartData(DateTime(2022, 5, 8), 8),
                        ChartData(DateTime(2022, 5, 9), 9),
                        ChartData(DateTime(2022, 5, 10), 6),
                        ChartData(DateTime(2022, 5, 11), 5),
                        ChartData(DateTime(2022, 5, 12), 7),
                        ChartData(DateTime(2022, 5, 13), 6),
                      ],
                      xValueMapper: (ChartData data, _) => data.year,
                      yValueMapper: (ChartData data, _) => data.sales,
                      dataLabelSettings: DataLabelSettings(isVisible: true))
                ],
              ),
            ),
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class ChartData {
  ChartData(this.year, this.sales);

  final DateTime year;
  final double sales;
}
