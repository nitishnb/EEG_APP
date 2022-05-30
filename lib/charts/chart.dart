import 'dart:core';
import 'dart:math';

import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:stress_detection_app/models/linerseries.dart';
// ignore: implementation_imports
import 'package:charts_flutter/src/text_element.dart' as element;
// ignore: implementation_imports
import 'package:charts_flutter/src/text_style.dart' as style;


class DeveloperChart extends StatefulWidget {
  var data;


  DeveloperChart({required this.data});
  @override
  _DeveloperChartState createState() => _DeveloperChartState(data);
}

class _DeveloperChartState extends State<DeveloperChart> {
  final List<DeveloperSeries> data;
  _DeveloperChartState(this.data);
  get series => null;
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    String stressValue = "1";
    List<charts.Series<DeveloperSeries, DateTime>> series = [
      charts.Series(
          id: "Stress Level",
          data: data,
          domainFn: (DeveloperSeries series, _) => series.year,
          measureFn: (DeveloperSeries series, _) => series.level,
          colorFn: (DeveloperSeries series, _) => series.barColor
      )
    ];
    return Container(
      height: 500,
      width: 500,
      padding: EdgeInsets.all(25),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: <Widget>[
              Text(
                "Stress Level over past week",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: charts.TimeSeriesChart(series,
                    animate: true,
                    domainAxis: new charts.DateTimeAxisSpec(
                        renderSpec: charts.SmallTickRendererSpec(labelRotation: 45),
                        tickProviderSpec: charts.DayTickProviderSpec(increments: [1]),
                        tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(),
                        showAxisLine: false,
                    ),
                    primaryMeasureAxis: charts.NumericAxisSpec(
                        // tickProviderSpec: charts.BasicNumericTickProviderSpec(zeroBound: false),
                        viewport: charts.NumericExtents(1, 10)
                    ),
                    behaviors: [
                      charts.LinePointHighlighter(
                        symbolRenderer: TextSymbolRenderer(()=>"2"),
                      ),
                      charts.SeriesLegend(
                        position: charts.BehaviorPosition.top,
                        outsideJustification: charts.OutsideJustification.middleDrawArea,
                        horizontalFirst: false,
                        desiredMaxRows: 2,
                        cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                        entryTextStyle: charts.TextStyleSpec(
                            fontFamily: 'Georgia',
                            fontSize: 11
                        ),
                      ),
                    ],
                  selectionModels: [
                    charts.SelectionModelConfig(
                        type: charts.SelectionModelType.info,
                        changedListener: (charts.SelectionModel model) {
                          if (model.hasDatumSelection) {
                            setState(() {
                              stressValue = (model.selectedSeries[0].measureFn(model.selectedDatum[0].index)).toString();
                            });
                            print(stressValue);
                          }
                        }
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

typedef GetText = String Function();

class TextSymbolRenderer extends CircleSymbolRenderer {

  TextSymbolRenderer(this.getText, {this.marginBottom = 8, this.padding = const EdgeInsets.all(8)});

  final GetText getText;
  final double marginBottom;
  final EdgeInsets padding;


  @override
  void paint(ChartCanvas canvas, Rectangle<num> bounds, {List<int>? dashPattern, Color? fillColor, FillPatternType? fillPattern, Color? strokeColor, double? strokeWidthPx}) {
    super.paint(canvas, bounds, dashPattern: dashPattern, fillColor: fillColor, fillPattern: fillPattern, strokeColor: strokeColor, strokeWidthPx: strokeWidthPx);

    style.TextStyle textStyle = style.TextStyle();
    textStyle.color = Color.white;
    textStyle.fontSize = 15;

    element.TextElement textElement = element.TextElement(getText.call(), style: textStyle);
    double width = textElement.measurement.horizontalSliceWidth;
    double height = textElement.measurement.verticalSliceWidth;

    double centerX = bounds.left + bounds.width / 2;
    double centerY = bounds.top + bounds.height / 2 - marginBottom - (padding.top + padding.bottom);

    canvas.drawRRect(
      Rectangle(
        centerX - (width / 2) - padding.left,
        centerY - (height / 2) - padding.top,
        width + (padding.left + padding.right),
        height + (padding.top + padding.bottom),
      ),
      fill: Color.black,
      radius: 16,
      roundTopLeft: true,
      roundTopRight: true,
      roundBottomRight: true,
      roundBottomLeft: true,
    );
    canvas.drawText(
      textElement,
      (centerX - (width / 2)).round(),
      (centerY - (height / 2)).round(),
    );
  }
}
