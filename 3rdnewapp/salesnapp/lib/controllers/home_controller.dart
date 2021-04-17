import 'dart:async';
import 'dart:io';

import 'package:background_fetch/background_fetch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sales_snap/controllers/saved_item_controller.dart';
import 'package:sales_snap/models/notification_model.dart';
import 'package:sales_snap/models/save_product_model.dart';
import 'package:http/http.dart' as http;

import 'package:sales_snap/repositories/firestore_methods.dart';
import 'package:sales_snap/utils/extract/extract.dart';
import 'package:sales_snap/views/pages/notifications_page.dart';
import 'package:sales_snap/views/pages/save_page.dart';

FlutterLocalNotificationsPlugin fltrNotification;
var doubleRE = RegExp(r"-?(?:\d*\.)?\d+(?:[eE][+-]?\d+)?");
Extractor extractor = Extractor();

////////////CONTROLLER START/////////////////////////////////////////////////////////////
class HomeController extends GetxController {
  ///get
  ///
  static HomeController get to => Get.find();
// HTTP Request (OSRequestRegisterUser) must contain app_id parameter
// Request <OSRequestRegisterUser: 0x60000186f450> fail result error Error Domain=OneSignalError Code=-1 "(null)" UserInfo={error=HTTP Request (OSRequestRegisterUser) must contain app_id parameter}
// ERROR: Encountered error during push registration with OneSignal: Error Domain=OneSignalError Code=-1 "(null)" UserInfo={error=HTTP Request (OSRequestRegisterUser) must contain app_id parameter}
// ERROR: Encountered error during email registration with OneSignal: (null)

  TextEditingController textEditingController;

  SavedController _savedController = Get.put(SavedController());

  FireStoreMethod _fireStoreMethod = FireStoreMethod();

  FirebaseAuth _auth = FirebaseAuth.instance;

  String imageUrls = '';

  String title = '';

  String price = '';

  static String priceHtmlTag = '';

  bool enable = false;

  bool showProgress = false;

  List<SavedProductModel> list = [];

  List<SavedProductModel> saveList = [];

  var doubleRE = RegExp(r"-?(?:\d*\.)?\d+(?:[eE][+-]?\d+)?");

  GetStorage storage;

  double numb;
  double iosPadding;
  double recentSave;
  String onesignalUserId;
  bool notifcationEnabled = false;
  @override
  void onInit() {
    storage = GetStorage();

    String notifcations = storage.read('notificationEnable');

    notifcationEnabled = notifcations?.contains('yes') ?? false ? true : false;
    // if (false) {
    //   initBackgroudTask();

    // }

    initNotifications();

    textEditingController = TextEditingController();
    initOnSignal();
    if (Platform.isIOS) {
      numb = 6;
      iosPadding = 31;
      recentSave = 200;
    } else {
      numb = 6;
      iosPadding = 0;
      recentSave = 70;
    }
    super.onInit();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
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
    showProgrss(true);
    title = "";
    imageUrls = '';
    Map<String, dynamic> priceMap = {};
    try {
      final response = await http.Client().get(textEditingController.text);

      if (response.statusCode == 200) {
        if (textEditingController.text.contains('amazon')) {
          extractor.getAmazonTitle(response.body, (List<String> titles) {
            titles.forEach((elementt) {
              if (elementt.isNotEmpty) title = elementt.trim();
            });
          });
           
            extractor.getAmazonImages(response.body, (List<String> images) {
              images.forEach((imaget) {
                if (imaget.isNotEmpty) imageUrls = imaget.trim();
              });
            });
         

          extractor.getamazonPrice(response.body,
              (List<String> prices, priceElements) {
            print("prices list .... ${prices.toString()}");

            prices.forEach((_price) {
              if (_price.isNotEmpty) {
                price = _price.trim();
              }
            });

            //HomeController.priceHtmlTag = priceElements[0].keys.first;
          });
        } else {
          extractor.getTitles(response.body, (List<String> titles) {
            title = titles[0];

            print("printing title at lin 135 $title");
          });

          extractor.getImages(response.body, (List<String> images) {
            imageUrls = images[0];
            print("printing images at lin 141 $images");
          }, textEditingController.text);

          extractor.getPrices(response.body,
              (List<String> _prices, List<Map<String, dynamic>> priceElements) {
            String price = _prices[0].trim();
            if (price.isEmpty) {
              price = _prices[1].trim();
            }
            HomeController.priceHtmlTag = priceElements[0].keys.first;
            int length = price.length;
            String currency = extractor.getCurrency(response.body);
            if (length > 10) {
              priceMap = {
                "currency": currency,
                "amount": price.substring(0, 10)
              };
            } else {
              priceMap = {
                "currency": currency,
                "amount": price,
              };
            }
            print("printing prices at lin 143 $price");
          });
          price = "${priceMap['currency']} ${priceMap['amount']}";
        }

        showProgress = false;

        update();
      } else {
        snakBar('Invalid Url or Url Cannot fetch Data Try Again');
        enableValue(false);
        showProgrss(false);
      }
    } catch (e) {
      snakBar('Invalid Url Try Again');
      enableValue(false);
      showProgrss(false);

      print('----Error-----');
      print(e.toString());
    }
  }

  saveProduct() async {
    if (true) {
      showProgrss(true);
      print('--------price htl tag------');
      print(HomeController.priceHtmlTag);
      OSPermissionSubscriptionState status =
          await OneSignal.shared.getPermissionSubscriptionState();

      onesignalUserId = status.subscriptionStatus.userId;

      String uid = _auth.currentUser.uid;

      var p =
          doubleRE.allMatches(price).map((m) => double.parse(m[0])).toList();

      SavedProductModel savedProduct = SavedProductModel(
          title: title,
          imgUrl: imageUrls,
          priceHtmlTag: HomeController.priceHtmlTag,
          priceNumber: p.toString(),
          price: price,
          uid: uid,
          webUrl: textEditingController.text,
          timestamp: Timestamp.now(),
          msgToken: onesignalUserId);

      _fireStoreMethod.saveItems(savedProduct).then((value) {
        if (value) {
          _savedController.getSavedList();

          //snakBar('Save Sucessfully');

          showProgrss(false);
          textEditingController.clear();
          Future.delayed(Duration(seconds: 0)).then((value) {
            Get.off(SavePage());
          });
        } else {
          snakBar('You have already saved the item');
          textEditingController.clear();
          showProgrss(false);
          Future.delayed(Duration(seconds: 2)).then((value) {
            Get.back();
          });
        }

        // _helper.setWebDetails(savedProduct).then((i) {

        // });
      });
    } else {
      snakBar('Product Details are Empty');
    }
  }

  Future<bool> deleteProduct(index) async {
    _fireStoreMethod.deleteItem(index).then((value) {
      _savedController.getSavedList();
    });
    return true;
  }

  Future<bool> deleteBuyProduc(index) async {
    await _fireStoreMethod.deleteBuyItem(index).then((value) {
      _savedController.getBuyList();
    });
    return true;
  }

  void snakBar(s) {
    Get.showSnackbar(GetBar(
      message: s.toString(),
      duration: Duration(seconds: 3),
    ));
  }

  Future<void> initBackgroudTask() async {
    // Load persisted fetch events from SharedPreferences

    // Configure BackgroundFetch.
    try {
      await BackgroundFetch.configure(
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
            requiredNetworkType: NetworkType.ANY,
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
      BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
    } catch (e) {
      print(e.toString());
    }
  }

  void _onBackgroundFetch(String taskId) async {
    print("_onBackgroundFetch(String taskId): $taskId");

    if (taskId == "flutter_background_fetch") {
      comparePrice();

      print('-----------Compare Price is Called--- -------');
    }
    // IMPORTANT:  You must signal completion of your fetch task or the OS can punish your app
    // for taking too long in the background.
    BackgroundFetch.finish(taskId);
  }

  /// This event fires shortly before your task is about to timeout.  You must finish any outstanding work and call BackgroundFetch.finish(taskId).
  void _onBackgroundFetchTimeout(String taskId) {
    print("_onBackgroundFetchTimeout(String taskId): $taskId");
    BackgroundFetch.finish(taskId);
  }

  void initOnSignal() async {
    await OneSignal.shared.init('4cd671ff-1756-4e7a-8f03-f90a7bace30f');

    OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    OneSignal.shared.inFocusDisplayType();

    OSPermissionSubscriptionState status =
        await OneSignal.shared.getPermissionSubscriptionState();

    onesignalUserId = status.subscriptionStatus.userId;

    storage.write('id', onesignalUserId);
  }
}

Future onDidReceiveLocalNotification(
    int id, String title, String body, String payload) async {
  // display a dialog with the notification details, tap ok to go to another page
  Get.defaultDialog(
      title: title,
      onConfirm: () {
        Get.to(NotificationPage());
      });
}

void backgroundFetchHeadlessTask(HeadlessTask task) async {}

Future<void> initNotifications() async {
  var androidInitilize = AndroidInitializationSettings('ic_launcher');
  var iOSinitilize = IOSInitializationSettings(
    defaultPresentAlert: true,
    requestAlertPermission: true,
    defaultPresentSound: true,
    requestSoundPermission: true,
    requestBadgePermission: true,
    onDidReceiveLocalNotification: onDidReceiveLocalNotification,
  );

  var initilizationsSettings =
      InitializationSettings(android: androidInitilize, iOS: iOSinitilize);
  fltrNotification = FlutterLocalNotificationsPlugin();
  fltrNotification.initialize(
    initilizationsSettings,
  );
  await fltrNotification
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
}

Future showNotification(String title, String desc) async {
  var androidDetails = AndroidNotificationDetails(
      "Channel ID", "programmer", "This is my channel",
      importance: Importance.max);
  var iSODetails = IOSNotificationDetails();
  var generalNotificationDetails =
      NotificationDetails(android: androidDetails, iOS: iSODetails);

  await fltrNotification.show(0, title, desc, generalNotificationDetails,
      payload: "Task");
}

/* compare price in background */
Future<void> comparePrice() async {
  final storage = GetStorage();

  String uid = storage.read('uid');

  print('-------in Compare Price---------------');
  /* compare price in background */

  List<SavedProductModel> _list = await getSavedItemsBg(uid);

  double newPricedoubleVal;
  double oldPricedoubleVal;
  List newPricePareval;
  List oldParseValue;

  FireStoreMethod method = FireStoreMethod();

  String concatenewPriceVal;
  String concateoldPriceVal;

  _list.forEach((element) async {
    final response = await http.Client().get(Uri.parse(element.webUrl));

    String oldPrice = element.priceNumber;

    if (response.statusCode == 200) {
      try {
        /*  extrcat dom */

        String newPrice;
        print('Quer selector all');

        extractor.getPrices(response.body,
            (List<String> _prices, List<Map<String, dynamic>> priceElements) {
          String price = _prices[0].trim();
          if (price.isEmpty) {
            price = _prices[1].trim();
          }

          int length = price.length;
          if (length > 10) {
            price = price.substring(0, 10);
          }
          print("printing prices at lin 143 $price");
          newPrice = price;
        });

        print('---------price----');
        print('new price value----- $newPrice');
        print('---------Old Price----');
        print(element.price);
        /*  convert price to double*/
        try {
          if (oldPrice.isNum) {
            print('---in old num $oldPrice');
            oldPricedoubleVal = double.parse(oldPrice).toDouble();
          } else {
            /*  extrcat and convert old price using regx*/
            oldParseValue = doubleRE
                .allMatches(oldPrice)
                .map((m) => double.parse(m[0]))
                .toList();

            concateoldPriceVal = oldParseValue.join('');

            oldPricedoubleVal =
                double.parse(concateoldPriceVal.toString()).toDouble();
          }
        } catch (e) {
          print('Old Price Error----ERrror occur in background');
          print(e.toString());
        }

        try {
          if (newPrice.isNum) {
            newPricedoubleVal = double.parse(newPrice).toDouble();
            print(newPricedoubleVal);
            print('---in new num $newPricePareval');
          } else {
            /*  extrcat and convert old price using regx*/
            print('-------------- regx ');
            newPricePareval = doubleRE
                .allMatches(newPrice)
                .map((m) => double.parse(m[0]))
                .toList();

            concatenewPriceVal = newPricePareval.join('');
            concatenewPriceVal = newPricePareval.join('');

            newPricedoubleVal =
                double.parse(concatenewPriceVal.toString()).toDouble();
          }
        } catch (e) {
          print('2---ERrror occur in background');
          print(e.toString());
        }
        /*  compare price and show notifcatinon*/
        if (newPricedoubleVal < oldPricedoubleVal) {
          method.setUserNotification(
              data: NotificationModel(
                avatarUrl: element.imgUrl,
                cuponCode: 'No Coupon',
                desc: 'The Product You Saved, Now Its Price is Down',
                price: oldPricedoubleVal.toString(),
                timestamp: Timestamp.now(),
                title: 'Hey ',
                validDate: '------',
                docId: element.id,
                productTitle: element.title,
                priceHtmlTag: element.priceHtmlTag,
                newPrice: newPricedoubleVal.toString(),
                webUrl: element.webUrl,
              ),
              uid: uid);

          showNotification(
              'Hey, Buy Now', 'The Product You Saveed, Now Its Price is Down');
        } else {
          print('------not-----');
        }
      } catch (e) {
        print('----Error-----');
        print(e.toString());
      }
    }
  });
}

void onClickEnable(enabled) {
  if (enabled) {
    BackgroundFetch.start().then((int status) {
      print('Background Fetchn is  start success: $status');
    }).catchError((e) {
      print('Background Fetchn  [BackgroundFetch] start FAILURE: $e');
    });
  } else {
    BackgroundFetch.stop().then((int status) {
      print('Background Fetchn  [BackgroundFetch] stop success: $status');
    });
  }
}

Future<List<SavedProductModel>> getSavedItemsBg(uid) async {
  print('--------uid---------');
  print(uid);
  List<SavedProductModel> tempList = [];

  final _firestore = FirebaseFirestore.instance;

  CollectionReference _collection = _firestore.collection('user_products');

  QuerySnapshot _snap =
      await _collection.doc(uid).collection('saved_products').get();

  if (_snap?.docs?.isNotEmpty ?? false)
    _snap.docs.forEach((qSnap) {
      if (qSnap.exists)
        tempList.add(SavedProductModel.fromMap(qSnap.data(), qSnap.id));
    });

  return tempList;
}