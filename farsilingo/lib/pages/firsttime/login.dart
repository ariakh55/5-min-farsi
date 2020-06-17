import 'package:farsilingo/services/database.dart';
import 'package:farsilingo/services/user.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Login extends StatefulWidget{
  Login(this.state, this.lang);
  final state, lang;

  @override
  createState() => _LoginState(state,lang);
}

var _bgColor = Color.fromARGB(255, 153, 226, 101);
var _menuColor = Color.fromARGB(255, 169, 220, 153);

var _txtTheme = ThemeData(
  primaryColor: _bgColor,
);

var _btnStyle = TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.bold
);

class _LoginState extends State<Login>{
  final String state, lang;
  _LoginState(this.state,this.lang);

  var username = TextEditingController();
  var name = TextEditingController();
  var passwrd = TextEditingController();
  var email = TextEditingController();

  List<Widget> _pages;


  final _controller = PageController();
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;
  bool isLogin;

  void _clearForm({String type = "log"}){
    if(type == "sign"){
      name.clear();
      email.clear();
    }
    username.clear();
    passwrd.clear();
  } 

  void _showSnackBar(BuildContext ctx, String msg, Color msgColor){
    final _scaff = Scaffold.of(ctx);
     _scaff.showSnackBar(SnackBar(
      backgroundColor: msgColor,
      content: Text(msg),
    ));
  }

  @override
  void initState(){
    super.initState();
    isLogin = (state == 'log') ? true : false;
    _pages = [
      Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(104.7, 0, 40.6, 0),
            child: Column(
              children: <Widget>[
                Theme(
                  data: _txtTheme,
                  child: TextField(
                    controller: username,
                    decoration: InputDecoration(
                      labelText: 'Username | نام کاربری'
                    ),
                  ),
                ),
                Theme(
                  data: _txtTheme,
                  child: TextField(
                    controller: passwrd,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password | رمز عبور',
                    ),
                  ),
                )
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 285, left: 275.6),
            child: Row(
              children: <Widget>[
                Builder(
                  builder: (ctx) => 
                    FlatButton(
                      child: Text(
                        'SignIn | ورود',
                        style: _btnStyle,
                      ),
                      textColor: _bgColor,
                      onPressed: () async{
                        List<User> user = await DBKun.db.login(username.text.trim(), passwrd.text.trim());
                        if(user.length>0){
                          print('logged in!');
                          _showSnackBar(ctx, 'Logged in!\tLoading....',_menuColor);
                          final Directory dir = await getApplicationSupportDirectory();
                          var file = File('${dir.path}/.acc.dat');
                          String json = '${user[0].username},${user[0].password}';
                          await file.writeAsString(json);
                          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false ,arguments: {
                            'username': user[0].username,
                            'name': user[0].name,
                            'email': user[0].email,
                            'lang' : user[0].type,
                            'XP': user[0].xp,
                            'progress': user[0].progress
                          });
                        }else{
                          print('Username or Password is incorrect!');
                          _showSnackBar(ctx, 'Username or Password is incorrect!',Colors.red);
                        }
                        _clearForm(type: "log");
                      },
                    )
                )
              ],
            )
          )
        ],
      ),
      Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(104.7, 0, 40.6, 0),
            child: Column(
              children: <Widget>[
                Theme(
                  data: _txtTheme,
                  child: TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      labelText: 'Full name | نام و نام خانوادگی'
                    ),
                  ),
                ),
                Theme(
                  data: _txtTheme,
                  child: TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                      labelText: 'Username | نام کاربری'
                    ),
                  ),
                ),
                Theme(
                  data: _txtTheme,
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                      labelText: 'Email | پست الکترونیک'
                    ),
                  ),
                ),
                Theme(
                  data: _txtTheme,
                  child: TextFormField(
                    controller: passwrd,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password | رمز عبور'
                    ),
                  ),
                ),
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 165, left: 265.6),
            child: Column(
              children: <Widget>[
                FlatButton(
                  child: Text(
                    'SignUp | ثبت نام',
                    style: _btnStyle,
                  ),
                  textColor: _bgColor,
                  onPressed: () async{
                    try{
                    User user = User(
                      name: name.text.trim(),
                      username: username.text.trim(),
                      email: email.text.trim(),
                      password: passwrd.text.trim(),
                      progress: 0,
                      xp: 0,
                      type: lang
                    );
                    await DBKun.db.insertUser(user);
                    final Directory dir = await getApplicationSupportDirectory();
                    var file = File('${dir.path}/.acc.dat');
                    String json = '${user.username},${user.password}';
                    await file.writeAsString(json);
                    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false , arguments: {
                            'username': user.username,
                            'name': user.name,
                            'email': user.email,
                            'lang' : user.type,
                            'XP': user.xp,
                            'progress': user.progress
                          });
                    }catch (_) {
                      print('Username exists!');
                      return;
                    }
                    print('User added!');
                    _clearForm(type: "sign");
                  }
                ),
              ],
            )
          )
        ],
      ),
    ];
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
          child: Column(
            children: <Widget>[
              Padding(padding: const EdgeInsets.only(top: 37.0),),
              Image(image: AssetImage('assets/startlogo.png'),),
              Flexible(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  itemBuilder: (BuildContext context, int index){
                    index = (isLogin) ? 0 : 1;
                    return SingleChildScrollView(
                      child: _pages[index],
                     // physics: FixedExtentScrollPhysics(),
                    );
                  },
                  physics: NeverScrollableScrollPhysics(),
                ),
              ),
              FlatButton(
                child: Text(
                  (isLogin) ? 'SignUp NOW! | !همین حالا ثبت نام کنید' : 'Have an account? | حساب کاربری دارید؟',
                  style: TextStyle(
                    fontSize: 14.0
                  ),
                ),
                textColor: Colors.grey[600],
                onPressed: (){
                  if(isLogin) _controller.nextPage(duration: _kDuration, curve: _kCurve);
                  else _controller.previousPage(duration: _kDuration, curve: _kCurve);
                  isLogin = !isLogin;
                  username.clear();
                  passwrd.clear();
                  setState(() => print('state setted!!'));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}