import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class DeveloperSeries {
  final DateTime year;
  final int level;
  final charts.Color barColor;

  DeveloperSeries(
      {
        required this.year,
        required this.level,
        required this.barColor
      }
      );
}