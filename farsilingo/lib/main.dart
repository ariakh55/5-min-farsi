import 'package:flutter/material.dart';
import 'package:farsilingo/pages/loading.dart';
import 'package:farsilingo/pages/home.dart';

void main(){
  runApp(MaterialApp(
    title: 'Farsilingo',
    debugShowCheckedModeBanner: false,
    // initialRoute: '/home',
    // routes: {
    //   '/': (context) => Loading(),
    //   '/home': (context) => Home()
    // },
    home: Home(),
    theme: ThemeData(
      primaryIconTheme: IconThemeData(
        color: Colors.white
      )
    ),
  ));
}