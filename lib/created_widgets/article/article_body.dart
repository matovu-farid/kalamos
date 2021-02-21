import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:writers_app/model/model.dart';
import 'article.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
    @required this.maxLines, this.title,
  }) : super(key: key);

  final int maxLines;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(icon: Icon(
            Icons.arrow_forward
          ), onPressed: ()=>Navigator.of(context).pushNamed('/send'))
        ],
      ),
      body: ArticleInput(
        maxLines: maxLines,
        labelText: 'Body',
        controller: Provider.of<WritersModel>(context).bodyController,
      ),
    );
  }
}
