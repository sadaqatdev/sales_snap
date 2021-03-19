import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap_dashboard/models/age_model.dart';
import 'package:sales_snap_dashboard/models/chart_model.dart';
import 'package:sales_snap_dashboard/servises/firestore_methods.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomeController extends GetxController {
  int numberOfUsers;
  int numberOfMales;
  int numberofFemales;
  List<String> ages = [];
  List<AgeModel> ageModellist = [];
  List<charts.Series<ChartModel, String>> series;
  FirestoreMethods methods = FirestoreMethods();
  bool isLoading = true;
  onInit() {
    getNumberOfUsers();
    getAges();
    super.onInit();
  }

  void getAges() async {
    ages = await methods.getAges();
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
        .map((e) => AgeModel(age: e.key.toString(), number: e.value.toString()))
        .toList();
    isLoading = false;
    update();
    print(map);
  }

  void getNumberOfUsers() async {
    numberOfUsers = await methods.getNumberOfUser();
    numberofFemales = await methods.getNumberOfFemale();
    numberOfMales = await methods.getNumberOfMale();
    update();
  }

  void pieData() async {
    numberOfUsers = await methods.getNumberOfUser();

    numberOfMales = await methods.getNumberOfMale();

    numberofFemales = await methods.getNumberOfFemale();

    var chartData = [
      ChartModel(
          number: numberOfUsers,
          lables: 'Number of Users',
          color: Colors.amber),
      ChartModel(
          number: numberOfMales,
          lables: 'Number of Male',
          color: Colors.amberAccent),
      ChartModel(
          number: numberofFemales,
          lables: 'Number Of Female',
          color: Colors.blue)
    ];

    final series = [
      charts.Series<ChartModel, String>(
          id: 'BarChart',
          data: chartData,
          domainFn: (data, index) => data.lables,
          measureFn: (data, index) => data.number,
          colorFn: (data, index) => charts.ColorUtil.fromDartColor(data.color))
    ];
    this.series = series;
    isLoading = false;
    update();
  }

  void ageVariations() {
    var elements = [
      "a",
      "b",
      "c",
      "d",
      "e",
      "a",
      "b",
      "c",
      "f",
      "g",
      "h",
      "h",
      "h",
      "e"
    ];
    var map = Map();

    elements.forEach((element) {
      if (!map.containsKey(element)) {
        map[element] = 1;
      } else {
        map[element] += 1;
      }
    });

    print(map);
  }
}
