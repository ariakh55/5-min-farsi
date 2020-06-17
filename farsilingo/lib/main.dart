import 'package:flutter/material.dart';
import 'package:farsilingo/pages/exam.dart';
import 'package:farsilingo/pages/tips.dart';
import 'package:farsilingo/pages/home.dart';
import 'package:farsilingo/pages/loading.dart';
import 'package:farsilingo/include/examResault.dart';
import 'package:farsilingo/pages/firsttime/welcome.dart';

void main(){
  runApp(MaterialApp(
      title: 'Farsilingo',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => Home(),
        '/welcome': (context) => Welcome(),
        '/tips': (context) => Tips(),
        '/exam': (context) => Exam(),
        'res': (context) => Resualt(),
      },
      //home: FarsiCheck(),
      theme: ThemeData(
        //primaryColor: Colors.white,
        primaryIconTheme: IconThemeData(
          color: Colors.white
        )
      ),
    )
  );
}