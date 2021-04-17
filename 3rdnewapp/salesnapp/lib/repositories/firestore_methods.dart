import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_snap/models/buy_button_click.dart';
import 'package:sales_snap/models/buy_model.dart';
import 'package:sales_snap/models/intrest.dart';
import 'package:sales_snap/models/m_user.dart';

import 'package:sales_snap/models/notification_model.dart';
import 'package:sales_snap/models/save_product_model.dart';
import 'package:sales_snap/utils/login_info.dart';

class FireStoreMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference _collection;
  User _currentUser;
  LoginInfo _info = LoginInfo();
  GetStorage strageTemp;
  FireStoreMethod() {
    _currentUser = _auth.currentUser;
    _collection = _firestore.collection('user_products');
    strageTemp = GetStorage();
  }
  Future<List<Intrest>> getIntersts()async{
    List<Intrest> tempList=[];
   QuerySnapshot qsnap=await _firestore.collection('intrest').get();
   qsnap.docs.forEach((element) {
      tempList.add(Intrest.fromMap(element.data()));
    });
    return tempList;
  }
  Future<bool> saveItems(SavedProductModel details) async {
    QuerySnapshot qsnap = await _collection
        .doc(_currentUser.uid)
        .collection('saved_products')
        .where('webUrl', isEqualTo: details.webUrl)
        .get();
    if (qsnap.docs.length > 0) {
     return false;
    } else {
       await _collection
          .doc(_currentUser.uid)
          .collection('saved_products')
          .doc()
          .set(details.toMap());
      return true;
    }
  }
 
  Future<List<SavedProductModel>> getSavedItems() async {
    List<SavedProductModel> tempList = [];

    QuerySnapshot _snap = await _collection
        .doc(_currentUser.uid)
        .collection('saved_products').orderBy('timestamp',descending: true)
        .get();

    if (_snap?.docs?.isNotEmpty ?? false)
      _snap.docs.forEach((qSnap) {
        if (qSnap.exists)
          tempList.add(SavedProductModel.fromMap(qSnap.data(), qSnap.id));
      });

    return tempList;
  }

  Future<String> deleteItem(index) async {
    _collection
        .doc(_currentUser.uid)
        .collection('saved_products')
        .doc(index)
        .delete();

    return 'ok';
  }

  Future<String> deleteBuyItem(index) async {
    _collection
        .doc(_currentUser.uid)
        .collection('buy_products')
        .doc(index)
        .delete();

    return 'ok';
  }

  Future<String> deletePriceSaving(index) async {
    _collection
        .doc(_currentUser.uid)
        .collection('buy_products')
        .doc(index)
        .delete();

    return 'ok';
  }

  Future<void> setbuyItems(BuyModel details) async {
    await _collection
        .doc(_currentUser.uid)
        .collection('buy_products')
        .doc()
        .set(details.toMap());
  }

  Future<List<BuyModel>> getbuyItems() async {
    List<BuyModel> tempList = [];
    QuerySnapshot _snap = await _collection
        .doc(_currentUser.uid)
        .collection('buy_products')
        .get();
    if (_snap?.docs?.isNotEmpty ?? false)
      _snap.docs.forEach((qSnap) {
        if (qSnap.exists)
          tempList.add(BuyModel.fromMap(qSnap.data(), qSnap.id));
      });

    return tempList;
  }

  updateNotificationSatus(docId)async{
    _firestore
        .collection("user_notification")
        .doc(_currentUser.uid)
        .collection(_currentUser.uid).doc(docId).update({'status':'view'},);
  }

  Future<void> buyButtonClick() async {
    String location = strageTemp.read('location');

    BuyButtonClick buyButtonClick = BuyButtonClick(
        location: location, timestamp: Timestamp.now(), uid: _currentUser.uid);

    _firestore.collection('buyButtonClick').doc().set(buyButtonClick.toMap());
  } 

  Future<void> sucessfullBuy() async {
    String location = strageTemp.read('location');

    BuyButtonClick buyButtonClick = BuyButtonClick(
        location: location, timestamp: Timestamp.now(), uid: _currentUser.uid);

    _firestore.collection('Successfully').doc().set(buyButtonClick.toMap());
  }

  Stream<List<NotificationModel>> getNotification() {
    return _firestore
        .collection("user_notification")
        .doc(_currentUser.uid)
        .collection(_currentUser.uid)
        .orderBy("timestamp", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<NotificationModel> retVal = [];
      query.docs.forEach((element) {
        retVal.add(NotificationModel.fromMap(element.data(), element.id));
        print('-------------------');
        print(element.data());
      });
      return retVal;
    });
  }

  Stream<List<BuyModel>> getPreviousMonth() {
    var date = DateTime.now();
    var prevMonth = new DateTime(date.year, date.month - 1, date.day);
    return _collection
        .doc(_currentUser.uid)
        .collection('buy_products')
        .where('timestamp', isEqualTo: new Timestamp.fromDate(prevMonth))
        .snapshots()
        .map((query) {
      return query.docs.map((doc) {
        return BuyModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  Stream<List<BuyModel>> getPreviousMonthTwo() {
    var date = DateTime.now();
    var prevMonth = new DateTime(date.year, date.month - 2, date.day);
    return _collection
        .doc(_currentUser.uid)
        .collection('buy_products')
        .where('timestamp',
            isGreaterThanOrEqualTo: new Timestamp.fromDate(prevMonth))
        .snapshots()
        .map((query) {
      return query.docs.map((doc) {
        return BuyModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  Stream<List<BuyModel>> getCurrentMonth() {
    var date = DateTime.now();

    return _collection
        .doc(_currentUser.uid)
        .collection('buy_products')
        .where('timestamp', isEqualTo: new Timestamp.fromDate(date))
        .snapshots()
        .map((query) {
      return query.docs.map((doc) {
        return BuyModel.fromMap(doc.data(), doc.id);
      }).toList();
    });
  }

  Future<String> deleteNotifications(index) async {
  await  _firestore
        .collection("user_notification")
        .doc(_currentUser.uid)
        .collection(_currentUser.uid)
        .doc(index)
        .delete();

    return 'ok';
  }

  Future<String> setUser(MUser user) async {
    CollectionReference _collection = _firestore.collection('user');
    await _collection.doc(_currentUser.uid).set(user.toMap());
    _info.setLoginInfo(_auth.currentUser);
    return 'ok';
  }

  Future<String> updateUser(MUser user) async {
    CollectionReference _collection = _firestore.collection('user');
    await _collection.doc(_currentUser.uid).update(user.toMap());

    return 'ok';
  }

  Future<MUser> getMuser() async {
    CollectionReference _collection = _firestore.collection('user');
    DocumentSnapshot _snap = await _collection.doc(_currentUser.uid).get();
    MUser user = MUser.fromMap(_snap.data());
    return user;
  }

  Future<void> setUserNotification({NotificationModel data, String uid}) async {
    await _firestore
        .collection('user_notification')
        .doc(uid)
        .collection(uid)
        .doc()
        .set(data.toMap());
  }
}