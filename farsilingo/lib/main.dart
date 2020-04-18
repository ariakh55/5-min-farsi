import 'package:flutter/material.dart';
import 'markdownSample.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farsilingo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Farsilingo'),
        ),
        body: ListView(
			padding: EdgeInsets.all(16),
			children: <Widget>[
				Builder(
					builder: (context) => RawMaterialButton(
						onPressed: (){
							showDialog(
								context: context,
								builder: (ctx) => CustomDiag(
									title: 'Lesson 4',
									description: 'Some text',
								)
							);
						},
						child: Icon(Icons.subject, size: 32.0,),
						shape: CircleBorder(),
						elevation: 2.0,
						fillColor: Colors.green,
						padding: const EdgeInsets.all(30),
					),
				)
			],
		),
      ),
    );
  }
}

class CustomDiag extends StatelessWidget{
	final String title, description;

	CustomDiag({
		@required this.title,
		@required this.description,
	});

	DialogContent(BuildContext context){
		return Stack(
			children: <Widget>[
				Container(
					padding: EdgeInsets.fromLTRB(85,16,85,16),
					decoration: BoxDecoration(
						color: Colors.white,
						shape: BoxShape.rectangle,
						borderRadius: BorderRadius.circular(16),
						boxShadow: [
							BoxShadow(
								color: Colors.black26,
								blurRadius: 10.0,
								offset: const Offset(0.0, 10.0)
							),
						],
					),
					child: Column(
						mainAxisSize: MainAxisSize.min,
						children: <Widget>[
							Text(
								title,
								style: TextStyle(
									fontSize: 24.0,
									fontWeight: FontWeight.w700
								),
							),
							SizedBox(height: 16.0,),
							Text(
								description,
								textAlign: TextAlign.left,
								style: TextStyle(
									fontSize: 16.0
								),
							),
							SizedBox(height: 16.0,),
							RaisedButton(
								child: Text('Tips'),
								onPressed: (){
									Navigator.push(
										context,
										MaterialPageRoute(
											builder: (ctx) => MarkdownExample(file: 'Script-L4.md')
										)
									);
								},
							),
							SizedBox(height: 10.0,),
							RaisedButton(
								child: Text('Practice'),
								onPressed: (){
									Navigator.pop(context);
								},
							),
						],
					)
				)
			],
		);
	}

	@override
	Widget build(BuildContext context){
		return Dialog(
			shape: RoundedRectangleBorder(
				borderRadius: BorderRadius.circular(16),
			),
			elevation: 0.0,
			backgroundColor: Colors.transparent,
			child: DialogContent(context),
		);
	}
}