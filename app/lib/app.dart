import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sales_snap/utils/theme/app_theme.dart';
import 'views/pages/account/login_signup_tabs.dart';

//  await Firebase.initializeApp();
//   await GetStorage().initStorage;

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.themeData,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (context, snap) {
          Settings(persistenceEnabled: true);
          if (snap.hasData) {
            FirebaseAuth auth = FirebaseAuth.instance;
            return auth.currentUser == null ? LoginSignUp() : BottomAppBar();
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
