import 'dart:io';
import 'package:farsilingo/include/customDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:farsilingo/services/database.dart';
import 'package:farsilingo/services/user.dart';


class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

var _bgColor = Color.fromARGB(255, 153, 226, 101);
var _menuColor = Color.fromARGB(255, 169, 220, 153);
var _btnStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold
);

class _HomeState extends State<Home>{
  List<Lesson> lessons = [];

  Map data = {};
  String lang;

  void _loadState(BuildContext ctx){
    data = ModalRoute.of(ctx).settings.arguments;
    lang = data['lang'];
    if(lang == 'en'){
      lessons = [
        Lesson('Orientation',1,'Orientation'),
        Lesson('Script Part 1',2,'Script-L1'),
        Lesson('Script Part 2',3,'Script-L2'),
        Lesson('Script Part 3',4,'Script-L3'),
        Lesson('Script Part 4',5,'Script-L4'),
        Lesson('Alphabet Part 1',6,'Alphabet-L1'),
        Lesson('Alphabet Part 2',7,'Alphabet-L2'),
        Lesson('How to Farsi 1',8,'How to Farsi1'),
        Lesson('How to Farsi 2',9,'How to Farsi2'),
        Lesson('How to Farsi 3',10,'How to Farsi3'),
      ];
    }else{
      lessons = [
        Lesson('درس 1',1,'Lesson1'),
        Lesson('درس 2',2,'Lesson2'),
        Lesson('درس 3',3,'Lesson3'),
        Lesson('درس 4',4,'Lesson4'),
      ];
    }
  }

  @override
  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext ctx){
    _loadState(ctx);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text('Farsilingo  '),
            Padding(
              padding: const EdgeInsets.only(top: 5.5),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
                elevation: 0.0,
                color: Colors.grey[600],
                child: Text(
                  '  DEMO  ',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                )
              ),
            )
          ],
        ),
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
        child: ListView.builder(
          itemCount: lessons.length,
          itemBuilder: (context , index) {
            return GestureDetector(
              onTap: () async{
                if(lang == 'en')
                  return;
                showDialog(
                  context: context,
                  builder: (context) => CustomDialog(
                    title: lessons[index].name,
                    description: 'Simple Description, not too long, not too short',
                    imageText: lessons[index].id.toString(),
                    name: lessons[index].name,
                    lang: data['lang'],
                    lesson: lessons[index].lesson,
                    id: lessons[index].id,
                    user: data['username']
                  )
                );
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Column(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(left: 24, right: 270,bottom: 15),
                        child: Text(
                          lessons[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                          ),
                        )
                      ),
                      Padding(padding: EdgeInsets.only(left: 24, right: 20),
                        child: LinearPercentIndicator(
                          progressColor: _menuColor,
                          backgroundColor: Colors.grey[600],
                        )
                      ),
                    ],
                  ),
                ),
              )
            );
          },
        )
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
            onTap: () {
              showDialog(
                context: ctx,
                builder: (context) =>  AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)
                  ),
                  title: Text('About US | درباره ما'),
                  content: Text('App created by Aria Khoshnood and Omid Reza Keshtkar'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        'Rate',
                        style: _btnStyle,
                      ),
                      textColor: _bgColor,
                      onPressed: () => print('Google play'),
                    ),
                    FlatButton(
                      child: Text(
                        'Dismiss',
                        style: _btnStyle,
                      ),
                      textColor: _bgColor,
                      onPressed: () => Navigator.of(context).pop(),
                    )
                  ],
                ) 
              );
            }
          ),
          SpeedDialChild(
            backgroundColor: _menuColor,
            child: Icon(Icons.settings),
            label: 'Settings',
            onTap: () => print('Settings')
          ),
          SpeedDialChild(
            backgroundColor: _menuColor,
            child: Icon(Icons.account_circle),
            label: 'Account',
            onTap: () {
              showDialog(
                context: ctx,
                builder: (context) =>  AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)
                  ),
                  title: Text('${data['name']} aka ${data['username']}'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        'Log out',
                        style: _btnStyle
                      ),
                      textColor: Colors.red,
                      onPressed: () async{
                        final dir = await getApplicationSupportDirectory();
                        var file = File('${dir.path}/.acc.dat');
                        showDialog(
                          context: ctx,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)
                            ),
                            title: Text('Are you sure?'),
                            actions: <Widget>[
                              FlatButton(
                                child: Text(
                                  'Yes',
                                  style: _btnStyle
                                ),
                                textColor: Colors.red,
                                onPressed: () async {
                                  await file.delete();
                                  Navigator.of(context).pushNamedAndRemoveUntil('/welcome',
                                    (Route<dynamic> route) => false);
                                }
                              ),
                              FlatButton(
                                child: Text(
                                  'No',
                                  style: _btnStyle
                                ),
                                textColor: Colors.greenAccent,
                                onPressed: () => Navigator.of(ctx).pop(),
                              ),
                            ]
                          )
                        );
                      },
                    ),
                    FlatButton(
                      child: Text(
                        'Dismiss',
                        style: _btnStyle
                      ),
                      textColor: _bgColor,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                  content: Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          top: 16.0,
                          bottom: 0.5,
                          left: 16.0,
                          //right: 5.0
                        ),
                        //margin: EdgeInsets.only(top: 66.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            CircularPercentIndicator(
                              radius: 66.0,
                              progressColor: _menuColor,
                              header: Text('XP'),
                              center: Text('LVL: ${data['progress']}'),
                            ), 
                            Padding(padding: const EdgeInsets.only(top: 15.0),),
                            Text('Email: ${data['email']}'),
                          ],
                        )
                      ) 
                    ],
                  )
                ) 
              );
            }
          ),
        ],
      )
    );
  }
}

class Lesson{
  final String name;
  final int id;
  final String lesson;

  Lesson(
    this.name,
    this.id,
    this.lesson,
  );
}