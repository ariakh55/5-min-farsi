import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'user.dart';


class DBKun{
  DBKun._();
  static final DBKun db = DBKun._();
  
  static Database _database;

  Future<Database> get database async{
    if(_database != null)
      return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async{
    var dbDir = await getDatabasesPath();
    String path = join(dbDir, "Farsilingo.db");

    var dbExist = await databaseExists(path);
    if(!dbExist){
      print('Creating from assets');      
      try{
        await Directory(dirname(path)).create(recursive: true);
      }catch(_){}

      ByteData data = await rootBundle.load(join("assets","Farsilingo.db"));
      List<int> bytes = 
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);
    }else{
      print('Opening existing db');
    }

    return await openDatabase(path, readOnly: true);
  }

  newUser(User newUser) async{
    final db = await database;
    var res = await db.insert("PersonalInfo", newUser.toMap());
    return res;
  }

  getUser(String username, String password) async{
    final db = await database;
    var res = await db.query("PersonlaInfo", where: "UserName = ? and PassWord = ?", whereArgs: [username,password]);
    return res.isNotEmpty ? User.fromMap(res.first) : Null; 
  }

  getVersion() async{
    final db = await database;
    return (await db.rawQuery('Select sqlite_version()')).first.values.first;
  }

  getAllUsers() async{
    final db = await database;
    var res = await db.query("PersonalInfo");
    List<User> list = res.isNotEmpty ? res.map((x) => User.fromMap(x)).toList() : [];
    return list;
  }
}
