import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap_dashboard/controller/hom_controller.dart';
import 'package:sales_snap_dashboard/servises/firestore_methods.dart';
import 'package:charts_flutter/flutter.dart' as chart;
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

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
                    children: [
                      Container(
                        width: 400,
                        height: 400,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 18,
                                ),
                                Text(
                                  'Click on Buy Button ${controller.buyButtonClick.length}',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                SizedBox(
                                  height: 18,
                                ),
                                Text(
                                    'SucessFully Buyed ${controller.buyRate.length}',
                                    style:
                                        Theme.of(context).textTheme.headline5),
                                SizedBox(
                                  height: 18,
                                ),
                                Text(
                                    'Total Transactions \$ ${controller.total}',
                                    style:
                                        Theme.of(context).textTheme.headline5),
                                SizedBox(
                                  height: 18,
                                ),
                                Text(
                                    'Number of Downloads ${controller.numberOfUsers}',
                                    style:
                                        Theme.of(context).textTheme.headline5),
                                SizedBox(
                                  height: 18,
                                ),
                                Text(
                                    'Number of Female ${controller.numberofFemales}',
                                    style:
                                        Theme.of(context).textTheme.headline5),
                                SizedBox(
                                  height: 18,
                                ),
                                Text(
                                    'Numbers of Male ${controller.numberOfMales}',
                                    style:
                                        Theme.of(context).textTheme.headline5),
                                SizedBox(
                                  height: 18,
                                ),
                                // Container(
                                //   width: 400,
                                //   height: 400,
                                //   child: chart.BarChart(
                                //     controller.clickRateSeries,
                                //     animate: false,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 400,
                            height: 400,
                            child: chart.BarChart(
                              controller.series,
                              animate: false,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 400,
                        height: 400,
                        //
                        child: SfDateRangePicker(
                          onSelectionChanged: (val) {
                            controller.onSelectionChanged(val);
                            print('-----end------');
                            print(val.value.endDate);
                            print('-----Start------');
                            print(val.value.startDate);
                          },
                          selectionMode: DateRangePickerSelectionMode.range,
                          endRangeSelectionColor: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        height: 400,
                        width: 400,
                        child: chart.BarChart(
                          controller.ageSeries,
                          animate: false,
                        ),
                      ),
                    ],
                  ),
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
// Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text('Number of Users', style: lableStyel),
//                       SizedBox(
//                         width: 16,
//                       ),
//                       Text(controller.numberOfUsers.toString(),
//                           style: descStyle),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 18,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text('Number of Males', style: lableStyel),
//                       SizedBox(
//                         width: 16,
//                       ),
//                       Text(controller.numberOfMales.toString(),
//                           style: descStyle),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 18,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text('Number of Female', style: lableStyel),
//                       SizedBox(
//                         width: 16,
//                       ),
//                       Text(controller.numberofFemales.toString(),
//                           style: descStyle),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 18,
//                   ),
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.start,
//                   //   children: [
//                   //     Text('Click Through Rate ', style: lableStyel),
//                   //     SizedBox(
//                   //       width: 16,
//                   //     ),
//                   //     Text('12', style: descStyle),
//                   //   ],
//                   // ),
//                   // SizedBox(
//                   //   height: 18,
//                   // ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text('Sum of Sucessfull Purchases', style: lableStyel),
//                       SizedBox(
//                         width: 16,
//                       ),
//                       Text('12', style: descStyle),
//                     ],
//                   ),
//                   // SizedBox(
//                   //   height: 18,
//                   // ),
//                   // Row(
//                   //   mainAxisAlignment: MainAxisAlignment.start,
//                   //   children: [
//                   //     Text('Total Purchases Amount', style: lableStyel),
//                   //     SizedBox(
//                   //       width: 16,
//                   //     ),
//                   //     Text('12', style: descStyle),
//                   //   ],
//                   // ),
//                   Expanded(
//                       child: ListView.builder(
//                           itemCount: controller.ageModellist.length,
//                           itemBuilder: (context, index) {
//                             return Container(
//                               width: 150,
//                               height: 150,
//                               child: Row(
//                                 children: [
//                                   Text(
//                                     'Age:  ',
//                                     style: lableStyel,
//                                   ),
//                                   Text(controller.ageModellist[index].age,
//                                       style: descStyle),
//                                   SizedBox(
//                                     width: 8,
//                                   ),
//                                   Text(
//                                     ' Users ',
//                                     style: lableStyel,
//                                   ),
//                                   Text(controller.ageModellist[index].number,
//                                       style: descStyle)
//                                 ],
//                               ),
//                             );
//                           })),
//                         )),
