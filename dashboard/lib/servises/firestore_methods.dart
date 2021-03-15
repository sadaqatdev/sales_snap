import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sales_snap_dashboard/models/m_user.dart';
import 'package:sales_snap_dashboard/models/notification_model.dart';
import 'package:sales_snap_dashboard/models/save_list_model.dart';

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

  Future<List<SaveListModel>> getUserBuyItems(uid) async {
    List<SaveListModel> tempList = [];

    QuerySnapshot _snap =
        await _collection.doc(uid).collection('buy_products').get();

    if (_snap?.docs?.isNotEmpty ?? false)
      _snap.docs.forEach((qSnap) {
        if (qSnap.exists) tempList.add(SaveListModel.fromMap(qSnap.data()));
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

  Future<List<SaveListModel>> getBuyedItems() async {
    List<SaveListModel> _list = [];
    QuerySnapshot qsnap = await _firestore.collection('user').get();

    qsnap.docs.forEach((element) async {
      QuerySnapshot querySnapshot = await _firestore
          .collection('user_products')
          .doc(element.id)
          .collection('buy_products')
          .get();

      querySnapshot.docs.forEach((element) {
        _list.add(SaveListModel.fromMap(element.data()));
      });
    });

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
}
