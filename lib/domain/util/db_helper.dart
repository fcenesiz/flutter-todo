import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{

  static const int VERSION = 1;
  static const String DATABASE_NAME = "todos";
  static const  String PATH = "$DATABASE_NAME.db";
  static const  String CREATE_TABLE =
      "CREATE TABLE $DATABASE_NAME("
      "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
      "content TEXT,"
      "done NUM"
      ")";

  late Database db;

  Future<void> init() async{


    db = await openDatabase(
      join(await getDatabasesPath(), PATH),
      version: 1,
      onCreate: (db, version){
        return db.execute(CREATE_TABLE);
      }
    );
  }

}