import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:farsilingo/services/database.dart';
import 'package:farsilingo/services/user.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

var _bgColor = Color.fromARGB(255, 153, 226, 101);
var _menuColor = Color.fromARGB(255, 169, 220, 153);


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
        elevation: 8.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Dictionary',
            onPressed: () => print('yet not ready'),
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Text('Welcome To farsilingo'),
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: _bgColor,
        curve: Curves.linearToEaseOut,
        children: [
          SpeedDialChild(
            backgroundColor: _menuColor,
            child: Icon(Icons.info),
            label: 'About us',
            onTap: () => print('About')
          ),
          SpeedDialChild(
            backgroundColor: _menuColor,
            child: Icon(Icons.settings),
            label: 'Settings',
            onTap: () async{
              print(await DBKun.db.getVersion());
            }
          ),
          SpeedDialChild(
            backgroundColor: _menuColor,
            child: Icon(Icons.account_circle),
            label: 'Account',
            onTap: () async{
              List<User> userList = await DBKun.db.getAllUsers();
              print(userList.length);
            }
          ),
        ],
      )
    );
  }

}