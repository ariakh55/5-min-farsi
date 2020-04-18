import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownExample extends StatelessWidget{
	final String file;
	MarkdownExample({Key key,@required this.file}): super(key: key);

	@override
	Widget build(BuildContext context){
		return Scaffold(
			appBar: AppBar(
				title: Text('Lesson 4'),
			),
			body: Container(
				padding: const EdgeInsets.all(5),
				alignment: Alignment.topLeft,
				child: FutureBuilder(
					future: DefaultAssetBundle.of(context).loadString('lesson/$file'),
					builder: (context,snapshot){
						return Markdown(data: snapshot.data);
					},
				)
			),
		);
	}
}
