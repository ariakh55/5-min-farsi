import 'dart:async';
import 'dart:io';

import 'package:farsilingo/services/question.dart';
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

    return await openDatabase(path, readOnly: false);
  }

  //System Commands
  getVersion() async{
    final db = await database;
    return (await db.rawQuery('Select sqlite_version()')).first.values.first;
  }

  //User section
  newUser(User newUser) async{
    final db = await database;
    var res = await db.insert("PersonalInfo", newUser.toMap());
    return res;
  }

  login(String username, String password) async{
    final db = await database;
    var res = await db.query("PersonalInfo", where: 'UserName = ?1 and PassWord = ?2', 
      whereArgs: [username,password]);
    return res.isNotEmpty ? res.map((x) => User.fromMap(x)).toList() : []; 
  }

  getUser(String username) async{
    final db = await database;
    var res = await db.query("PersonalInfo", where: 'UserName = ?', 
      whereArgs: [username]);
    return res.isNotEmpty ? res.map((x) => User.fromMap(x)).toList() : [];
  }

  selectUser(String username) async{
    final db = await database;
    var res = await db.query("PersonalInfo", where: 'UserName = ?', 
      whereArgs: [username], columns: ['UserName','Progress','XP']);
    return res.isNotEmpty ? res.map((x) => User.fromMap(x)).toList() : []; 
  }

  updateUser(String username,int xp, int progress) async{
    final db = await database;
    await db.update('PersonalInfo', {'Progress': progress, 'XP': xp},
      where: 'UserName = ?', whereArgs: [username]);
  }

  insertUser(User user) async{
    final db = await database;
    await db.insert('PersonalInfo', user.toMap());
  }

  getAllUsers() async{
    final db = await database;
    var res = await db.query("PersonalInfo");
    List<User> list = res.isNotEmpty ? res.map((x) => User.fromMap(x)).toList() : [];
    return list;
  }

  //Questions section
  getQuestions(int id) async{
    final db = await database;
    var res = await db.query("Questions", where: "Lid = ?", whereArgs: [id]);
    List<Question> list = res.isNotEmpty ? res.map((x) => Question.fromMap(x)).toList() : [];
    return list;
  }

}
