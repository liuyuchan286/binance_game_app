import 'package:binance_game_app/pages/bedside_statistics/simple_line.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import '' show Color;

class BedsideStatisticsModel {
  List<String> legends;
  List<Series> series;
  List<String> xaxisData;

  BedsideStatisticsModel({
      this.legends, 
      this.series, 
      this.xaxisData});

  BedsideStatisticsModel.fromJson(dynamic json) {
    legends = json["legends"] != null ? json["legends"].cast<String>() : [];
    if (json["series"] != null) {
      series = [];
      json["series"].forEach((v) {
        series.add(Series.fromJson(v));
      });
    }
    xaxisData = json["xaxisData"] != null ? json["xaxisData"].cast<String>() : [];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["legends"] = legends;
    if (series != null) {
      map["series"] = series.map((v) => v.toJson()).toList();
    }
    map["xaxisData"] = xaxisData;
    return map;
  }

  /// Create one series with sample hard coded data.
  List<charts.Series<LinearSales, String>> createSampleData() {
    List<dynamic> colors = [
      charts.MaterialPalette.blue.shadeDefault,
      charts.MaterialPalette.red.shadeDefault,
      charts.MaterialPalette.gray.shadeDefault,
      charts.MaterialPalette.green.shadeDefault,
    ];

    return [
      for(int l = 0;l <= legends.length - 1;l++)
      new charts.Series<LinearSales, String>(
        id: legends[l],
        colorFn: (_, __) => colors[l],
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: [
            for(int i = 0;i <= xaxisData.length - 1;i++)
            new LinearSales(xaxisData[i], series[l].data[i]),
        ],
      )
    ];
  }


}

class Series {
  String name;
  String type;
  String stack;
  List<double> data;

  Series({
      this.name, 
      this.type, 
      this.stack, 
      this.data});

  Series.fromJson(dynamic json) {
    name = json["name"];
    type = json["type"];
    stack = json["stack"];

    if (json["data"] != null) {
      data = [];
      json["data"].forEach((v) {
        data.add(double.parse(v.toString()));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["type"] = type;
    map["stack"] = stack;
    map["data"] = data;
    return map;
  }

}