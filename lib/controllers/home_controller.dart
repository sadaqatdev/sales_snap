import 'dart:async';
import 'dart:io';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:html/dom.dart';

import 'package:html/parser.dart';
import 'package:sales_snap/controllers/saved_item_controller.dart';
import 'package:sales_snap/models/web_details.dart';
import 'package:http/http.dart' as http;
import 'package:sales_snap/repositories/database_helper.dart';
import 'package:sales_snap/repositories/firestore_methods.dart';
import 'package:sales_snap/utils/extract/extract.dart';

var img =
    'https://cdn.shopify.com/s/files/1/1083/6796/products/product-image-187878776_400x.jpg?v=1569388351';
String url =
    'https://shop.lululemon.com/p/mens-jackets-and-outerwear/Expeditionist-Anorak/_/prod10370103?color=0001';

void backgroundFetchHeadlessTask(HeadlessTask task) async {
  // var taskId = task.taskId;
  final controller = Get.put(HomeController());

  controller.comparePrice();

  // var timeout = task.timeout;
  // HomeController _controller = HomeController();
  // if (timeout) {
  //   BackgroundFetch.finish(taskId);
  //   return;
  // }

  // if (taskId == 'flutter_background_fetch') {
  //   BackgroundFetch.scheduleTask(TaskConfig(
  //       taskId: "com.transistorsoft.customtask",
  //       delay: 5000,
  //       periodic: false,
  //       forceAlarmManager: false,
  //       stopOnTerminate: false,
  //       enableHeadless: true));
  // }
  //BackgroundFetch.finish(taskId);
}

////////////CONTROLLER START/////////////////////////////////////////////////////////////
class HomeController extends GetxController {
  TextEditingController textEditingController;

  FlutterLocalNotificationsPlugin fltrNotification;

  SavedController _savedController = Get.put(SavedController());

  DatabaseHelper _helper = DatabaseHelper();

  FireStoreMethod _fireStoreMethod = FireStoreMethod();

  List<String> imageUrls = [];

  String title = '';

  String price = '';

  static String priceHtmlTag = '';

  bool enable = false;

  bool showProgress = false;

  List<WebDetails> list = [];

  List<WebDetails> saveList = [];

  var doubleRE = RegExp(r"-?(?:\d*\.)?\d+(?:[eE][+-]?\d+)?");

  @override
  void onInit() {
    initNotifications();

    initPlatformState();
    getSavedList();
    BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);

    textEditingController = TextEditingController();
    // textEditingController.text = url;
    super.onInit();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }

  void getSavedList() async {
    saveList = await _helper.getWebDetails();

    update();
  }

  void enableValue(bool val) {
    enable = val;

    update();
  }

  void showProgrss(val) {
    showProgress = val;
    update();
  }

  Future<void> fetch() async {
    enableValue(true);
    //showProgrss(true);
    try {
      final response = await http.get(Uri.parse(textEditingController.text));

      if (response.statusCode == 200) {
        Map<String, dynamic> priceMap = {};
        this.refresh();

        title = getTitle(response.body)[0];
        sleep(Duration(seconds: 1));
        priceMap = getPrice(response.body);
        sleep(Duration(seconds: 1));
        imageUrls = getImage(response.body);

        price = "${priceMap['currency']} ${priceMap['amount']}";

        showProgrss(false);
      } else {
        snakBar(response.statusCode);
        enableValue(false);
        showProgrss(false);
      }
    } catch (e) {
      snakBar(e);
      enableValue(false);
      showProgrss(false);
      update();
      print('----Error-----');
      print(e.toString());
    }
  }

  saveProduct() {
    if (title.isNotEmpty && price.isNotEmpty ||
        HomeController.priceHtmlTag.isNotEmpty ||
        textEditingController.text.isNotEmpty) {
      showProgrss(true);
      var p =
          doubleRE.allMatches(price).map((m) => double.parse(m[0])).toList();
      WebDetails savedProduct = WebDetails(
          title: title,
          imgUrl: imageUrls[0] ?? img,
          priceHtmlTag: HomeController.priceHtmlTag,
          priceNumber: p.elementAt(0).toString(),
          price: price,
          webUrl: textEditingController.text);

      _fireStoreMethod.saveItems(savedProduct).then((value) {
        _helper.setWebDetails(savedProduct).then((i) {
          _savedController.getSavedList();
          snakBar('Save Sucessfully');
          showProgrss(false);
        });
      });
    } else {
      snakBar('Product Details are Empty');
    }
  }

  deleteProduct(index) {
    _helper.delete(index).then((value) {
      print('----------delete');
      print(value);
      _savedController.getSavedList();
    });
  }

  void snakBar(s) {
    Get.showSnackbar(GetBar(
      message: s,
      duration: Duration(seconds: 3),
    ));
  }

  Future<void> comparePrice() async {
    List<WebDetails> _list = await _helper.getWebDetails();

    _list.forEach((element) async {
      final response = await http.Client().get(Uri.parse(element.webUrl));

      var newPricePareval;
      var oldParseValue;

      String oldPrice = element.priceNumber;

      if (response.statusCode == 200) {
        try {
          Document document = parse(response.body);

          String newPrice =
              document.querySelectorAll(element.priceHtmlTag)[0].toString();
          try {
            if (oldPrice.isNum) {
              oldParseValue = double.parse(oldPrice);
            } else {
              oldParseValue = doubleRE
                  .allMatches(oldPrice)
                  .map((m) => double.parse(m[0]))
                  .toList();
            }
          } catch (e) {
            snakBar(e);
          }

          try {
            if (newPrice.isNum) {
              newPricePareval = double.parse(newPrice);
            } else {
              newPricePareval = doubleRE
                  .allMatches(newPrice)
                  .map((m) => double.parse(m[0]))
                  .toList();
            }
            if (newPricePareval < oldParseValue) {
              _showNotification();
            }
          } catch (e) {
            snakBar(e);
          }
        } catch (e) {
          print('----Error-----');
          print(e.toString());
        }
      }
    });
  }

  void initNotifications() {
    var androidInitilize = AndroidInitializationSettings('ic_launcher');
    var iOSinitilize = IOSInitializationSettings();
    var initilizationsSettings =
        InitializationSettings(android: androidInitilize, iOS: iOSinitilize);
    fltrNotification = FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(
      initilizationsSettings,
    );
  }

  Future _showNotification() async {
    var androidDetails = AndroidNotificationDetails(
        "Channel ID", "Desi programmer", "This is my channel",
        importance: Importance.max);
    var iSODetails = IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iSODetails);

    await fltrNotification.show(
        0, "Task", "You created a Task", generalNotificationDetails,
        payload: "Task");
  }

  Future<void> initPlatformState() async {
    // Load persisted fetch events from SharedPreferences

    // Configure BackgroundFetch.
    try {
      int status = await BackgroundFetch.configure(
          BackgroundFetchConfig(
            minimumFetchInterval: 15,
            forceAlarmManager: false,
            stopOnTerminate: false,
            startOnBoot: true,
            enableHeadless: true,
            requiresBatteryNotLow: false,
            requiresCharging: false,
            requiresStorageNotLow: false,
            requiresDeviceIdle: false,
            requiredNetworkType: NetworkType.NONE,
          ),
          _onBackgroundFetch,
          _onBackgroundFetchTimeout);
      print('=============init cinfig sucess======');

      // Schedule a "one-shot" custom-task in 10000ms.
      // These are fairly reliable on Android (particularly with forceAlarmManager) but not iOS,
      // where device must be powered (and delay will be throttled by the OS).
      BackgroundFetch.scheduleTask(TaskConfig(
          taskId: "com.transistorsoft.customtask",
          delay: 10000,
          periodic: false,
          forceAlarmManager: true,
          stopOnTerminate: false,
          enableHeadless: true));
    } catch (e) {}
  }

  void _onBackgroundFetch(String taskId) async {
    print("111111111111111[BackgroundFetch] Event received: $taskId");
    _showNotification();
    if (taskId == "flutter_background_fetch") {
      _showNotification();
      print('-----------background fetch=-------');
      // Schedule a one-shot task when fetch event received (for testing).
      /*
      BackgroundFetch.scheduleTask(TaskConfig(
          taskId: "com.transistorsoft.customtask",
          delay: 5000,
          periodic: false,
          forceAlarmManager: true,
          stopOnTerminate: false,
          enableHeadless: true,
          requiresNetworkConnectivity: true,
          requiresCharging: true
      ));
       */
    }
    // IMPORTANT:  You must signal completion of your fetch task or the OS can punish your app
    // for taking too long in the background.
    BackgroundFetch.finish(taskId);
  }

  /// This event fires shortly before your task is about to timeout.  You must finish any outstanding work and call BackgroundFetch.finish(taskId).
  void _onBackgroundFetchTimeout(String taskId) {
    print("2222222222222[BackgroundFetch] TIMEOUT: $taskId");
    BackgroundFetch.finish(taskId);
  }

  void _onClickEnable(enabled) {
    if (enabled) {
      BackgroundFetch.start().then((int status) {
        print('bbbbb[BackgroundFetch] start success: $status');
      }).catchError((e) {
        print('bbbbb[BackgroundFetch] start FAILURE: $e');
      });
    } else {
      BackgroundFetch.stop().then((int status) {
        print('bbbbb[BackgroundFetch] stop success: $status');
      });
    }
  }

  // saveToFirestore(WebDetails webDetails) {
  //   _fireStoreMethod.saveItems(webDetails).then((e) {});
  // }

}

// if (url.substring(8, index) == item.webUrl) {
//   print(document.getElementsByClassName('price-1SDQy price')[0].text);
//   String title =
//       document.querySelector('.pdp-title div[itemprop="name"]').text;
//   String price =
//       document.getElementsByClassName('price-1SDQy price')[0].text;

//   print('-------------------');

//   print(price.replaceAll(RegExp('[^0-9]'), ''));

//   updatePage(price: price, title: title, desc: 'desc');

//   int p = int.parse(price.replaceAll(RegExp('[^0-9]'), ''));

//   savedProduct = WebDetails(
//     title: title,
//     priceHtmlTag: price,
//     desc: descR,
//     imgUrl: img,
//     priceNumber: p.toString(),
//     webUrl: url.substring(8, index),
//   );
// // }
//         Document document = parse(response.body);

//         String newPrice =
//             document.querySelectorAll('*[class*="price"]')[0].text;

//         print('-----------new price------------------');
//         print(newPrice);
//         int index = newPrice.indexOf('class="');
//         int lasindex = newPrice.indexOf('\">');
//         String s = newPrice.substring(index, lasindex);
//         print(document.getElementsByClassName(s));
