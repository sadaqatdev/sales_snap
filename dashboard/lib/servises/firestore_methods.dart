import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:sales_snap_dashboard/models/buy_button_click.dart';
import 'package:sales_snap_dashboard/models/buy_model.dart';
import 'package:sales_snap_dashboard/models/m_user.dart';
import 'package:sales_snap_dashboard/models/notification_model.dart';
import 'package:sales_snap_dashboard/models/save_list_model.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference _collection;
  User _currentUser;
  FirestoreMethods() {
    _currentUser = _auth.currentUser;
    _collection = _firestore.collection('user_products');
  }
  Future<List<MUser>> getMuser() async {
    List<MUser> _list = [];
    CollectionReference _collection = _firestore.collection('user');
    QuerySnapshot _snap = await _collection.get();
  
    _snap.docs.forEach((element) {
      _list.add(MUser.fromMap(element.data(), element));
    });

    return _list;
  }

  Future<List<SaveListModel>> getUserSavedItems(uid) async {
    List<SaveListModel> tempList = [];

    QuerySnapshot _snap =
        await _collection.doc(uid).collection('saved_products').get();

    if (_snap?.docs?.isNotEmpty ?? false)
      _snap.docs.forEach((qSnap) {
        if (qSnap.exists) tempList.add(SaveListModel.fromMap(qSnap.data()));
      });

    return tempList;
  }

  Future<List<BuyModel>> getUserBuyItems(uid) async {
    List<BuyModel> tempList = [];

    QuerySnapshot _snap =
        await _collection.doc(uid).collection('buy_products').get();

    if (_snap?.docs?.isNotEmpty ?? false)
      _snap.docs.forEach((qSnap) {
        if (qSnap.exists)
          tempList.add(BuyModel.fromMap(qSnap.data(), qSnap.id));
      });

    return tempList;
  }

  Future<List<NotificationModel>> getNotifications() async {
    List<NotificationModel> tempList = [];
    QuerySnapshot _snap = await _firestore.collection('notifications').get();
    if (_snap?.docs?.isNotEmpty ?? false)
      _snap.docs.forEach((qSnap) {
        if (qSnap.exists) tempList.add(NotificationModel.fromMap(qSnap.data()));
      });

    return tempList;
  }

  Future<void> setNotifications(NotificationModel data) async {
    await _firestore.collection('notifications').doc().set(data.toMap());
  }

  Future<void> setUserNotification(
      {NotificationModel data, List<String> uidList}) async {
    uidList.forEach((element) {
      Future.delayed(Duration(seconds: 2)).then((value) async {
        await _firestore
            .collection('user_notification')
            .doc(element)
            .collection(element)
            .doc()
            .set(data.toMap());
      });
    });
  }

  Future<List<BuyButtonClick>> getBuyButtonClick(startDate, endDate) async {
    List<BuyButtonClick> tempList = [];

//  .where('startDate', isLessThanOrEqualTo: dateTimePlusMaximumEventInterval)
//   .where('startDate', isGreaterThanOrEqualTo: dateTimeMinusMaximumEvntInterval)
    QuerySnapshot docSanap = await _firestore
        .collection('buyButtonClick')
        .where('timestamp', isLessThanOrEqualTo: endDate)
        .where('timestamp', isGreaterThanOrEqualTo: startDate)
        .get();

    docSanap.docs.forEach((element) {
      tempList.add(BuyButtonClick.fromMap(element.data()));
    });
    return tempList;
  }

  Future<List<BuyButtonClick>> getBuyRate() async {
    List<BuyButtonClick> tempList = [];

    QuerySnapshot docSanap =
        await _firestore.collection('buyButtonClick').get();
    docSanap.docs.forEach((element) {
      tempList.add(BuyButtonClick.fromMap(element.data()));
    });
    return tempList;
  }

  Future<List<BuyModel>> getBuyedItems(startDate, endDate) async {
    List<BuyModel> _list = [];
    QuerySnapshot qsnap = await _firestore.collection('user').get();

    qsnap.docs.forEach((element) async {
      QuerySnapshot querySnapshot = await _firestore
          .collection('user_products')
          .doc(element.id)
          .collection('buy_products')
          .where('timestamp', isLessThanOrEqualTo: endDate)
          .where('timestamp', isGreaterThanOrEqualTo: startDate)
          .get();

      querySnapshot.docs.forEach((element) async {
        _list.add(BuyModel.fromMap(element.data(), element.id));
      });
    });
    print('-------------lenght');
    print(_list.length);
    return _list;
  }

  Future<List<SaveListModel>> getSavedItems() async {
    List<SaveListModel> _list = [];
    QuerySnapshot qsnap = await _firestore.collection('user').get();

    qsnap.docs.forEach((element) async {
      QuerySnapshot querySnapshot = await _firestore
          .collection('user_products')
          .doc(element.id)
          .collection('saved_products')
          .get();

      querySnapshot.docs.forEach((element) {
        _list.add(SaveListModel.fromMap(element.data()));
      });
    });

    return _list;
  }

  Future<int> getNumberOfUser(startDate, endDate) async {
    List tempList = [];
    QuerySnapshot snapshot = await _firestore
        .collection('user')
        .where('createdDate', isLessThanOrEqualTo: endDate)
        .where('createdDate', isGreaterThanOrEqualTo: startDate)
        .get();
    snapshot.docs.forEach((element) {
      tempList.add(element.id);
    });
    print('number of users==========');
    print(tempList.length);
    return tempList.length;
  }

  Future<int> getNumberOfMale(startDate, endDate) async {
    QuerySnapshot snap = await _firestore
        .collection('user')
        .where("gender", isEqualTo: 'male')
        .where('createdDate', isLessThanOrEqualTo: endDate)
        .where('createdDate', isGreaterThanOrEqualTo: startDate)
        .get();
    print('number of Males==========');
    print(snap.docs.length);
    return snap.docs.length;
  }

  Future<int> getNumberOfFemale(startDate, endDate) async {
    QuerySnapshot snap = await _firestore
        .collection('user')
        .where("gender", isEqualTo: 'female')
        .where('createdDate', isLessThanOrEqualTo: endDate)
        .where('createdDate', isGreaterThanOrEqualTo: startDate)
        .get();
    print('number of Females==========');
    print(snap.docs.length);
    return snap.docs.length;
  }

  Future<List<String>> getAges(startDate, endDate) async {
    List<String> tempList = [];

    List<String> tempAge = [];

    QuerySnapshot snap = await _firestore
        .collection('user')
        .where('createdDate', isLessThanOrEqualTo: endDate)
        .where('createdDate', isGreaterThanOrEqualTo: startDate)
        .get();

    snap.docs.forEach((element) {
      tempList.add(element.data()['dob']);
    });

    tempList.forEach((element) {
      tempAge.add(calculateAge(DateTime.parse(element)));
    });

    return tempAge;
  }

  String calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age.toString();
  }

  Future<List<DateTime>> getCreatedDate() async {
    List<DateTime> tempList = [];

    QuerySnapshot snap = await _firestore.collection('user').get();

    snap.docs.forEach((element) {
      tempList.add(element.data()['dateOfjoin'].toDate());
    });

    return tempList;
  }
}
