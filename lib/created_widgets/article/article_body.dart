import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:writers_app/color_button.dart';
import 'package:writers_app/model/model.dart';
import 'article.dart';

class WriteArticle extends StatelessWidget {
  const WriteArticle({
    Key key,

  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Column(
        children: [
          ArticleInput(maxLines: 1, labelText: 'title',
              controller: Provider.of<WritersModel>(context).titleController),
          Flexible(
            child: ArticleInput(
              maxLines: 100000,
              labelText: 'Body',
              controller: Provider.of<WritersModel>(context).bodyController,
            ),
          ),
        ],
      ),
    );
  }
}
