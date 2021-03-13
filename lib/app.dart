import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_snap/utils/theme/app_theme.dart';
import 'views/bottom_navigation.dart';
import 'views/pages/account/login_signup_tabs.dart';

//  await Firebase.initializeApp();
//   await GetStorage().initStorage;

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  GetStorage loginInfo;

  initState() {
    initStorage();
    super.initState();
  }

  initStorage() async {
    await GetStorage().initStorage.then((value) {
      loginInfo = GetStorage();
      if (mounted) {
        setState(() {});
      }
    });
  }

  Widget build(BuildContext context) {
    String isLogin = loginInfo?.read('isLogin');
    return GetMaterialApp(
      theme: AppTheme.themeData,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (context, snap) {
          Settings(persistenceEnabled: true);
          if (snap.hasData) {
            return isLogin?.contains('yes') ?? false
                ? BottomNavBar()
                : LoginSignUp();
          }
          return Material(
            child: Container(
              color: Colors.white,
              child: Center(
                child: Text('WellCome!!!!!'),
              ),
            ),
          );
        },
      ),
    );
  }
}
