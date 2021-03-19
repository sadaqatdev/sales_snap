import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap_dashboard/controller/hom_controller.dart';
import 'package:sales_snap_dashboard/servises/firestore_methods.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomePage extends StatelessWidget {
  final homeController = Get.put(HomeController());

  final firestre = FirestoreMethods();

  @override
  Widget build(BuildContext context) {
    final lableStyel = TextStyle(fontSize: 20);
    final descStyle = TextStyle(fontSize: 16);
    return GetBuilder<HomeController>(builder: (controller) {
      return controller.isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              width: Get.width,
              height: Get.height,
              margin: EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Number of Users', style: lableStyel),
                      SizedBox(
                        width: 16,
                      ),
                      Text(controller.numberOfUsers.toString(),
                          style: descStyle),
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Number of Males', style: lableStyel),
                      SizedBox(
                        width: 16,
                      ),
                      Text(controller.numberOfMales.toString(),
                          style: descStyle),
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Number of Female', style: lableStyel),
                      SizedBox(
                        width: 16,
                      ),
                      Text(controller.numberofFemales.toString(),
                          style: descStyle),
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text('Click Through Rate ', style: lableStyel),
                  //     SizedBox(
                  //       width: 16,
                  //     ),
                  //     Text('12', style: descStyle),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: 18,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Sum of Sucessfull Purchases', style: lableStyel),
                      SizedBox(
                        width: 16,
                      ),
                      Text('12', style: descStyle),
                    ],
                  ),
                  // SizedBox(
                  //   height: 18,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text('Total Purchases Amount', style: lableStyel),
                  //     SizedBox(
                  //       width: 16,
                  //     ),
                  //     Text('12', style: descStyle),
                  //   ],
                  // ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: controller.ageModellist.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 150,
                              height: 150,
                              child: Row(
                                children: [
                                  Text(
                                    'Age:  ',
                                    style: lableStyel,
                                  ),
                                  Text(controller.ageModellist[index].age,
                                      style: descStyle),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    ' Users ',
                                    style: lableStyel,
                                  ),
                                  Text(controller.ageModellist[index].number,
                                      style: descStyle)
                                ],
                              ),
                            );
                          })),
                ],
              ),
            );
    });
  }
}

//  Container(
//                         width: Get.width / 3,
//                         height: Get.height / 2,
//                         margin: EdgeInsets.all(22),
//                         child: Container(
//                           child: charts.BarChart(
//                             controller.series,
//                             animate: true,
//                           ),
//                         )),
