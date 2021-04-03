import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:sales_snap/controllers/home_controller.dart';
import 'package:sales_snap/views/widgets/appBar.dart';
import 'package:sales_snap/views/widgets/custom_button.dart';
import 'package:sales_snap/views/widgets/snakbar.dart';

class ProductPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final lable = Theme.of(context).textTheme.headline1;

    return Scaffold(
      body: GetBuilder<HomeController>(
          init: HomeController(),
          builder: (homecontroller) {
            return Stack(
              children: [
                Scaffold(
                  appBar: appBar(
                    context: context,
                    title: 'Salesnapp',
                    height: 130,
                    action: SizedBox(),
                  ),
                  body: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 12, right: 12, top: 12, bottom: 20),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 60,
                              ),
                              homecontroller.showProgress
                                  ? progressBar()
                                  : productWidget(
                                      homecontroller, lable, context),
                              SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  floatingActionButton: Container(
                          height: 50,
                          width: 319,
                          margin: EdgeInsets.only(right: 31),
                          child: CustomButton(
                              lable: 'Save',
                              onPress: () {
                                homecontroller.saveProduct();
                              },
                              color: Colors.black,
                              radius: 10),
                        )
                       
                ),
                // Positioned(
                //   top: 140,
                //   left: 12,
                //   right: 12,
                //   child: searchField(homecontroller, context, forteenFont),
                // ),
              ],
            );
          }),
    );
  }

  Widget searchField(HomeController homecontroller, BuildContext context,
      TextStyle forteenFont) {
    return Form(
      key: formKey,
      child: Container(
        height: 90,
        width: Get.width,
        margin: EdgeInsets.only(left: 6, right: 6),
        padding: EdgeInsets.only(top: 22, bottom: 22, left: 20, right: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1,
                spreadRadius: 1,
              )
            ],
            borderRadius: BorderRadius.circular(25)),
        child: Center(
          child: TextFormField(
            controller: homecontroller.textEditingController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Url is Empty';
              }
              return null;
            },
            decoration: InputDecoration(
              fillColor: Color(0xffF6F7F8),
              prefixIcon: Icon(
                Icons.search,
                size: 24,
              ),
              suffixIcon: buildMaterialButton(context, forteenFont),
              hintText: 'Paste Link',
              hintStyle: forteenFont.copyWith(color: Colors.black),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              border: InputBorder.none,
              filled: true,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMaterialButton(BuildContext context, TextStyle forteenFont) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        height: 35,
        color: Colors.black,
        child: Text(
          'Search',
          style: forteenFont,
        ),
        onPressed: () async {
          FocusScope.of(context).unfocus();
          if (formKey.currentState.validate()) {
            HomeController.to.fetch();
          }
        },
      ),
    );
  }

  Widget productWidget(
      HomeController homecontroller, TextStyle lable, BuildContext context) {
    return Stack(
      children: [
        Card(
          
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: EdgeInsets.only(top: 100, left: 16, right: 20, bottom: 100),
          child: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Price'),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      homecontroller.price.toString(),
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
                Text(homecontroller.title.trim(),
                    style: lable.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        height: 1.5)),
                SizedBox(
                  height: homecontroller.title.length.toDouble() * 3,
                )
              ],
            ),
          ),
        ), 
        Positioned(
          left: (Get.width / 2) - 120,
          child: Container(
       
            height: 198,
            width: 223,
            child: Card(
             
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60)),
                child: OctoImage(
                  image: NetworkImage(homecontroller.imageUrls),
                  placeholderBuilder: OctoPlaceholder.blurHash(
                    'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                  ),
                  errorBuilder: OctoError.icon(color: Colors.red),
                  fit: BoxFit.cover,
                )),
          ),
        )
      ],
    );
  }
}
