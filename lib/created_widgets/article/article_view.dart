import 'package:flutter/material.dart';
import 'package:writers_app/created_widgets/article/bottom_send_buttons.dart';
import 'package:provider/provider.dart';
import 'package:writers_app/created_widgets/article/view_articles.dart';
import 'package:writers_app/created_classes/database.dart';
import 'package:writers_app/model/model.dart';

class ViewArticlesPage extends StatefulWidget {
  ViewArticlesPage({Key key}) : super(key: key);

  @override
  _ViewArticlesPageState createState() => _ViewArticlesPageState();
}

class _ViewArticlesPageState extends State<ViewArticlesPage> {
  //List<Widget> listOfTiles = [];

  @override
  Widget build(BuildContext context) {
    MyDatabase db = MyDatabase();

    return Stack(
      children: [
        ViewArticles(db: db),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: BottomSendButtons(type:'local'),
          ),
        )
      ],
    );
  }
}


