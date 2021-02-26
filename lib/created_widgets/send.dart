import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:writers_app/created_widgets/sending_buttons/save_Article.dart';
import 'sending_buttons/share.dart';
import './sending_buttons/view_button.dart';


class SendArticle extends StatelessWidget{
  final color = Colors.blueGrey;
  final textColor = Colors.white70;

  const SendArticle({Key key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width*0.6,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShareWidget(),
              SaveArticle(),
              ViewButton()

            ]),

      ),
    );
  }}