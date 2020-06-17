import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:farsilingo/services/database.dart';
import 'package:farsilingo/services/user.dart';

class Loading extends StatefulWidget{
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading>{

  void loadMain() async{
    final dir = await getApplicationSupportDirectory();
    var file = File('${dir.path}/.acc.dat');
    if(file.existsSync()){
      List<String> login = file.readAsStringSync().split(',');
      List<User> user = await DBKun.db.login(login[0], login[1]);
      if(user.length>0){
        print('Logged in!!');
        Navigator.pushReplacementNamed(context, '/home', arguments: {
          'username': user[0].username,
          'name': user[0].name,
          'email': user[0].email,
          'lang' : user[0].type,
          'XP': user[0].xp,
          'progress': user[0].progress
        });
      }
    }else{
      print('First time using app');
      Navigator.pushReplacementNamed(context, '/welcome');
    }
  }

  @override
  void initState(){
    super.initState();
    loadMain();
  }

  @override
  Widget build(BuildContext ctx){
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 153, 226, 101),
      body: Center(
        child: spinkit
      ),
    );
  }

  final spinkit = SpinKitFadingCube(
    color: Colors.white,
    size: 50.0,
    duration: const Duration(milliseconds: 2500),
  );

}