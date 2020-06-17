import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

var _bgColor = Color.fromARGB(255, 153, 226, 101);
var _menuColor = Color.fromARGB(255, 169, 220, 153);


class Tips extends StatefulWidget{
  @override
  createState() => _TipsState();
}

class _TipsState extends State<Tips> {
  Map data = {};
  var controller = ScrollController();

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext ctx){
    data = ModalRoute.of(ctx).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(data['name']),
        backgroundColor: _bgColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder(
          future: rootBundle.loadString('assets/Content/${data['lang']}/${data['lesson']}.md'),
          builder: (context,snapshot){
            if(snapshot.hasData)
              return Markdown(
                padding: const EdgeInsets.all(16),
                controller: controller,
                data: snapshot.data,
              );

              return CircularProgressIndicator();
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        backgroundColor: _menuColor,
        onPressed: () => controller.animateTo(0,
          duration: Duration(seconds: 1), curve: Curves.easeOut),
      ),
    );
  }
}