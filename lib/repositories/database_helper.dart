import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sales_snap/models/web_details.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

final String tableWebDtails = 'webDetails';
final String columnId = 'id';
final String title = 'title';
final String webUrl = 'webUrl';
final String desc = 'desc';
final String price = 'price';
final String imgUrl = 'imgUrl';
final String priceNumber = 'priceNumber';
final String priceHtmlTag = 'priceHtmlTag';

class DatabaseHelper {
  static Database _database;
  static DatabaseHelper instance;
  static final _dbName = 'webDetails.db';

  DatabaseHelper._createInstance();
  factory DatabaseHelper() {
    if (instance == null) {
      instance = DatabaseHelper._createInstance();
    }
    return instance;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    var path = join(dir.path + _dbName);

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          create table $tableWebDtails ( 
          $columnId integer primary key autoincrement, 
          $title text not null,
          $webUrl text not null,
          $desc text,
          $imgUrl text,
          $price text,
          $priceHtmlTag text,
          $priceNumber text)
        ''');
      },
    );
    return database;
  }

  Future<int> setWebDetails(WebDetails alarmInfo) async {
    var db = await instance.database;
    if (db != null) {
      var result = await db.insert(tableWebDtails, alarmInfo.toMap());

      Get.showSnackbar(GetBar(
        message: title,
        duration: Duration(seconds: 2),
      ));
      return result;
    }
  }

  Future<List<WebDetails>> getWebDetails() async {
    List<WebDetails> _alarms = [];

    var db = await this.database;
    var result = await db.query(tableWebDtails);
    result.forEach((element) {
      var alarmInfo = WebDetails.fromMap(element);
      _alarms.add(alarmInfo);
    });

    return _alarms;
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    return await db
        .delete(tableWebDtails, where: '$columnId = ?', whereArgs: [id]);
  }
}
