import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:farsilingo/include/examResault.dart';
import 'package:farsilingo/services/question.dart';
import 'package:farsilingo/services/database.dart';
import 'package:farsilingo/services/user.dart';
import 'package:flutter/material.dart';

class Exam extends StatefulWidget{
  @override
  createState() => _ExamState();
}

List<Question> questions;
var index;
String _value;
var _bgColor = Color.fromARGB(255, 153, 226, 101);
var _menuColor = Color.fromARGB(255, 169, 220, 153);
var _listStyle = TextStyle(
  fontSize: 17.5,
  fontWeight: FontWeight.w600
);

class _ExamState extends State<Exam>{

  Route _createRoute(String user, int xp, int score, int progress) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => Resualt(
        score: score,
        username: user,
        xp: xp,
        progress: progress,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Map data = {};
  User userStats;
  var counter;
  int progress = 0,xp = 0, lp = 0;

  void _loadState() {
    userStats = data['user'][0];
    questions = data['questions'];
    questions.shuffle();
    questions = questions.sublist(0,5);
  }

  @override
  void initState(){
    super.initState();
    index = 0;
    counter = 1;
  }

  @override
  Widget build(BuildContext ctx){
    data = ModalRoute.of(ctx).settings.arguments;
    _loadState();

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.close),
                    tooltip: 'Close test',
                    onPressed: () => Navigator.pop(ctx),
                  ),
                  LinearPercentIndicator(
                    width: 320,
                    lineHeight: 15,
                    percent: (counter*100/5)/100,
                    progressColor: _bgColor,
                  )
                ],
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0)
                ),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  width: 360,
                  height: 160,
                  child: Text(
                    questions[index].qname,
                    style: TextStyle(
                      fontSize: 19.5,
                      fontWeight: FontWeight.w700
                    )
                  ),
                ),
              ),
              Choice(),
              SizedBox(height: 85,),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(width: 266,height: 65,),
                    FlatButton(
                      color: _bgColor,
                      child: Text(
                        (index < 4) ? 'NEXT' : 'DONE', 
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async{
                        if(questions[index].qanswer.contains(_value)){
                          progress+=questions[index].score;
                          switch (counter) {
                            case 1:
                              lp += 4;
                              break;
                            case 2:
                              lp += 3;
                              break;
                            case 3:
                              lp += 3;
                              break;
                            case 4:
                              lp += 5;
                              break;
                            case 5:
                              lp += 5;
                              break;
                          }
                        }else if(_value == ""){
                          progress += 0;
                          lp += 0;
                        }
                        _value = "";
                        if(index >= 4){
                          if(lp>=10){
                            progress += userStats.progress;
                            xp = userStats.xp;
                            if(xp == 0)
                              xp++;
                            int maxXP = xp * 10;
                            int sub = progress - maxXP;
                            while(sub<0){
                              xp++;
                              maxXP = xp * 10;
                              sub -= maxXP;
                            }
                            await DBKun.db.updateUser(userStats.username, xp, progress);
                          }
                          Navigator.of(ctx).push(_createRoute(userStats.username,xp,lp,progress));
                        }else{
                          ++index;
                          counter++;
                        }
                        setState(() {});
                      }
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}

class Choice extends StatefulWidget{
  @override
  createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice>{
  @override
  Widget build(BuildContext ctx){
    return Container(
      width: 360,
      height: 260,
      child: ListView.builder(
        itemCount: questions[index].choices.length,
        itemBuilder: (context, i){
          return RadioListTile<String>(
            title: Text(questions[index].choices[i], style: _listStyle),
            value: questions[index].choices[i],
            groupValue: _value,
            activeColor: _menuColor,
            onChanged: (String value) {
              setState(() {
                _value = questions[index].choices[i];
              });
            },
          );
        },
      ),
    );
  }
}
/*  */