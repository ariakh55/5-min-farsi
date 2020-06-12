import 'package:flutter/material.dart';

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
                      labelText: 'Password | رمز عبور'
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
                FlatButton(
                  child: Text(
                    'SignIn | ورود',
                    style: _btnStyle,
                  ),
                  textColor: _bgColor,
                  onPressed: (){
                    print('logged in ${username.text} , $lang');
                  },
                ),
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
                  onPressed: (){
                    print('${name.text} aka ${username.text} signed up , $lang');
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
                  setState(() => print('state setted!!'));
                  isLogin = !isLogin;
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}