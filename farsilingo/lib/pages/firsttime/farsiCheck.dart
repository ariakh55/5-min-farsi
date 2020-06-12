import 'package:flutter/material.dart';
import 'package:farsilingo/pages/firsttime/login.dart';

class FarsiCheck extends StatelessWidget{
  final _bgColor = Color.fromARGB(255, 153, 226, 101);
  final _menuColor = Color.fromARGB(255, 169, 220, 153);

  Route _createRoute(String type, {String lang = 'N/A'}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Login(type , lang),
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
      backgroundColor: _bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/whitebg.png'),
              fit: BoxFit.cover
            )
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 196,),
              child: Column(
                children: <Widget>[
                  Image(image: AssetImage('assets/startlogo.png')),
                  Text(
                    "    آیا فارسی بلدید؟\nDo you know Farsi?",
                    style: TextStyle(
                      fontSize:  21.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 23,),
                  SizedBox(width: 240, height: 45,
                    child: RaisedButton(
                      child: Text('YES | بله', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                      color: _menuColor,
                      onPressed: (){
                        Navigator.of(ctx).push(_createRoute('sign' , lang: 'fa'));
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(width: 240, height: 45,
                    child: RaisedButton(
                      child: Text('I don\'t know Farsi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                      color: _menuColor,
                      onPressed: (){
                        Navigator.of(ctx).push(_createRoute('sign' , lang: 'en'));
                      },
                    ),
                  ),
                  SizedBox(height: 112,),
                  FlatButton(
                    child: Text(
                      'Have an account? | حساب کاربری دارید؟',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal
                      ),
                    ),
                    onPressed: (){
                      Navigator.of(ctx).push(_createRoute('log'));
                    },
                  )
                ],
              ),
            )
          )
        ),
      ),
    );
  }
}