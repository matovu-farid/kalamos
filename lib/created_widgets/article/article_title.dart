import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:writers_app/model/model.dart';

import 'article.dart';
class ArticleTitle extends StatelessWidget {
  const ArticleTitle({
    Key key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ArticleInput(
      maxLines: 2,
      labelText: 'Title',
      controller: Provider.of<WritersModel>(context).titleController,
    );
  }
}