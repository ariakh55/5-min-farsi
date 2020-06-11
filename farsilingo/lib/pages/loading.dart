import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget{
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading>{

  void loadMain() async{
    Navigator.pushReplacementNamed(context, '/home');
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