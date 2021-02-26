import 'package:flutter/material.dart';
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
  List<Widget> listOfTiles = [];

  @override
  Widget build(BuildContext context) {
    MyDatabase db = MyDatabase();

    return Stack(
      children: [
        ViewArticles(db: db, listOfTiles: listOfTiles),
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton.extended(
              onPressed: Provider.of<WritersModel>(context,listen: false).upLoad,
              label: Text('Upload')),
        )
      ],
    );
  }
}


