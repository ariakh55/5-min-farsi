import 'package:farsilingo/services/database.dart';
import 'package:flutter/material.dart';

var _bgColor = Color.fromARGB(255, 153, 226, 101);
var _menuColor = Color.fromARGB(255, 169, 220, 153);

class CustomDialog extends StatelessWidget{
  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.lesson,
    @required this.name,
    @required this.lang,
    @required this.id,
    @required this.user,
    this.imageText,
  });
  final String title,description,imageText;
  final String lesson,lang,name,user;
  final int id;

  dialogContent(BuildContext ctx){
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: 66.0 + 16.0,
            bottom: 16.0,
            left: 16.0,
            right: 16.0
          ),
          margin: EdgeInsets.only(top: 66.0),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0)
              )
            ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700
                )
              ),
              SizedBox(height: 16.0,),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0,),
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: FlatButton(
                  onPressed: () {
                    print(lesson);
                    Navigator.pushNamed(ctx, '/tips', arguments: {
                      'name': name,
                      'lang': lang,
                      'lesson': lesson
                    });
                  },
                  child: Text('Tips | نکات'),
                ),
              ),
              SizedBox(height: 4.5,),
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: FlatButton(
                  onPressed: () async{
                      Navigator.pushNamed(ctx, '/exam', arguments: {
                      'questions': await DBKun.db.getQuestions(id),
                      'user': await DBKun.db.selectUser(user)
                    });                 
                  },
                  child: Text('Test | آزمون'),
                ),
              )
            ],
          )
        ),
        Positioned(
          left: 16.0,
          right: 16.0,
          child: CircleAvatar(
            backgroundColor: _bgColor,
            child: (imageText.length>0) ? Text(imageText,style: TextStyle(fontSize: 24.0),) : null,
            radius: 66.0,
          ),
        ) 
      ],
    );
  }

  @override
  Widget build(BuildContext ctx){
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0)
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(ctx),
    );
  }
}