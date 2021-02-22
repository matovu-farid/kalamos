import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:writers_app/created_widgets/article/save_Article.dart';
import 'package:writers_app/share.dart';

class SendArticle extends StatelessWidget{
  final String title;
  final color = Colors.blueGrey;
  final textColor = Colors.white70;

  const SendArticle({Key key, this.title}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(title),),
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               ShareWidget(

               ),
                SaveArticle()

              ]),

          ),
        )
        );
  }}