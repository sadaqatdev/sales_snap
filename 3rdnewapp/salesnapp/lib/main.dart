import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'utils/theme/app_theme.dart';
import 'views/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage().initStorage;
  await Firebase.initializeApp();
  runApp(GetMaterialApp( 
      theme: AppTheme.themeData,
      debugShowCheckedModeBanner: false,
      home: SpalshScreen(),
    ));
}
