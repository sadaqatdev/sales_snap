import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sales_snap/models/m_user.dart';
import 'package:sales_snap/models/notification.dart';
import 'package:sales_snap/models/web_details.dart';
import 'package:sales_snap/utils/login_info.dart';

class FireStoreMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference _collection;
  User _currentUser;
  LoginInfo _info = LoginInfo();
  FireStoreMethod() {
    _currentUser = _auth.currentUser;
    _collection = _firestore.collection('user_products');
  }

  Future<void> saveItems(WebDetails details) async {
    await _collection
        .doc(_currentUser.uid)
        .collection('saved_products')
        .doc()
        .set(details.toMap());
  }

  Future<List<WebDetails>> getSavedItems() async {
    List<WebDetails> tempList = [];

    QuerySnapshot _snap = await _collection
        .doc(_currentUser.uid)
        .collection('saved_products')
        .get();

    if (_snap?.docs?.isNotEmpty ?? false)
      _snap.docs.forEach((qSnap) {
        if (qSnap.exists) tempList.add(WebDetails.fromMap(qSnap.data()));
      });

    return tempList;
  }

  Future<void> buyItems(WebDetails details) async {
    await _collection
        .doc(_currentUser.uid)
        .collection('buy_products')
        .doc()
        .set(details.toMap());
  }

  Future<List<WebDetails>> getbuyItems() async {
    List<WebDetails> tempList = [];
    QuerySnapshot _snap = await _collection
        .doc(_currentUser.uid)
        .collection('buy_products')
        .get();
    if (_snap?.docs?.isNotEmpty ?? false)
      _snap.docs.forEach((qSnap) {
        if (qSnap.exists) tempList.add(WebDetails.fromMap(qSnap.data()));
      });

    return tempList;
  }

  Future<List<Notification>> getNotifications() async {
    List<Notification> tempList = [];
    QuerySnapshot _snap = await _collection
        .doc(_currentUser.uid)
        .collection('notifications')
        .get();
    if (_snap?.docs?.isNotEmpty ?? false)
      _snap.docs.forEach((qSnap) {
        if (qSnap.exists) tempList.add(Notification.fromMap(qSnap.data()));
      });

    return tempList;
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
}
