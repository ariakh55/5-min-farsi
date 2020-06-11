import 'package:flutter/material.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

var _bgColor = Color.fromARGB(255, 153, 226, 101);

class _HomeState extends State<Home>{
  
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext ctx){
    return Scaffold(
      appBar: AppBar(
        title: Text('FarsiLingo'),
        backgroundColor: _bgColor,
      ),
      body: SafeArea(
        child: Center(
          child: Text('Welcome To farsilingo'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: _bgColor,
        child: Icon(Icons.assistant),
        onPressed: () => print("Hello"),
      ),
    );
  }

}