import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'app.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage().initStorage;
  await Firebase.initializeApp();
  runApp(App());
} 
 