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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              ViewButton(text:'Upload',onPressed:Provider.of<WritersModel>(context,listen: false).upLoadMultipleArticles),
              ViewButton(text:'Delete',onPressed:Provider.of<WritersModel>(context,listen: false).delete),
            ],),
          ),
        )
      ],
    );
  }
}

class ViewButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const ViewButton({
    Key key, this.text, this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: 'View$text',
        onPressed: onPressed,
        label: Text(text));
  }
}


