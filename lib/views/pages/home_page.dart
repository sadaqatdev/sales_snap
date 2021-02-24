import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales_snap/controllers/home_controller.dart';
import 'package:sales_snap/utils/routes/routes.dart';
import 'package:sales_snap/views/pages/items_details_page.dart';
import 'package:sales_snap/views/widgets/appBar.dart';

class HomePage extends StatelessWidget {
  final Routes _routes = Routes();

  final HomeController controller = Get.put(HomeController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bodyStyle = Theme.of(context).textTheme.bodyText2;
    final lable = Theme.of(context).textTheme.headline1;
    return Scaffold(
      appBar: appBar(context, 'Sales Snap'),
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          height: Get.height,
          padding: EdgeInsets.only(left: 12, right: 12, top: 12),
          child: GetBuilder<HomeController>(builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Form(
                      key: formKey,
                      child: Expanded(
                        child: Container(
                          height: 44,
                          child: TextFormField(
                            controller: controller.textEditingController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Url is Empty';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Enter URL of Product',
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          side:
                              BorderSide(color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(22)),
                      height: 40,
                      color: Colors.green,
                      child: Text('Go'),
                      onPressed: () async {
                        if (formKey.currentState.validate()) {
                          controller.fetch();
                        }
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                controller.enable
                    ? getRecentSave(bodyStyle)
                    : productWidget(controller, lable, context),
                SizedBox(
                  height: 12,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Column productWidget(
      HomeController controller, TextStyle lable, BuildContext context) {
    return Column(
      children: [
        Image.network(img),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              controller.price ?? '',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Text(controller.title ?? '', style: lable),
        SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MaterialButton(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(22)),
              color: Colors.green,
              child: Text('Visit Site'),
              onPressed: () async {
                _routes.to(context, ItemDetailsPage());
              },
            ),
            SizedBox(
              width: 20,
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(22)),
              color: Colors.green,
              child: Text('Save'),
              onPressed: () async {
                // SystemAlertWindow.closeSystemWindow();
                //String path = await NativeScreenshot.takeScreenshot();
                //print(path.toString());
                print('-------save---------');
                controller.saveproduc();
              },
            )
          ],
        ),
      ],
    );
  }

  Widget getRecentSave(bodyStyle) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.81,
            crossAxisSpacing: 10,
            mainAxisSpacing: 5),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(img),
                SizedBox(
                  height: 6,
                ),
                Text(
                  'Lulolamenon',
                  style: bodyStyle,
                )
              ],
            ),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
