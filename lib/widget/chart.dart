import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';


class Charts extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  Charts(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory Charts.withSampleData(List<CaseTimeSeriesDate> dailyData, Color color) {
    return new Charts(
      _createSampleData(dailyData, color),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      defaultInteractions: false,
      primaryMeasureAxis:
          new charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),
      domainAxis: new charts.DateTimeAxisSpec(
        showAxisLine: false,
        renderSpec: new charts.NoneRenderSpec(),
      ),
    );
  }

  static charts.Color getChartColor(Color color) {
    return charts.Color(
      r: color.red,
      g: color.green,
      b: color.blue,
      a: color.alpha,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<CaseTimeSeriesDate, DateTime>> _createSampleData(
      List<CaseTimeSeriesDate> dailyData,  Color color) {

    return [
      new charts.Series<CaseTimeSeriesDate, DateTime>(
        id: 'Kuchbhi',
        colorFn: (_, __) => getChartColor(color),
        domainFn: (CaseTimeSeriesDate sales, _) => sales.time,
        measureFn: (CaseTimeSeriesDate sales, _) => sales.data,
        data: dailyData,
      )
    ];
  }
}

class CaseTimeSeriesDate {
  final DateTime time;
  final int data;

  CaseTimeSeriesDate(this.time, this.data);
}
