import 'dart:async';
import 'dart:io';

import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:sales_snap/controllers/saved_item_controller.dart';
import 'package:sales_snap/models/web_details.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:sales_snap/repositories/database_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

var img =
    'https://cdn.shopify.com/s/files/1/1083/6796/products/product-image-187878776_400x.jpg?v=1569388351';
String url =
    'https://www.lululemon.co.uk/en-gb/p/fast-and-free-short-sleeve/prod9450010.html?dwvar_prod9450010_color=42306';
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  // var taskId = task.taskId;
  print('---------------------');
  initNotifications();
  _showNotification();
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

FlutterLocalNotificationsPlugin fltrNotification;
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

class HomeController extends GetxController {
  TextEditingController textEditingController;

  String imageUrl = '';
  String title = '';
  String desc = '';
  String price = '';

  bool enable = true;

  List list = List<WebDetails>();

  final intRegex = RegExp(r'\s+(\d+)\s+', multiLine: false);
  final doubleRegex = RegExp(r'^[a-zA-Z0-9]+$');
  FlutterLocalNotificationsPlugin fltrNotification;

  SavedController _savedController = Get.put(SavedController());

  WebDetails savedProduct;
  DatabaseHelper _helper = DatabaseHelper();

  var descR = 'This is a freebie for everyone,but if u wanna invite me a beer';

  // FireStoreMethod _fireStoreMethod = FireStoreMethod();


  @override
  void onInit() {

    // initNotifications();

    // initPlatformState();

    BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);

    initList();

    textEditingController = TextEditingController();

    super.onInit();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }

  Future<void> fetch() async {
    String urlNew = textEditingController.text;
    final responce = await http.Client().get(Uri.parse(url));

    if (responce.statusCode == 200) {
      try {
        print('---------200--------');

        dom.Document document = parse(responce.body);

        print(document);
        enable = false;
        update();
        // print(document.querySelectorAll('[class*="-price]'));
      } catch (e) {
        print(e.toString());
      }
    } else {
      Get.showSnackbar(GetBar(
        message: responce.statusCode.toString(),
      ));
    }
  }

  void extract(dom.Document document) {
    int index = url.indexOf('.com');

    list.forEach((item) {
      if (url.substring(8, index) == item.webUrl) {
        print(document.getElementsByClassName('price-1SDQy price')[0].text);
        String title =
            document.querySelector('.pdp-title div[itemprop="name"]').text;
        String price =
            document.getElementsByClassName('price-1SDQy price')[0].text;

        print('-------------------');

        print(price.replaceAll(RegExp('[^0-9]'), ''));

        updatePage(price: price, title: title, desc: 'desc');

        int p = int.parse(price.replaceAll(RegExp('[^0-9]'), ''));

        savedProduct = WebDetails(
          title: title,
          price: price,
          desc: descR,
          imgUrl: img,
          priceNumber: p.toString(),
          webUrl: url.substring(8, index),
        );
      }
    });
  }

  saveproduc() {
    _helper.setWebDetails(savedProduct).then((i) {
      _savedController.getSavedList();
    });
  }

  initList() {
    list.add(WebDetails(
        title: '.pdp-title div[itemprop="name"]',
        webUrl: 'shop.lululemon',
        imgUrl: 'pictureContainer-36lBu',
        price: 'price-1SDQy price'));
    list.add(WebDetails(
        imgUrl: 'ShotView',
        price:
            'pdp-price pdp-price_type_normal pdp-price_color_orange pdp-price_size_xl',
        title: 'pdp-mod-product-badge-title',
        webUrl: 'daraz.pk'));

    list.add(WebDetails(
        imgUrl: 'e1usmzj05 css-1t6je5j e18nnme30',
        price:
            'pdp-price pdp-price_type_normal pdp-price_color_orange pdp-price_size_xl',
        title: 'css-j5fhoc ehm8gc85',
        webUrl: 'www.harrods.com'));
  }

  void updatePage({imageurl, title, desc, price}) {
    this.imageUrl = imageurl;
    this.title = title;
    this.desc = desc;
    this.price = price;
    savedProduct = savedProduct;
    enable = false;
    update();
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

  void getSavedList() async {
    list = await _helper.getWebDetails();
    update();
  }
}
