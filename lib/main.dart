// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_snap/utils/extract/extract.dart';
import 'app.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage().initStorage;
  Settings(persistenceEnabled: true);

  final response = await http.Client()
      .get("https://uk.bookshop.org/books/girl-a/9780008389055?aid=896");

  if (response.statusCode == 200) {
    getImage(response.body);
  }

  runApp(App());
}
