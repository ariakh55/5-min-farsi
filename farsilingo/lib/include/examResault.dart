import 'package:flutter/material.dart';
import 'package:farsilingo/services/user.dart';
import 'package:farsilingo/services/database.dart';

var _bgColor = Color.fromARGB(255, 153, 226, 101);

class Resualt extends StatelessWidget{
  Resualt({
    this.score,
    this.username,
    this.xp,
    this.progress
});

  final int score,xp,progress;
  final String username;
  bool passed;


  void _loadState(){
    passed = (score>=10) ? true : false;
  }

  @override
  Widget build(BuildContext ctx){
    _loadState();

    return Scaffold(
      backgroundColor: (passed) ? _bgColor : Colors.red,
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 300,),
            Text(
              (passed) ? 'Congrats, You passed this test' : 'Don\'t worry you can try next time',
              style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white
              ),
            ),
            SizedBox(height: 20,),
            RaisedButton(
              child: Text('Go to main menu'),
              onPressed: ()async{
                List<User> user = await DBKun.db.getUser(username);
                Navigator.pushNamedAndRemoveUntil(ctx, '/home',(route) => false, arguments: {
                  'username': user[0].username,
                  'name': user[0].name,
                  'email': user[0].email,
                  'lang': user[0].type,
                  'XP': xp,
                  'progress': progress
                });
              },
            )
          ],
        )
      ),
    );
  }
}