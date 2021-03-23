import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap_dashboard/models/age_model.dart';
import 'package:sales_snap_dashboard/models/buy_button_click.dart';
import 'package:sales_snap_dashboard/models/buy_model.dart';
import 'package:sales_snap_dashboard/models/chart_model.dart';
import 'package:sales_snap_dashboard/models/linear_sales.dart';
import 'package:sales_snap_dashboard/servises/firestore_methods.dart';
import 'package:charts_flutter/flutter.dart' as chart;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HomeController extends GetxController {
  HomeController get to => Get.find<HomeController>();
  int numberOfUsers;
  int numberOfMales;
  int numberofFemales;

  var startDate = DateTime(2020, 1, 1, 1, 1);

  var endDate = DateTime.now();

  List<String> ages = [];

  List<AgeModel> ageModellist = [];

  List<BuyButtonClick> buyButtonClick = [];

  List<BuyModel> buyRate = [];

  List<chart.Series<ChartModel, String>> series;

  List<chart.Series<AgeModel, String>> ageSeries;

  List<chart.Series<ChartModel, String>> clickRateSeries;

  FirestoreMethods methods = FirestoreMethods();

  bool isLoading = true;

  onInit() {
    pieData(startDate, endDate);
    getAges(startDate, endDate);
    getBuyButtonClick(startDate, endDate);
    super.onInit();
  }

  onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    pieData(args.value.startDate, args.value.endDate);
    getAges(args.value.startDate, args.value.endDate);
    getBuyButtonClick(args.value.startDate, args.value.endDate);
  }

  void getAges(startDate, endDate) async {
    ages = await methods.getAges(startDate, endDate);

    var map = Map();

    print(ages.toString());

    ages.forEach((element) {
      if (!map.containsKey(element)) {
        map[element] = 1;
      } else {
        map[element] += 1;
      }
    });

    ageModellist = map.entries
        .map((e) => AgeModel(age: "age " + e.key.toString(), number: e.value))
        .toList();

    final ageseries = [
      chart.Series<AgeModel, String>(
        id: 'BarChart',
        data: ageModellist,
        domainFn: (data, index) => data.age,
        measureFn: (data, index) => data.number,
        colorFn: (data, index) => chart.ColorUtil.fromDartColor(
            Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0)),
      )
    ];

    this.ageSeries = ageseries;

    update();
    print(map);
  }

  void getBuyButtonClick(startDate, endDate) async {
    buyButtonClick = await methods.getBuyButtonClick(startDate, endDate);
    buyRate = await methods.getBuyedItems(startDate, endDate);

    var chartData = [
      ChartModel(
          number: buyButtonClick.length,
          lables: 'Click On Buy Button',
          color: Colors.orange),
      ChartModel(
        number: buyRate.length,
        lables: 'Sucessfully Buyed',
        color: Colors.redAccent,
      ),
      ChartModel(
        number: total,
        lables: 'Value of Total Transistion',
        color: Colors.redAccent,
      )
    ];

    final clickRate = [
      chart.Series<ChartModel, String>(
        id: 'BarChart',
        data: chartData,
        domainFn: (data, index) => data.lables,
        measureFn: (data, index) => data.number,
        colorFn: (data, index) => chart.ColorUtil.fromDartColor(
            Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0)),
      )
    ];

    this.clickRateSeries = clickRate;
    update();
    Future.delayed(Duration(seconds: 3)).then((value) {
      update();
    });
  }

  int get total {
    return buyRate.fold(0, (previousValue, element) {
      return int.parse(element.priceNumber);
    });
  }

  void pieData(startDate, endDate) async {
    numberOfUsers = await methods.getNumberOfUser(startDate, endDate);

    numberOfMales = await methods.getNumberOfMale(startDate, endDate);

    numberofFemales = await methods.getNumberOfFemale(startDate, endDate);

    var chartData = [
      ChartModel(
          number: numberOfUsers,
          lables: 'Number of Users',
          color: Colors.green),
      ChartModel(
        number: numberOfMales,
        lables: 'Number of Male',
        color: Colors.black,
      ),
      ChartModel(
          number: numberofFemales,
          lables: 'Number Of Female',
          color: Colors.blue)
    ];

    final series = [
      chart.Series<ChartModel, String>(
          id: 'BarChart',
          data: chartData,
          domainFn: (data, index) => data.lables,
          measureFn: (data, index) => data.number,
          colorFn: (data, index) => chart.ColorUtil.fromDartColor(data.color))
    ];
    this.series = series;
    isLoading = false;
    update();
  }

  static List<chart.Series<LinearSales, num>> lineChartSeries() {
    var salesData = [
      LinearSales(1, 3, Color(0xff3366cc)),
      LinearSales(2, 4, Color(0xff3366cc)),
      LinearSales(3, 6, Color(0xff3366cc)),
      LinearSales(4, 8, Color(0xff3366cc)),
      LinearSales(5, 9, Color(0xff3366cc)),
      LinearSales(6, 3, Color(0xff3366cc)),
    ];

    return [
      chart.Series<LinearSales, int>(
        id: 'linearChart',
        data: salesData,
        domainFn: (data, index) => data.year,
        measureFn: (data, index) => data.sales,
        colorFn: (datum, index) {
          return chart.ColorUtil.fromDartColor(datum.color);
        },
      )
    ];
  }
}
