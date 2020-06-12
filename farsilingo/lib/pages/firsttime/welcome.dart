import 'package:farsilingo/pages/firsttime/farsiCheck.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget{
  final _menuColor = Color.fromARGB(255, 169, 220, 153);

  Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => FarsiCheck(),
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

  @override
  Widget build(BuildContext ctx){
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.fromLTRB(260, 55.0, 30.0, 0),
                    child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      "خوش آمدید!",
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 68),
                  child: Image(
                    image: AssetImage('assets/welcome.png'),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Text('en'),
                      ),
                      Text(
                        "  This app helps you to learn Farsi\n  in the shortest time",
                        style: TextStyle(
                          fontSize: 16.0
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 36.0, 0, 0),
                  child: Row(
                    textDirection: TextDirection.rtl,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Text('  فا')
                      ),
                      Text(
                        "                    این برنامه به شما کمک خواهد کرد\nتا فارسی را در سریع ترین زمان ممکن یاد بگیرید",
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  )
                )
              ],
            ),
          ),
          SizedBox(height: 85,),
          Container(
            color: _menuColor,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(width: 266,height: 65,),
                FlatButton(
                  color: _menuColor,
                  child: Text('DONE', style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    Navigator.of(ctx).push(_createRoute());
                  }//=> Navigator.pushReplacementNamed(ctx, '/first/check'),
                )
              ],
            ),
          )
        ],
      )
      
    );
  }
}