/// Example of a simple line chart.
import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:charts_flutter/src/text_element.dart' as TextElement;
import 'package:charts_flutter/src/text_style.dart' as style;
import 'package:charts_common/common.dart' as common
    show
    TextStyleSpec;

import 'package:flutter/rendering.dart'
    show Color, TextBaseline, TextPainter, TextSpan, TextStyle;

class SimpleLineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final String unit;

  SimpleLineChart(this.seriesList, {this.animate=true,this.unit});

  /// Creates a [LineChart] with sample data and no transition.
  factory SimpleLineChart.withSampleData(seriesList,{unit}) {
    return new SimpleLineChart(
      seriesList,
      // Disable animations for image tests.
      animate: false,
      unit: unit,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.OrdinalComboChart(
      seriesList,
      animate: animate,
      defaultRenderer: new charts.LineRendererConfig(

      ),
      behaviors: [
        LinePointHighlighter(
            symbolRenderer: CustomCircleSymbolRenderer()
        ),
        new charts.SeriesLegend(

          position: charts.BehaviorPosition.top,

          horizontalFirst: false,

          cellPadding: new EdgeInsets.only(right: 4.0.w, bottom: 4.0.h),

          showMeasures: true,
          entryTextStyle: common.TextStyleSpec(
            fontSize: 12
          ),
          measureFormatter: (num value) {
            return value == null ? '-' : '${value}( ${unit ?? "元"})';
          },
        ),
      ],
      selectionModels: [
        new charts.SelectionModelConfig(
            changedListener: (SelectionModel model) {}
        )
      ],
    );
  }
}

/// Sample linear data type.
class LinearSales {
  final String year;
  final double sales;

  LinearSales(this.year, this.sales);
}

class CustomCircleSymbolRenderer extends CircleSymbolRenderer {

  @override
  void paint(ChartCanvas canvas, Rectangle<num> bounds, {List<int> dashPattern, Color fillColor, FillPatternType fillPattern, Color strokeColor, double strokeWidthPx}) {
    super.paint(canvas, bounds, dashPattern: dashPattern, fillColor: fillColor,fillPattern: fillPattern, strokeColor: strokeColor, strokeWidthPx: strokeWidthPx);
    canvas.drawRect(
        Rectangle(bounds.left - 5, bounds.top - 30, bounds.width + 10, bounds.height + 10),
        fill: Color.white
    );
    var textStyle = style.TextStyle();
    textStyle.color = Color.transparent;
    textStyle.fontSize = 10;
    canvas.drawText(
        TextElement.TextElement(null, style: textStyle),
        (bounds.left).round(),
        (bounds.top - 28).round()
    );
  }
}
